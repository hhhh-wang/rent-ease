<template>
	<view class="password-container">
		<u-navbar :is-back="true" title="修改密码" :border-bottom="false">
		</u-navbar>
		<u-toast ref="uToast" />

		<!-- 密码表单 -->
		<view class="password-form">
			<view class="form-group">
				<view class="form-item">
					<view class="input-wrapper">
						<u-icon name="lock" size="36" color="#2979ff"></u-icon>
						<input
							type="password"
							v-model="oldpassword"
							placeholder="请输入原密码"
							class="input"
							focus
						/>
					</view>
				</view>
				<view class="form-item">
					<view class="input-wrapper">
						<u-icon name="lock" size="36" color="#2979ff"></u-icon>
						<input
							type="password"
							v-model="newpassword"
							placeholder="请输入新密码"
							class="input"
						/>
					</view>
				</view>
				<view class="form-item">
					<view class="input-wrapper">
						<u-icon name="lock-fill" size="36" color="#2979ff"></u-icon>
						<input
							type="password"
							v-model="password"
							placeholder="请确认新密码"
							class="input"
						/>
					</view>
				</view>
			</view>

			<!-- 密码规则提示 -->
			<view class="password-tips">
				<text class="tips-title">密码要求：</text>
				<text class="tips-item">• 长度为8-20个字符</text>
				<text class="tips-item">• 必须包含字母和数字</text>
				<text class="tips-item">• 不能与原密码相同</text>
			</view>
		</view>

		<!-- 提交按钮 -->
		<view class="submit-btn" @click="changePassword">
			确认修改
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			oldpassword: '',
			newpassword: '',
			password: '',
		}
	},
	methods: {
		changePassword() {
			// 表单验证
			if (!this.oldpassword) {
				return this.$refs.uToast.show({
					type: 'warning',
					title: '请输入原密码'
				});
			}
			if (!this.newpassword) {
				return this.$refs.uToast.show({
					type: 'warning',
					title: '请输入新密码'
				});
			}
			if (!this.password) {
				return this.$refs.uToast.show({
					type: 'warning',
					title: '请确认新密码'
				});
			}
			if (this.newpassword !== this.password) {
				return this.$refs.uToast.show({
					type: 'warning',
					title: '两次输入的密码不一致'
				});
			}
			if (this.oldpassword === this.newpassword) {
				return this.$refs.uToast.show({
					type: 'warning',
					title: '新密码不能与原密码相同'
				});
			}

			// 密码规则验证
			const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
			if (!passwordRegex.test(this.newpassword)) {
				return this.$refs.uToast.show({
					type: 'warning',
					title: '密码格式不符合要求'
				});
			}

			this.$refs.uToast.show({
				type: 'success',
				title: '修改成功',
				duration: 1500,
				complete: () => {
					uni.switchTab({
						url: '/pages/center/center'
					});
				}
			});
		},
	}
};
</script>

<style lang="scss" scoped>
.password-container {
	min-height: 100vh;
	background-color: #f5f6fa;
	padding-bottom: 40rpx;
}

.password-form {
	margin: 30rpx;

	.form-group {
		background: #fff;
		border-radius: 24rpx;
		padding: 20rpx 30rpx;
		box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);
	}

	.form-item {
		padding: 20rpx 0;
		border-bottom: 2rpx solid #f5f6fa;

		&:last-child {
			border-bottom: none;
		}

		.input-wrapper {
			display: flex;
			align-items: center;
			background-color: #f8f9fc;
			padding: 24rpx;
			border-radius: 16rpx;

			.input {
				flex: 1;
				margin-left: 20rpx;
				font-size: 28rpx;
				color: #333;

				&::placeholder {
					color: #999;
				}
			}
		}
	}
}

.password-tips {
	margin-top: 40rpx;
	padding: 30rpx;
	background: rgba(41,121,255,0.05);
	border-radius: 16rpx;

	.tips-title {
		display: block;
		font-size: 26rpx;
		color: #2979ff;
		margin-bottom: 16rpx;
		font-weight: 500;
	}

	.tips-item {
		display: block;
		font-size: 24rpx;
		color: #666;
		line-height: 1.8;
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
