<template>
	<view class="center-container">
		<!-- 个人信息卡片 -->
		<view class="user-card">
			<template v-if="userInfo">
				<view class="user-info">
					<image :src="userInfo.avatar || '/static/img/avatar.jpg'" mode="aspectFill" class="avatar"></image>
					<view class="info">
						<text class="nickname">{{userInfo.userName || '未登录'}}</text>
						<text class="phone">{{userInfo.phonenumber || '点击登录账号'}}</text>
					</view>
					<view class="edit-btn" @click="profile">
						<u-icon name="edit-pen" color="#fff" size="32"></u-icon>
					</view>
				</view>
				<!-- 用户数据概览 -->
				<view class="user-stats">
					<view class="stat-item">
						<text class="num">0</text>
						<text class="label">收藏</text>
					</view>
					<view class="stat-item">
						<text class="num">0</text>
						<text class="label">浏览</text>
					</view>
					<view class="stat-item">
						<text class="num">0</text>
						<text class="label">优惠券</text>
					</view>
				</view>
			</template>
			<template v-else>
				<view class="user-info" @click="toLogin">
					<image src="/static/img/avatar.jpg" mode="aspectFill" class="avatar"></image>
					<view class="info">
						<text class="nickname">未登录</text>
						<text class="phone">点击登录账号</text>
					</view>
				</view>
			</template>
		</view>

		<!-- 功能导航区 -->
		<view class="nav-section">
			<view class="nav-grid">
				<view class="nav-item" v-for="(item, index) in navList" :key="index" @click="clickNav(item.url)">
					<view class="icon-wrapper">
						<u-icon :name="item.icon" color="#2979ff" size="44"></u-icon>
					</view>
					<text class="nav-text">{{item.name}}</text>
				</view>
			</view>
		</view>

		<!-- 设置列表 -->
		<view class="settings-section">
			<view class="section-title">账号设置</view>
			<view class="settings-list">
				<view class="setting-item" @click="setting">
					<view class="item-left">
						<u-icon name="account" size="40" color="#2979ff"></u-icon>
						<text>实名认证</text>
					</view>
					<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
				</view>
				<view class="setting-item" @click="setting">
					<view class="item-left">
						<u-icon name="setting" size="40" color="#2979ff"></u-icon>
						<text>个人设置</text>
					</view>
					<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
				</view>
			</view>
		</view>

		<!-- 帮助与支持 -->
		<view class="settings-section">
			<view class="section-title">帮助与支持</view>
			<view class="settings-list">
				<view class="setting-item" @click="callPhoneNumber">
					<view class="item-left">
						<u-icon name="phone" size="40" color="#2979ff"></u-icon>
						<text>联系客服</text>
					</view>
					<text class="contact-number">18588966676</text>
				</view>
				<view class="setting-item" @click="problem">
					<view class="item-left">
						<u-icon name="question-circle" size="40" color="#2979ff"></u-icon>
						<text>问题反馈</text>
					</view>
					<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
				</view>
				<view class="setting-item" @click="aboutMe">
					<view class="item-left">
						<u-icon name="info-circle" size="40" color="#2979ff"></u-icon>
						<text>关于我</text>
					</view>
					<u-icon name="arrow-right" color="#c0c4cc" size="28"></u-icon>
				</view>
			</view>
		</view>

		<!-- 退出登录按钮 -->
		<view class="logout-btn" v-if="userInfo" @click="logout">
			退出登录
		</view>

		<!-- Toast 提示 -->
		<u-toast ref="uToast"></u-toast>
	</view>
</template>

<script>
	import config from "@/common/config.js" // 全局配置文件
	export default {
		data() {
			return {
				// pic:config.baseUrl+uni.getStorageSync('lifeData').vuex_user.user.avatar,
				pic:'http://127.0.0.1/profile/avatar/2021/04/27/2c7c5a9c6934323f5247c6fd4c0bdbc4.png',
				show:true,
				navList:[
				   {name:"优惠卷",icon:"coupon",url:"/pages/detail/preHouse"},
				   {name:"每日抽奖",icon:"red-packet",url:"/pages/detail/preHouse"},
				   {name:"历史租约",icon:"order",url:"/pages/detail/preHouse"},
				   {name:"我的发布",icon:"edit-pen",url:"/pages/detail/preHouse"}
				],
				userInfo: null
			}
		},
		onShow(){
			// 检查token
			this.checkToken();
			// 获取登录用户信息
			const lifeData = uni.getStorageSync('lifeData');
			if (lifeData && lifeData.vuex_user) {
				this.userInfo = lifeData.vuex_user;
			}
		},
		methods: {
			logout() {
				// 登录成功修改token与用户信息
				this.$u.vuex('vuex_token', '');
				this.$u.vuex('vuex_user', {});
				this.$u.route('/pages/login/login')
			},
			profile(){
				this.$u.route('/pages/profile/profile')
			},
			setting(){
				this.$u.route('/pages/profile/setting')
			},
			scan(){
				console.log('begin scan');
				// 允许从相机和相册扫码
				uni.scanCode({
				    success: function (res) {
				        console.log('条码类型：' + res.scanType);
				        console.log('条码内容：' + res.result);
				    }
				});
			},
			//拨打固定电话
			callPhoneNumber() {
				uni.makePhoneCall({
					phoneNumber: "18588966676",
				});
			},
			problem(){
				this.$u.route({
					url: 'pages/login/problem'
				})
			},

			checkToken(){
				// 判断Token是否有效
				let lifeData = uni.getStorageSync('lifeData');
				let token = lifeData.vuex_token
				if(!token){
					// 没有token 则跳转到登录
					return uni.reLaunch({
						url:'../login/login'
					})
				}
			},
			code(){
				this.$mytip.toast('它跑啦')
			},
			clickNav(url){
				this.$refs.uToast.show({
					type: 'info',
					title: '功能开发中...',
					iconUrl: '/static/img/developing.png',  // 可以添加一个开发中的图标
					duration: 2000,
					position: 'center'
				})
			},
			toLogin() {
				if (!this.userInfo) {
					uni.navigateTo({
						url: '/pages/login/login'
					});
				}
			},
			aboutMe() {
				uni.navigateTo({
					url: '/pages/profile/aboutMe'
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
.center-container {
	min-height: 100vh;
	background-color: #f5f6fa;
	padding-bottom: 40rpx;
}

.user-card {
	background: linear-gradient(135deg, #2979ff, #5cadff);
	padding: 40rpx 30rpx;
	color: #fff;
	position: relative;
	border-bottom-left-radius: 40rpx;
	border-bottom-right-radius: 40rpx;
	box-shadow: 0 4rpx 12rpx rgba(41,121,255,0.2);

	.user-info {
		display: flex;
		align-items: center;
		position: relative;

		.avatar {
			width: 120rpx;
			height: 120rpx;
			border-radius: 50%;
			border: 4rpx solid rgba(255,255,255,0.3);
		}

		.info {
			margin-left: 30rpx;
			flex: 1;

			.nickname {
				font-size: 36rpx;
				font-weight: bold;
				margin-bottom: 8rpx;
				display: block;
			}

			.phone {
				font-size: 26rpx;
				opacity: 0.9;
			}
		}

		.edit-btn {
			width: 64rpx;
			height: 64rpx;
			background: rgba(255,255,255,0.2);
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
		}
	}

	.user-stats {
		display: flex;
		justify-content: space-around;
		margin-top: 40rpx;
		padding-top: 30rpx;
		border-top: 2rpx solid rgba(255,255,255,0.1);

		.stat-item {
			text-align: center;

			.num {
				font-size: 36rpx;
				font-weight: bold;
				display: block;
				margin-bottom: 8rpx;
			}

			.label {
				font-size: 24rpx;
				opacity: 0.9;
			}
		}
	}
}

.nav-section {
	margin: 30rpx;
	background: #fff;
	border-radius: 24rpx;
	padding: 20rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	.nav-grid {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		gap: 20rpx;
	}

	.nav-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 20rpx 0;

		.icon-wrapper {
			width: 88rpx;
			height: 88rpx;
			background: rgba(41,121,255,0.1);
			border-radius: 22rpx;
			display: flex;
			align-items: center;
			justify-content: center;
			margin-bottom: 12rpx;
			transition: all 0.3s;

			&:active {
				transform: scale(0.95);
			}
		}

		.nav-text {
			font-size: 26rpx;
			color: #333;
		}
	}
}

.settings-section {
	margin: 30rpx;
	background: #fff;
	border-radius: 24rpx;
	padding: 20rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	.section-title {
		font-size: 28rpx;
		color: #666;
		padding: 20rpx;
		margin-bottom: 10rpx;
	}

	.settings-list {
		.setting-item {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 30rpx 20rpx;
			border-bottom: 2rpx solid #f5f6fa;

			&:last-child {
				border-bottom: none;
			}

			.item-left {
				display: flex;
				align-items: center;
				gap: 20rpx;

				text {
					font-size: 28rpx;
					color: #333;
				}
			}

			.contact-number {
				font-size: 28rpx;
				color: #2979ff;
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
</style>