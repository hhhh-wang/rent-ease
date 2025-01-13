<template>
	<view class="container">
		<!-- 顶部图片 -->
		<view class="header-image">
			<u-image 
				width="100%" 
				height="400rpx" 
				:src="src"
				mode="aspectFill"
				:radius="24"
			></u-image>
		</view>

		<!-- 表单区域 -->
		<view class="form-wrapper">
			<u-form 
				:model="model" 
				:rules="rules" 
				ref="uForm" 
				:errorType="errorType"
				:label-style="{
					color: '#333',
					fontWeight: '500'
				}"
			>
				<u-form-item 
					:label-position="labelPosition" 
					label="小区名称" 
					prop="villageName" 
					label-width="180"
					left-icon="map" 
					:leftIconStyle="{color:'#2979ff'}"
				>
					<u-input 
						:border="border" 
						type="select" 
						:select-open="selectShow" 
						v-model="model.villageName" 
						placeholder="请选择小区"
						@click="selectShow = true"
						:style="inputStyle"
					></u-input>
				</u-form-item>

				<u-form-item 
					:label-position="labelPosition" 
					label="具体地址" 
					prop="address" 
					label-width="180"
					left-icon="file-text" 
					:leftIconStyle="{color:'#2979ff'}"
				>
					<u-input 
						:border="border" 
						placeholder="请输入具体地址" 
						v-model="model.address" 
						type="text"
						:style="inputStyle"
					></u-input>
				</u-form-item>

				<u-form-item 
					:label-position="labelPosition" 
					label="门牌号" 
					prop="houseNo" 
					label-width="180"
					left-icon="home" 
					:leftIconStyle="{color:'#2979ff'}"
				>
					<u-input 
						:border="border" 
						placeholder="请输入门牌号" 
						v-model="model.houseNo" 
						type="text"
						:style="inputStyle"
					></u-input>
				</u-form-item>

				<u-form-item 
					label-width="180" 
					:label-position="labelPosition" 
					label="付款方式" 
					prop="payType"
					left-icon="rmb-circle" 
					:leftIconStyle="{color:'#2979ff'}"
				>
					<u-input 
						:border="border" 
						type="select" 
						:select-open="actionSheetShow" 
						v-model="model.payType" 
						placeholder="请选择付款方式"
						@click="actionSheetShow = true"
						:style="inputStyle"
					></u-input>
				</u-form-item>
			</u-form>

			<!-- 选择器组件 -->
			<u-select 
				mode="single-column" 
				:list="selectList" 
				v-model="selectShow" 
				@confirm="selectConfirm"
				:style="{
					borderRadius: '16rpx',
					overflow: 'hidden'
				}"
			></u-select>

			<u-action-sheet 
				:list="actionSheetList" 
				v-model="actionSheetShow" 
				@click="actionSheetCallback"
				:border-radius="16"
			></u-action-sheet>
		</view>

		<!-- 底部按钮 -->
		<view class="bottom-btn">
			<u-button 
				type="primary" 
				@click="submit"
				:custom-style="{
					width: '90%',
					height: '90rpx',
					borderRadius: '45rpx',
					border: 'none',
					background: 'linear-gradient(135deg, #2979ff, #5cadff)',
					boxShadow: '0 8rpx 16rpx rgba(41,121,255,0.2)'
				}"
			>下一步</u-button>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		let that = this;
		return {
			src: 'http://img.sccnn.com/bimg/340/02027.jpg',
			actionSheetShow: false,
			model: {
				type: 0,
				ownerName: '',
				owerPhone: '',
				villageName: '',
				villageId: '',
				address: '',
				houseNo: '',
				payType:'季付',
				createName: uni.getStorageSync('lifeData').vuex_user.userName,
				publishId: uni.getStorageSync('lifeData').vuex_user.userId,
				state: 0,
			},
			selectList: [],
			actionSheetList: [
				{
					text: '月付'
				},
				{
					text: '季付'
				},
				{
					text: '半年付'
				},
				{
					text: '年付'
				}
			],
			rules: {
				villageName: [
					{
						required: true,
						message: '请选择小区',
						trigger: ['change','blur'],
					}
				],
				payType: [
					{
						required: true,
						message: '请输选择付款方式',
						trigger: ['change','blur'],
					}
				],
			},
			border: false,
			check: false,
			selectStatus: 'close',
			selectShow: false,
			labelPosition: 'left',
			errorType: ['toast'],
			inputStyle: {
				backgroundColor: '#f8f9fc',
				padding: '24rpx',
				borderRadius: '12rpx',
			}
		};
	},
	onLoad() {
		this.findVillageList()
	},
	computed: {
		
	},
	onReady() {
		this.$refs.uForm.setRules(this.rules);
	},
	methods: {
		submit() {
			// return this.$u.route({
			// 	url: '/pages/detail/addHouse',
			// 	params: {
			// 		room: JSON.stringify(this.model)
			// 	}
			// })
			this.$refs.uForm.validate(valid => {
				if (valid) {
					console.log('验证通过');
					return this.$u.route({
						url: '/pages/detail/addHouse',
						params: {
							room: JSON.stringify(this.model)
						}
					})
				} else {
					console.log('验证失败');
				}
			});
		},
		selectConfirm(e) {
			e.map((val, index) => {
				this.model.villageName = val.label;
				this.model.villageId = val.value
				console.log(val.value);
			})
		},
		labelPositionChange(index) {
			this.labelPosition = index == 0 ? 'left' : 'top';
		},
		// 点击actionSheet回调
		actionSheetCallback(index) {
			uni.hideKeyboard();
			this.model.payType = this.actionSheetList[index].text;
		},
		findVillageList() {
			let url = "/api/houseApi/findVillageList";
			this.$u.get(url).then(result => {
				const data = result.rows
				for (let i = 0; i < data.length; i++) {
				    // 先转成字符串再转成对象，避免数组对象引用导致数据混乱
				    let item = data[i]
					this.selectList.push({
						label: item.name,
						value: item.id
					})
				}
				return data
			});
		},
	}
};
</script>

<style lang="scss" scoped>
.container {
	min-height: 100vh;
	background-color: #f5f6fa;
	padding-bottom: 180rpx;
}

.header-image {
	padding: 30rpx;
	background: #fff;
	margin-bottom: 20rpx;
}

.form-wrapper {
	background: #fff;
	padding: 40rpx 30rpx;
	border-radius: 24rpx;
	margin: 0 20rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	:deep(.u-form-item) {
		margin-bottom: 30rpx;
	}
}

.bottom-btn {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	padding: 30rpx;
	background: #fff;
	box-shadow: 0 -2rpx 12rpx rgba(0,0,0,0.05);
	display: flex;
	justify-content: center;
}
</style>
