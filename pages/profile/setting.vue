<template>
	<view class="setting-container">
		<u-navbar :is-back="true" title="设置" :border-bottom="false">
		</u-navbar>

		<!-- 设置列表 -->
		<view class="settings-section">
			<view class="settings-list">
				<view class="setting-item" @click="profile">
					<view class="item-left">
						<u-icon name="account" size="40" color="#2979ff"></u-icon>
						<text>个人信息</text>
					</view>
					<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
				</view>
			</view>
		</view>

		<view class="settings-section">
			<view class="settings-list">
				<view class="setting-item" @click="changePassword">
					<view class="item-left">
						<u-icon name="lock" size="40" color="#2979ff"></u-icon>
						<text>修改密码</text>
					</view>
					<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
				</view>
			</view>
		</view>

		<!-- 退出登录按钮 -->
		<view class="logout-btn" @click="showLogoutConfirm">
			退出登录
		</view>

		<view class="version-info">
			<text class="version-text">Version {{vuex_version}}</text>
		</view>

		<!-- 退出确认弹窗 -->
		<u-modal
			v-model="showLogoutModal"
			content="确定要退出登录吗？"
			:show-cancel-button="true"
			confirm-text="退出"
			cancel-text="取消"
			confirm-color="#ff4d4f"
			@confirm="logout"
		></u-modal>
	</view>
</template>

<style lang="scss" scoped>
.setting-container {
	min-height: 100vh;
	background-color: #f5f6fa;
	padding-bottom: 40rpx;
}

.settings-section {
	margin: 20rpx;
	background: #fff;
	border-radius: 24rpx;
	padding: 10rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	.settings-list {
		.setting-item {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 30rpx 20rpx;

			.item-left {
				display: flex;
				align-items: center;
				gap: 20rpx;

				text {
					font-size: 28rpx;
					color: #333;
				}
			}
		}
	}
}

.logout-btn {
	margin: 60rpx 30rpx;
	height: 90rpx;
	line-height: 90rpx;
	text-align: center;
	background: #fff;
	border-radius: 45rpx;
	color: #ff4d4f;
	font-size: 30rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	&:active {
		background: #f8f8f8;
	}
}

.version-info {
	position: absolute;
	bottom: 60rpx;
	left: 0;
	right: 0;
	text-align: center;

	.version-text {
		font-size: 24rpx;
		color: #999;
	}
}
</style>

<script>
export default {
	data() {
		return {
			showLogoutModal: false
		}
	},
	methods: {
		profile() {
			this.$u.route('/pages/profile/profile')
		},
		changePassword() {
			this.$u.route('/pages/profile/password')
		},
		showLogoutConfirm() {
			this.showLogoutModal = true;
		},
		logout() {
			this.$u.vuex('vuex_token', '');
			this.$u.vuex('vuex_user', {});
			
			uni.reLaunch({
				url: '/pages/index/index'
			});
		}
	}
}
</script>