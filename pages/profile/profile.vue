<template>
	<view class="profile-container">
		<u-navbar :is-back="true" title="个人信息" :border-bottom="false">
		</u-navbar>

		<!-- 头像区域 -->
		<view class="avatar-section">
			<image :src="userInfo.avatar || '/static/img/avatar.jpg'" mode="aspectFill" class="avatar"></image>
			<text class="change-text">点击更换头像</text>
		</view>

		<!-- 信息表单 -->
		<view class="info-form">
			<view class="form-group">
				<view class="form-item">
					<text class="label">用户名</text>
					<input type="text" v-model="userInfo.userName" placeholder="请输入用户名" class="input"/>
				</view>
				<view class="form-item">
					<text class="label">手机号</text>
					<input type="number" v-model="userInfo.phonenumber" placeholder="请输入手机号" class="input" disabled/>
				</view>
				<view class="form-item">
					<text class="label">真实姓名</text>
					<input type="text" v-model="userInfo.realName" placeholder="请输入真实姓名" class="input"/>
				</view>
				<view class="form-item">
					<text class="label">身份证号</text>
					<input type="idcard" v-model="userInfo.idCard" placeholder="请输入身份证号" class="input"/>
				</view>
			</view>

			<view class="form-group">
				<view class="form-item" @click="value = true">
					<text class="label">所在地区</text>
					<view class="area-select">
						<text class="area-text">{{address || '请选择所在地区'}}</text>
						<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
					</view>
				</view>
			</view>

			<view class="form-group">
				<view class="form-item">
					<text class="label">邀请码</text>
					<input type="text" v-model="inviteCode" placeholder="选填" class="input"/>
				</view>
			</view>
		</view>

		<!-- 提交按钮 -->
		<view class="submit-btn" @click="subProfile">
			保存修改
		</view>

		<city-select v-model="value" @city-change="cityChange"></city-select>
	</view>
</template>

<style lang="scss" scoped>
.profile-container {
	min-height: 100vh;
	background-color: #f5f6fa;
	padding-bottom: 40rpx;
}

.avatar-section {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 60rpx 0;
	background: #fff;
	margin-bottom: 20rpx;

	.avatar {
		width: 160rpx;
		height: 160rpx;
		border-radius: 50%;
		border: 4rpx solid rgba(41,121,255,0.1);
		margin-bottom: 20rpx;
	}

	.change-text {
		font-size: 26rpx;
		color: #2979ff;
	}
}

.info-form {
	.form-group {
		background: #fff;
		margin-bottom: 20rpx;
		padding: 0 30rpx;
	}

	.form-item {
		display: flex;
		align-items: center;
		min-height: 100rpx;
		border-bottom: 2rpx solid #f5f6fa;

		&:last-child {
			border-bottom: none;
		}

		.label {
			width: 180rpx;
			font-size: 28rpx;
			color: #333;
		}

		.input {
			flex: 1;
			font-size: 28rpx;
			color: #333;
			padding: 20rpx 0;

			&:disabled {
				color: #999;
			}
		}

		.area-select {
			flex: 1;
			display: flex;
			align-items: center;
			justify-content: space-between;

			.area-text {
				font-size: 28rpx;
				color: #333;
			}
		}
	}
}

.submit-btn {
	margin: 60rpx 30rpx;
	height: 90rpx;
	line-height: 90rpx;
	text-align: center;
	background: linear-gradient(135deg, #2979ff, #5cadff);
	border-radius: 45rpx;
	color: #fff;
	font-size: 32rpx;
	font-weight: 500;
	box-shadow: 0 8rpx 16rpx rgba(41,121,255,0.2);

	&:active {
		transform: scale(0.98);
	}
}
</style>

<script>
import citySelect from '../../components/uni/u-city-select.vue';

export default {
	components: {
		citySelect
	},
	data() {
		return {
			value: false,
			address: '',
			inviteCode: '',
			userInfo: {
				userName: '',
				phonenumber: '',
				realName: '',
				idCard: '',
				avatar: ''
			}
		}
	},
	created() {
		const lifeData = uni.getStorageSync('lifeData');
		if (lifeData && lifeData.vuex_user) {
			this.userInfo = { ...lifeData.vuex_user };
			this.address = lifeData.vuex_user.address || '';
		}
	},
	methods: {
		subProfile() {
			// 表单验证
			if (!this.userInfo.userName) {
				return this.$u.toast('请输入用户名');
			}
			
			// 更新用户信息
			this.$u.vuex('vuex_user', {
				...this.userInfo,
				address: this.address
			});
			
			this.$u.toast('修改成功');
			
			setTimeout(() => {
				uni.switchTab({
					url: '/pages/center/center'
				});
			}, 1500);
		},
		cityChange(e) {
			this.address = e.province.label + '-' + e.city.label + '-' + e.area.label;
		}
	}
}
</script>