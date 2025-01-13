<template>
	<view class="container">
		<!-- 顶部标签页 -->
		<view class="tabs-wrapper">
			<u-tabs-swiper 
				ref="tabs" 
				:list="tabList" 
				:current="current" 
				@change="change" 
				:is-scroll="false"
				swiperWidth="750"
				bar-width="120"
				:bar-style="{
					background: 'linear-gradient(135deg, #2979ff, #5cadff)',
					height: '4rpx',
					borderRadius: '4rpx'
				}"
				:active-style="{
					color: '#2979ff',
					fontWeight: 'bold',
					transform: 'scale(1.05)'
				}"
				:inactive-style="{
					color: '#666',
					transform: 'scale(1)'
				}"
			></u-tabs-swiper>
		</view>

		<!-- 内容区域 -->
		<swiper 
			class="swiper-content" 
			:current="swiperCurrent" 
			@transition="transition" 
			@animationfinish="animationfinish"
		>
			<swiper-item class="swiper-item">
				<add-all-house :model="model"></add-all-house>
			</swiper-item>
			<swiper-item class="swiper-item">
				<add-sub-house :model="model"></add-sub-house>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>

import addAllHouse from '@/components/zy/addAllHouse.vue' 
import addSubHouse from '@/components/zy/addSubHouse.vue' 
export default {
	components: {
	  addAllHouse,addSubHouse
	},
	data() {
		return {
			tabList: [{name: '整租'},{name: '合租'}],
			current: 0,
			swiperCurrent: 0,
			tabsHeight: 0,
			// 房源对象
			model: null,
		};
	},
	onLoad: function (option) {
		this.model = JSON.parse(option.room)
	},
	methods: {
		// tab栏切换
		change(index) {
			this.swiperCurrent = index;
		},
		transition({ detail: { dx } }) {
			this.$refs.tabs.setDx(dx);
		},
		animationfinish({ detail: { current } }) {
			this.$refs.tabs.setFinishCurrent(current);
			this.swiperCurrent = current;
			this.current = current;
			this.model.type = current;
			console.log(this.model.type);
		}
	}
};
</script>
<style>
	page{
		background-color: #FFFFFF;
	}
</style>
<style lang="scss" scoped>
.container {
	min-height: 100vh;
	background-color: #f5f6fa;
	display: flex;
	flex-direction: column;
}

.tabs-wrapper {
	background: #fff;
	padding: 20rpx 0;
	position: sticky;
	top: 0;
	z-index: 100;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);
}

.swiper-content {
	flex: 1;
	background: #f5f6fa;

	.swiper-item {
		height: 100%;
		padding: 30rpx;
		box-sizing: border-box;
	}
}

.tabSwiper {
	background-color: #fff;
	margin: 20rpx;
	border-radius: 16rpx;
	padding: 30rpx;
	box-shadow: 0 2rpx 12rpx rgba(0,0,0,0.05);

	.top {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 30rpx;

		.left {
			display: flex;
			align-items: center;

			.title {
				margin: 0 10rpx;
				font-size: 32rpx;
				font-weight: 600;
				color: #333;
			}
		}

		.right {
			color: #999;
			font-size: 26rpx;
		}
	}

	.item {
		display: flex;
		margin-top: 30rpx;
		background: #f8f9fc;
		padding: 20rpx;
		border-radius: 12rpx;

		.left {
			margin-right: 20rpx;

			image {
				width: 200rpx;
				height: 200rpx;
				border-radius: 12rpx;
			}
		}

		.content {
			flex: 1;

			.title {
				font-size: 28rpx;
				line-height: 1.6;
				color: #333;
			}
		}

		.right {
			padding-top: 20rpx;
			text-align: right;
		}
	}
}
</style>
