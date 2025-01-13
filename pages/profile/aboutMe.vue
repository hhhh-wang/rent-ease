<template>
	<view class="about-container">
		<u-navbar :is-back="true" title="关于我" :border-bottom="false">
		</u-navbar>

		<!-- 个人简介卡片 -->
		<view class="profile-card">
			<view class="avatar-section">
				<image src="/static/img/avatar.jpg" mode="aspectFill" class="avatar"></image>
				<text class="name">变量人生</text>
				<text class="title">全栈工程师</text>
			</view>
			<view class="stats">
				<view class="stat-item">
					<text class="num">8+</text>
					<text class="label">年开发经验</text>
				</view>
				<view class="stat-item">
					<text class="num">30+</text>
					<text class="label">项目经验</text>
				</view>
				<view class="stat-item">
					<text class="num">3+</text>
					<text class="label">年远程经验</text>
				</view>
			</view>
		</view>

		<!-- 技能标签 -->
		<view class="skills-section">
			<view class="section-title">技术栈</view>
			<view class="skills-grid">
				<view class="skill-tag" v-for="(skill, index) in skills" :key="index">
					{{skill}}
				</view>
			</view>
		</view>

		<!-- 个人介绍 -->
		<view class="intro-section">
			<view class="section-title">个人简介</view>
			<view class="intro-content">
				<text class="intro-text">· 8年+全栈开发经验，深耕深圳IT行业</text>
				<text class="intro-text">· 擅长前后端全栈开发，具备完整项目架构能力</text>
				<text class="intro-text">· 拥有3年+远程办公经验，高效的远程协作能力</text>
				<text class="intro-text">· 注重代码质量，追求工程化最佳实践</text>
				<text class="intro-text">· 良好的沟通能力和团队协作精神</text>
			</view>
		</view>

		<!-- 联系方式 -->
		<view class="contact-section">
			<view class="section-title">联系方式</view>
			<view class="contact-list">
				<view class="contact-item" @click="copyContent('email')">
					<view class="icon-wrapper">
						<u-icon name="email" color="#2979ff" size="40"></u-icon>
					</view>
					<text class="contact-text">kun64855@gmail.com</text>
					<text class="copy-text">点击复制</text>
				</view>
				<view class="contact-item" @click="copyContent('wechat')">
					<view class="icon-wrapper">
						<u-icon name="weixin-fill" color="#2979ff" size="40"></u-icon>
					</view>
					<text class="contact-text">WeChat: little_xiangzi</text>
					<text class="copy-text">点击复制</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			skills: [
				'Vue.js', 'React','Uni-app', 'Node.js','Next.js','nestJS', 'Python',
				'Java', 'Spring Boot', 'MySQL', 'MongoDB',
			]
		}
	},
	methods: {
		copyContent(type) {
			let content = type === 'email' ? 'example@email.com' : 'dev_expert';
			uni.setClipboardData({
				data: content,
				success: () => {
					this.$u.toast('复制成功');
				}
			});
		}
	}
}
</script>

<style lang="scss" scoped>
.about-container {
	min-height: 100vh;
	background-color: #f5f6fa;
	padding-bottom: 40rpx;
}

.profile-card {
	margin: 30rpx;
	background: linear-gradient(135deg, #2979ff, #5cadff);
	border-radius: 24rpx;
	padding: 40rpx;
	color: #fff;
	box-shadow: 0 4rpx 20rpx rgba(41,121,255,0.2);

	.avatar-section {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-bottom: 40rpx;

		.avatar {
			width: 160rpx;
			height: 160rpx;
			border-radius: 50%;
			border: 4rpx solid rgba(255,255,255,0.3);
			margin-bottom: 20rpx;
		}

		.name {
			font-size: 36rpx;
			font-weight: bold;
			margin-bottom: 8rpx;
		}

		.title {
			font-size: 28rpx;
			opacity: 0.9;
		}
	}

	.stats {
		display: flex;
		justify-content: space-around;
		border-top: 2rpx solid rgba(255,255,255,0.1);
		padding-top: 30rpx;

		.stat-item {
			text-align: center;

			.num {
				font-size: 40rpx;
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

.skills-section, .intro-section, .contact-section {
	margin: 30rpx;
	background: #fff;
	border-radius: 24rpx;
	padding: 30rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	.section-title {
		font-size: 32rpx;
		color: #333;
		font-weight: 500;
		margin-bottom: 20rpx;
		padding-left: 20rpx;
		border-left: 8rpx solid #2979ff;
	}
}

.skills-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 20rpx;

	.skill-tag {
		padding: 12rpx 24rpx;
		background: rgba(41,121,255,0.1);
		color: #2979ff;
		border-radius: 30rpx;
		font-size: 26rpx;
	}
}

.intro-content {
	.intro-text {
		font-size: 28rpx;
		color: #666;
		line-height: 1.8;
		display: block;
		margin-bottom: 16rpx;
	}
}

.contact-list {
	.contact-item {
		display: flex;
		align-items: center;
		padding: 20rpx 0;
		border-bottom: 2rpx solid #f5f6fa;

		&:last-child {
			border-bottom: none;
		}

		.icon-wrapper {
			width: 80rpx;
			height: 80rpx;
			background: rgba(41,121,255,0.1);
			border-radius: 20rpx;
			display: flex;
			align-items: center;
			justify-content: center;
			margin-right: 20rpx;
		}

		.contact-text {
			flex: 1;
			font-size: 28rpx;
			color: #333;
		}

		.copy-text {
			font-size: 24rpx;
			color: #2979ff;
			padding: 8rpx 20rpx;
			background: rgba(41,121,255,0.1);
			border-radius: 20rpx;
		}
	}
}
</style>
