<template>
	<view class="location-container">
		<view class="search-bar">
			<u-search 
				v-model="keyword" 
				placeholder="搜索城市" 
				:show-action="false"
				:clearabled="true"
				shape="round"
			></u-search>
		</view>

		<view class="selected">
			<view class="section-title">
				<text>已选城市</text>
				<text class="city-name" @click="selectCurrentCity('长沙市')">长沙市</text>
			</view>
		</view>

		<view class="location-section">
			<view class="location-content">
				<view class="location-left">
					<view class="location-icon">
						<u-icon name="map-fill" color="#2979ff" size="40"></u-icon>
					</view>
					<text class="location-city">长沙市</text>
				</view>
				<view class="location-right" @click="reLocation">
					<u-icon name="reload" size="28" color="#2979ff"></u-icon>
					<text class="reload-text">重新定位</text>
				</view>
			</view>
		</view>

		<view class="hot-cities">
			<view class="section-title">热门城市</view>
			<view class="cities-grid">
				<view 
					class="city-item" 
					v-for="(item,index) in hotList" 
					:key="index"
					@click="selectCity(item)"
				>{{item}}</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				keyword:"",
				hotList:['北京市','上海市','广州市','深圳市','成都市','杭州市','西安市','苏州市','武汉市','南京市','重庆市','郑州市']
			}
		},
		methods: {
			clickSearch(){
				if(this.keyword === ''){
					return uni.showToast({
						title: '关键词不能为空',
						icon: 'none'
					});
				}else{
					uni.hideKeyboard()
				}
			},
			// 自定义取消搜索事件
			cancelSearch(){
				uni.navigateBack({
					delta: 1
				})
			},
			clickSearchTag(item){
				this.keyword = item
				this.clickSearch()
			},
			reLocation() {
				uni.showLoading({
					title: '定位中...'
				});
				setTimeout(() => {
					uni.hideLoading();
					uni.showToast({
						title: '定位成功',
						icon: 'success'
					});
				}, 1500);
			},
			selectCity(city) {
				// 切换到首页并携带城市参数
				uni.switchTab({
					url: '/pages/index/index',
					success: () => {
						// 传递选中的城市数据
						uni.$emit('updateSelectedCity', {
							city: city,
							timestamp: new Date().getTime()
						});
						
						uni.showToast({
							title: `已选择${city}`,
								icon: 'success',
								duration: 1500
						});
					}
				})
			},
			// 点击已选城市也触发切换
			selectCurrentCity(city) {
				this.selectCity(city);
			}
		}
	}
</script>

<style lang="scss" scoped>
	.location-container {
		min-height: 100vh;
		background-color: #f5f6fa;
		padding: 20rpx;
	}

	.search-bar {
		padding: 20rpx 0;
		background-color: #fff;
		border-radius: 16rpx;
		margin-bottom: 20rpx;
	}

	.section-title {
		font-size: 32rpx;
		color: $u-main-color;
		font-weight: 500;
		margin-bottom: 20rpx;
		display: flex;
		align-items: center;
		
		.city-name {
			color: #2979ff;
			margin-left: 20rpx;
			font-weight: normal;
		}
	}

	.location-section {
		background: #FFFFFF;
		border-radius: 16rpx;
		padding: 30rpx;
		margin-bottom: 20rpx;
	}

	.location-content {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.location-left {
		display: flex;
		align-items: center;
		
		.location-icon {
			margin-right: 20rpx;
		}
		
		.location-city {
			font-size: 32rpx;
			color: $u-main-color;
			font-weight: 500;
		}
	}

	.location-right {
		display: flex;
		align-items: center;
		padding: 12rpx 24rpx;
		background: rgba(41, 121, 255, 0.1);
		border-radius: 30rpx;
		
		.reload-text {
			font-size: 26rpx;
			color: #2979ff;
			margin-left: 8rpx;
		}
	}

	.hot-cities {
		background: #FFFFFF;
		border-radius: 16rpx;
		padding: 30rpx;
	}

	.cities-grid {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 20rpx;
		padding: 10rpx 0;
	}

	.city-item {
		height: 80rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		background-color: #f5f6fa;
		border-radius: 12rpx;
		font-size: 28rpx;
		color: $u-content-color;
		transition: all 0.3s ease;
		
		&:active {
			background-color: #e8e8e8;
			transform: scale(0.98);
		}
	}
</style>
