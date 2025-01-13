<!-- 蓝色登录页面2 -->
<template>
	<view class="login-container">
		<!-- 顶部背景 -->
		<view class="header curved-bottom">
			<image class="bg-image" src="/static/img/login/login-bg.jpg" mode="aspectFill"></image>
			<view class="overlay"></view>
			<view class="header-content">
				<text class="title">欢迎回来</text>
				<text class="subtitle">登录后开启您的租房之旅</text>
			</view>
		</view>

		<!-- 登录表单 -->
		<view class="login-form floating-panel">
			<view class="input-group">
				<u-input
					v-model="form.phone"
					placeholder="请输入手机号"
					:border="false"
					maxlength="11"
					:customStyle="{
						backgroundColor: '#f8f9fc',
						padding: '28rpx',
						borderRadius: '16rpx',
						boxShadow: '0 2rpx 8rpx rgba(0,0,0,0.05)'
					}"
				></u-input>
			</view>

			<view class="input-group">
				<u-input
					v-model="form.password"
					type="password"
					placeholder="请输入密码"
					:border="false"
					:password="true"
					:customStyle="{
						backgroundColor: '#f8f9fc',
						padding: '28rpx',
						borderRadius: '16rpx',
						boxShadow: '0 2rpx 8rpx rgba(0,0,0,0.05)'
					}"
				></u-input>
			</view>

			<!-- 登录按钮 -->
			<view class="btn-group">
				<u-button
					type="primary"
					shape="circle"
					:customStyle="{
						width: '100%',
						height: '90rpx',
						background: 'linear-gradient(135deg, #2979ff, #5cadff)',
						boxShadow: '0 8rpx 16rpx rgba(41,121,255,0.2)',
						border: 'none'
					}"
					@click="handleLogin"
				>登 录</u-button>
			</view>

			<!-- 其他登录方式 -->
			<view class="other-login">
				<view class="login-methods">
					<view class="method-item" @click="handleSMSLogin">
						<view class="icon-wrapper">
							<u-icon name="chat" color="#2979ff" size="44"></u-icon>
						</view>
						<text>短信登录</text>
					</view>
					<view class="method-item" @click="handleWechatLogin">
						<view class="icon-wrapper">
							<u-icon name="weixin-fill" color="#2979ff" size="44"></u-icon>
						</view>
						<text>微信登录</text>
					</view>
				</view>
			</view>
		</view>

		<!-- 底部协议 -->
		<view class="agreement">
			<text class="agreement-text">登录即代表同意</text>
			<text class="link" @click="showAgreement">《用户协议》</text>
			<text class="agreement-text">和</text>
			<text class="link" @click="showPrivacy">《隐私政策》</text>
		</view>

		<!-- Toast 提示 -->
		<u-toast ref="uToast"></u-toast>
	</view>
</template>

<script>
export default {
	data() {
		return {
			form: {
				phone: '',
				password: ''
			}
		}
	},
	methods: {
		// 处理登录
		handleLogin() {
			if (!this.form.phone || !this.form.password) {
				this.$refs.uToast.show({
					type: 'warning',
					title: '请填写完整登录信息',
					duration: 2000
				})
				return
			}

			if (!this.$u.test.mobile(this.form.phone)) {
				this.$refs.uToast.show({
					type: 'warning',
					title: '请输入正确的手机号',
					duration: 2000
				})
				return
			}

			// 模拟登录
			this.$u.vuex('vuex_token', 'mock_token')
			this.$u.vuex('vuex_user', {
				id: 1,
				userName: '变量人生',
				phone: this.form.phone,
				phonenumber: this.form.phone,
				avatar: '/static/img/avatar.jpg'
			})

			// 先跳转，再显示提示
			uni.switchTab({
				url: '/pages/center/center',
				success: () => {
					// 跳转成功后显示提示
					this.$refs.uToast.show({
						type: 'success',
						title: '登录成功',
						duration: 1500
					})
				}
			})
		},

		// 短信登录
		handleSMSLogin() {
			uni.navigateTo({
				url: '/pages/login/sms-login'
			})
		},

		// 微信登录
		handleWechatLogin() {
			this.$refs.uToast.show({
				type: 'info',
				message: '微信登录功能开发中'
			})
		},

		// 显示用户协议
		showAgreement() {
			// 跳转到用户协议页面
		},

		// 显示隐私政策
		showPrivacy() {
			// 跳转到隐私政策页面
		}
	}
}
</script>

<style lang="scss" scoped>
.login-container {
	min-height: 100vh;
	background-color: #ffffff;
	position: relative;
}

.header {
	height: 400rpx;
	position: relative;
	overflow: hidden;
	&.curved-bottom {
		border-bottom-left-radius: 40rpx;
		border-bottom-right-radius: 40rpx;
	}

	.bg-image {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		z-index: 1;
	}

	.overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: linear-gradient(
			to bottom,
			rgba(0, 0, 0, 0.3),
			rgba(0, 0, 0, 0.4)
		);
		z-index: 2;
	}

	.header-content {
		position: relative;
		z-index: 3;
		height: 100%;
		padding-top: 160rpx;
		text-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
	}

	.title {
		display: block;
		color: #fff;
		font-size: 48rpx;
		font-weight: bold;
		text-align: center;
		margin-bottom: 20rpx;
		letter-spacing: 4rpx;
	}

	.subtitle {
		display: block;
		color: rgba(255, 255, 255, 0.9);
		font-size: 28rpx;
		text-align: center;
		letter-spacing: 2rpx;
	}
}

.login-form {
	padding: 50rpx 40rpx;
	margin: -60rpx 30rpx 0;
	background: #fff;
	border-radius: 24rpx;
	box-shadow: 0 4rpx 30rpx rgba(0,0,0,0.08);
	position: relative;
	z-index: 10;
	
	.input-group {
		margin-bottom: 30rpx;
		transition: all 0.3s ease;
		
		&:hover {
			transform: translateY(-2rpx);
		}
	}

	.btn-group {
		margin-top: 60rpx;
		margin-bottom: 60rpx;
	}
}

.other-login {
	.login-methods {
		display: flex;
		justify-content: center;
		gap: 120rpx;
		
		.method-item {
			display: flex;
			flex-direction: column;
			align-items: center;
			gap: 12rpx;
			
			.icon-wrapper {
				width: 88rpx;
				height: 88rpx;
				background: rgba(41,121,255,0.1);
				border-radius: 50%;
				display: flex;
				align-items: center;
				justify-content: center;
				transition: all 0.3s ease;
				
				&:active {
					transform: scale(0.95);
					background: rgba(41,121,255,0.15);
				}
			}
			
			text {
				font-size: 26rpx;
				color: #2979ff;
			}
		}
	}
}

.agreement {
	position: fixed;
	bottom: 40rpx;
	left: 0;
	right: 0;
	text-align: center;
	font-size: 24rpx;
	color: #999;
	
	.link {
		color: #2979ff;
		display: inline;
	}
}
</style>
