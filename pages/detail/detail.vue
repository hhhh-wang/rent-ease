<template>
    <view class="detail-container">
        <view>
            <u-swiper 
                :list="swiperlist" 
                :height="750" 
                mode="number" 
                effect3d 
                effect3d-previous-margin="30"
                border-radius="16"
                :interval="5000" 
                @click="clickImg"
            ></u-swiper>
        </view>
        <view class="house-info">
            <view class="item-title">{{room.villageName}} {{room.type == '整租' ? room.houseNum + room.houseHall + room.toiletNum : room.roomType+'-朝'+room.direction}}</view>
            <view class="item-price">
                <text class="price-symbol">￥</text>
                <text class="price-num">{{room.price}}</text>
                <text class="price-unit">/月</text>
            </view>
        </view>
        <view class="contact-card">
            <view class="contact-info">
                <text class="contact-title">免中介费，详情请电联管家。</text>
                <u-button 
                    type="primary" 
                    size="mini" 
                    :plain="true" 
                    @click="clickItem"
                    class="contact-btn"
                >联系管家</u-button>
            </view>
        </view>
        <view class="tags-container">
            <u-tag 
                :text="item.title" 
                mode="light" 
                type="primary"
                v-for="(item,index) in tagList" 
                :key="index"
                class="house-tag"
            />
        </view>
        <view v-if="village.wayState == 1">
            <view class="metro-info">
                <u-icon name="map" size="32" color="#2979ff" class="metro-icon"></u-icon>
                小区距地铁站步行{{village.waySpace}}米
            </view>
        </view>
        <view v-if="room.introduce">
            <view class="info-card">
                <view class="card-title">
                    <text class="title-text">房源介绍</text>
                </view>
                <view class="u-padding-top-45 item">
                    {{room.introduce}}
                </view>
            </view>
        </view>
        <view v-if="village">
            <view class="info-card">
                <view class="card-title">
                    <text class="title-text">小区介绍</text>
                </view>
                <view class="u-padding-top-45">
                    <view class="u-flex" style="justify-content: space-between;">
                        <view class="item">
                            <view class="village-info-item">
                                <text class="info-label">建筑年份：</text>
                                <text class="info-value">{{village.year}}</text>
                            </view>
                            <view class="village-info-item">
                                <text class="info-label">建筑类型：</text>
                                <text class="info-value">{{village.type}}</text>
                            </view>
                            <view class="village-info-item">
                                <text class="info-label">绿化率：</text>
                                <text class="info-value">{{village.green}}%</text>
                            </view>
                        </view>
                        <image src="https://pic4.ajkimg.com/display/xinfang/37b56b25e054493a62490343e33f0e54/245x167m.jpg"
                            class="village-image"></image>
                    </view>
                </view>
            </view>
        </view>
        <view class="info-card">
            <view class="card-title">
                <text class="title-text">周边交通</text>
            </view>
            <view class="traffic-info">
                <view class="traffic-map">
                    <image 
                        src="http://api.map.baidu.com/staticimage/v2?ak=CB9b776692623d30a148b5c5dc2b75a6&mcode=666666&center=120.213023,30.300046&width=800&height=360&zoom=18&markers=120.213023,30.300046&markerStyles=-1,http://api.map.baidu.com/images/marker_red.png,-1,23,25"
                        mode="aspectFill"
                        class="map-image"
                    ></image>
                </view>
                <view class="traffic-detail">
                    <view class="traffic-item">
                        <u-icon name="map-fill" color="#2979ff" size="32"></u-icon>
                        <text class="traffic-text">地铁1号线滨和站，步行300米</text>
                    </view>
                    <view class="traffic-item">
                        <u-icon name="car-fill" color="#5AC725" size="32"></u-icon>
                        <text class="traffic-text">公交站：滨和站，步行100米</text>
                    </view>
                    <view class="traffic-item">
                        <u-icon name="shopping-cart-fill" color="#FF9500" size="32"></u-icon>
                        <text class="traffic-text">商圈：万象城、银泰城步行可达</text>
                    </view>
                </view>
            </view>
        </view>
        <view style="position: relative;">
            <view class="info-card">
                <view class="card-title">
                    <text class="title-text">服务介绍</text>
                </view>
                <view class="service-list">
                    <view class="service-item">
                        <view class="service-icon">
                            <u-icon name="heart-fill" color="#FF9500" size="44"></u-icon>
                        </view>
                        <view class="service-content">
                            <text class="service-title">租住承诺</text>
                            <text class="service-desc">四大租住承诺，安心有保障</text>
                        </view>
                    </view>
                    <view class="service-item">
                        <view class="service-icon">
                            <u-icon name="level" color="#2979ff" size="44"></u-icon>
                        </view>
                        <view class="service-content">
                            <text class="service-title">品质保障</text>
                            <text class="service-desc">两类品质保障，入住更无忧</text>
                        </view>
                    </view>
                    <view class="service-item">
                        <view class="service-icon">
                            <u-icon name="star-fill" color="#5AC725" size="44"></u-icon>
                        </view>
                        <view class="service-content">
                            <text class="service-title">日常服务</text>
                            <text class="service-desc">两项日常服务，生活超便捷</text>
                        </view>
                    </view>
                    <view class="service-item">
                        <view class="service-icon">
                            <u-icon name="rmb-circle-fill" color="#F56C6C" size="44"></u-icon>
                        </view>
                        <view class="service-content">
                            <text class="service-title">灵活付款</text>
                            <text class="service-desc">多种付款方式，支付更灵活</text>
                        </view>
                    </view>
                </view>
            </view>
        </view>
        <view style="position: relative;">
            <view class="info-card">
                <view class="card-title">
                    <text class="title-text">您的管家</text>
                </view>
                <view class="u-padding-top-45">
                    <view class="agent-info">
                        <view class="u-m-r-10">
                            <u-avatar :src="user.avatar" size="80" class="agent-avatar"></u-avatar>
                        </view>
                        <view class="u-flex-1">
                            <view class="agent-name">{{user.userName}}</view>
                            <view class="agent-remark">{{user.remark}}</view>
                        </view>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script>
	import { houseDetail } from '@/mock/detail.js'
	import config from "@/common/config.js"
	
	export default {
		data() {
			return {
				keyword: '',
				room: {},
				swiperlist: [],
				tagList: [],
				village: {},
				user: {}
			}
		},
		onLoad: function (option) {
			let houseId = option.houseId //上个页面传递的参数。
			// 渲染当前房源信息
			this.findHouseById(houseId);
		},
		methods: {
			clickItem() {
				//拨打固定电话
				uni.makePhoneCall({
					phoneNumber: this.room.user.phonenumber,
				});
			},
			findHouseById(houseId) {
				// 从mock数据中获取房源详情
				let room = houseDetail[houseId];
				
				if (!room) {
					this.$u.toast('房源不存在');
					return;
				}

				if(room.type == 0){
					room.type = '整租'
				}else if(room.type == 1){
					room.type = '合租'
				}
				
				if(this.$u.test.isEmpty(room.houseNum)){
					room.houseNum = ''
				}
				if(this.$u.test.isEmpty(room.houseHall)){
					room.houseHall = ''
				}
				if(this.$u.test.isEmpty(room.toiletNum)){
					room.toiletNum = ''
				}
				if(this.$u.test.isEmpty(room.floor)){
					room.floor = ''
				}else{
					room.floor = room.floor + '层'
				}
				
				this.swiperlist = room.imageList.map(val=>{
					return {
						title: val.imageName,
						image: val.imgUrl
					}
				})
				
				this.tagList = room.featureList.map(val=>{
					return {
						title: val.feature,
					}
				})
				
				this.user = room.user
				this.village = room.village
				this.room = room
			},
			clickImg(index){
				let imgArr = this.swiperlist.map(val=>{
					return val.image
				})
				// 预览图片
				uni.previewImage({
					current: index,
					urls: imgArr
				});
			}
		}
	}
</script>

<style>
    /* page不能写带scope的style标签中，否则无效 */
    page {
        background-color: rgb(255, 255, 255);
    }
</style>


<style lang="scss" scoped>
    .detail-container {
        padding: 0 0 120rpx 0;
        background-color: #f8f8f8;
    }

    .house-info {
        padding: 30rpx 40rpx;
        background-color: #fff;
        border-radius: 0 0 24rpx 24rpx;
        margin-bottom: 20rpx;
    }

    .item-title {
        font-size: 36rpx;
        color: $u-main-color;
        font-weight: bold;
        line-height: 1.4;
        margin-bottom: 16rpx;
    }

    .item-price {
        display: flex;
        align-items: baseline;
        color: $u-type-warning;
        margin-top: 20rpx;

        .price-symbol {
            font-size: 28rpx;
            margin-right: 4rpx;
        }

        .price-num {
            font-size: 48rpx;
            font-weight: bold;
        }

        .price-unit {
            font-size: 24rpx;
            color: $u-tips-color;
            margin-left: 8rpx;
        }
    }

    .contact-card {
        background-color: #fff;
        padding: 24rpx 40rpx;
        margin-bottom: 20rpx;
        border-radius: 16rpx;
    }

    .contact-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .contact-title {
        font-size: 28rpx;
        color: $u-main-color;
    }

    .contact-btn {
        min-width: 160rpx;
    }

    .tags-container {
        background-color: #fff;
        padding: 24rpx 30rpx;
        margin-bottom: 20rpx;
        border-radius: 16rpx;
    }

    .house-tag {
        margin: 10rpx;
        border-radius: 8rpx;
    }

    .metro-info {
        background-color: #fff;
        padding: 24rpx 40rpx;
        margin-bottom: 20rpx;
        border-radius: 16rpx;
        display: flex;
        align-items: center;
        font-size: 28rpx;
        color: $u-content-color;
    }

    .metro-icon {
        margin-right: 16rpx;
    }

    .info-card {
        background-color: #fff;
        padding: 30rpx 40rpx;
        margin-bottom: 20rpx;
        border-radius: 16rpx;
    }

    .card-title {
        margin-bottom: 24rpx;
        
        .title-text {
            font-size: 32rpx;
            font-weight: bold;
            color: $u-main-color;
            position: relative;
            padding-left: 24rpx;
            
            &::before {
                content: '';
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 6rpx;
                height: 32rpx;
                background-color: $u-type-primary;
                border-radius: 6rpx;
            }
        }
    }

    .village-info-item {
        margin-bottom: 16rpx;
        font-size: 28rpx;
        
        .info-label {
            color: $u-tips-color;
        }
        
        .info-value {
            color: $u-content-color;
        }
    }

    .village-image {
        width: 250rpx;
        height: 200rpx;
        border-radius: 12rpx;
    }

    .agent-info {
        display: flex;
        align-items: flex-start;
        padding: 20rpx 0;
    }

    .agent-avatar {
        border: 4rpx solid #fff;
        box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.1);
    }

    .agent-name {
        font-size: 32rpx;
        font-weight: bold;
        color: $u-main-color;
        margin-bottom: 12rpx;
    }

    .agent-remark {
        font-size: 26rpx;
        color: $u-content-color;
        line-height: 1.6;
    }

    .service-list {
        padding: 20rpx 0;
    }

    .service-item {
        display: flex;
        align-items: center;
        padding: 24rpx 0;
        position: relative;
        
        &:not(:last-child)::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 1px;
            background-color: #f5f5f5;
            transform: scaleY(0.5);
        }
    }

    .service-icon {
        width: 88rpx;
        height: 88rpx;
        background: rgba(41, 121, 255, 0.1);
        border-radius: 16rpx;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 24rpx;
        
        &:nth-child(1) {
            background: rgba(255, 149, 0, 0.1);
        }
        
        &:nth-child(2) {
            background: rgba(41, 121, 255, 0.1);
        }
        
        &:nth-child(3) {
            background: rgba(90, 199, 37, 0.1);
        }
        
        &:nth-child(4) {
            background: rgba(245, 108, 108, 0.1);
        }
    }

    .service-content {
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    .service-title {
        font-size: 30rpx;
        font-weight: 500;
        color: $u-main-color;
        margin-bottom: 8rpx;
    }

    .service-desc {
        font-size: 26rpx;
        color: $u-tips-color;
        line-height: 1.4;
    }

    .traffic-info {
        padding: 20rpx 0;
    }

    .traffic-map {
        margin-bottom: 24rpx;
        border-radius: 16rpx;
        overflow: hidden;
        box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.05);
    }

    .map-image {
        width: 100%;
        height: 360rpx;
        display: block;
    }

    .traffic-detail {
        padding: 20rpx 0;
    }

    .traffic-item {
        display: flex;
        align-items: center;
        padding: 16rpx 0;
        
        .u-icon {
            margin-right: 16rpx;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 64rpx;
            height: 64rpx;
            background: rgba(41, 121, 255, 0.1);
            border-radius: 12rpx;
            
            &:nth-child(1) {
                background: rgba(41, 121, 255, 0.1);
            }
            
            &:nth-child(2) {
                background: rgba(90, 199, 37, 0.1);
            }
            
            &:nth-child(3) {
                background: rgba(255, 149, 0, 0.1);
            }
        }
    }

    .traffic-text {
        flex: 1;
        font-size: 28rpx;
        color: $u-content-color;
        line-height: 1.5;
        margin-left: 12rpx;
    }
</style>
