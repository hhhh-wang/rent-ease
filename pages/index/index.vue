<template>
  <view class="u-p-l-10 u-p-r-10">
    <u-navbar :is-back="false">
      <view style="display: flex;justify-content: center;align-items: center;">
        <view class="u-p-30" @click="location">
          {{currentCity}}
          <u-icon name="arrow-down-fill" class="u-p-l-20" color="#515356"></u-icon>
        </view>
        <u-search placeholder="你想住在哪儿" v-model="keyword" input-align="center" :show-action="false"
                  :clearabled="true"
                  :disabled="true" style="width: 565rpx;" @click="toSearch"></u-search>
      </view>
    </u-navbar>
    <view>
      <u-swiper :list="swiperList" height="400"></u-swiper>
    </view>
    <view>
      <view class="rowClass">
        <u-row>
          <u-col span="3" text-align="center" v-for="(item,index) in navList" :key="index" @click="clickNav(item.type)">
            <view class="u-padding-10" hover-class="hoverClass">
              <image :src="item.src" style="width: 80rpx;height: 80rpx;" mode="aspectFit"></image>
              <view class="tabName">{{ item.name }}</view>
            </view>
          </u-col>
        </u-row>
      </view>
      <u-gap height="10"></u-gap>
      <view @click="notice">
        <u-notice-bar mode="vertical" :list="noticeList" type="primary" more-icon
                      bg-color="#fff" :duration="5000" border-radius="15"></u-notice-bar>
      </view>
      <u-gap height="5"></u-gap>
      <u-waterfall v-model="flowList" ref="uWaterfall">
        <template v-slot:left="{leftList}">
          <view class="demo-warter" v-for="(item, index) in leftList" :key="index">
            <u-lazy-load threshold="300" border-radius="16" :image="item.image" :index="index"
                         @click="clickImage(item.id)"></u-lazy-load>
            <view class="house-info">
              <view class="item-title">{{ item.villageName }}
                {{ item.type == '整租' ? item.houseNum + item.houseHall + item.toiletNum : item.roomType + '-朝' + item.direction }}
              </view>
              <view class="item-desc">{{ item.type }} | {{ item.type == '整租' ? item.houseArea : item.roomArea }}㎡
                {{ item.floor }}
              </view>
              <view class="item-price">
                <text class="price-symbol">￥</text>
                <text class="price-num">{{ item.price }}</text>
                <text class="price-unit">/月</text>
              </view>
            </view>
          </view>
        </template>
        <template v-slot:right="{rightList}">
          <view class="demo-warter" v-for="(item, index) in rightList" :key="index">
            <u-lazy-load threshold="-450" border-radius="16" :image="item.image" :index="index"
                         @click="clickImage(item.id)"></u-lazy-load>
            <view class="house-info">
              <view class="item-title">{{ item.villageName }}
                {{ item.type == '整租' ? item.houseNum + item.houseHall + item.toiletNum : item.roomType + '-朝' + item.direction }}
              </view>
              <view class="item-desc">{{ item.type }} | {{ item.type == '整租' ? item.houseArea : item.roomArea }}㎡
                {{ item.floor }}
              </view>
              <view class="item-price">
                <text class="price-symbol">￥</text>
                <text class="price-num">{{ item.price }}</text>
                <text class="price-unit">/月</text>
              </view>
            </view>
          </view>
        </template>
      </u-waterfall>
    </view>
    <u-loadmore bg-color="rgb(240, 240, 240)" :status="loadStatus" @loadmore="findHouseList"></u-loadmore>
    <u-back-top :scroll-top="scrollTop" top="1000"></u-back-top>
    <u-no-network></u-no-network>
    <view class="buttom">
      <view class="loginType">
        <view class="wechat item">
          <view class="icon">
            <u-icon size="60" name="server-man" color="#999" @click="server"></u-icon>
          </view>
        </view>
      </view>
    </view>
    <u-toast ref="uToast"></u-toast>
  </view>
</template>

<script>
import { indexList } from '@/mock/indexList.js'

export default {
  data() {
    return {
      keyword: '',
      pageNum: 1,
      pageSize: 20,
      scrollTop: 0,
      houseList: [],
      swiperList: [
        {
          image: '/static/img/index/swiper/swiper1.png',
          title: '精选好房，品质生活'
        },
        {
          image: '/static/img/index/swiper/swiper2.png',
          title: '合租公寓，温馨舒适'
        },
        {
          image: '/static/img/index/swiper/swiper3.png',
          title: '优质房源，即刻入住'
        },
        {
          image: '/static/img/index/swiper/swiper4.png',
          title: '高端公寓，即刻入住'
        }
      ],
      noticeList: [
        '邀请好友送大礼',
        '请关注变量人生'
      ],
      navList: [
        {
          name: "找房子",
          src: "/static/img/index/cover/search-house.jpg",
          type: "1"
        },
        {
          name: "求租",
          src: "/static/img/index/cover/rent-want.jpg",
          type: "1"
        },
        {
          name: "房东直租",
          src: "/static/img/index/cover/owner-rent.jpg",
          type: "1"
        },
        {
          name: "发布房源",
          src: "/static/img/index/cover/publish.jpg",
          type: "2"
        },
        {
          name: "我要出租",
          src: "/static/img/index/cover/i-rent.jpg",
          type: "2"
        },
        {
          name: "租房攻略",
          src: "/static/img/index/cover/rent-guide.jpg",
          type: "3"
        },
        {
          name: "房租计算",
          src: "/static/img/index/cover/calculator.jpg",
          type: "4"
        },
        {
          name: "我的收藏",
          src: "/static/img/index/cover/my-favorite.jpg",
          type: "5"
        }
      ],
      loadStatus: 'loadmore',
      flowList: [],
      uvCode: uni.getStorageSync('uvCode'),
      currentCity: '长沙市'
    };
  },
  onLoad() {
    uni.$on('findIndexHouseList', (obj) => {
      // 获取数据
      this.findHouseList(1);
    });
    // 获取数据
    this.findHouseList();
  },
  onUnload() {
    // 移除监听事件
    uni.$off('findIndexHouseList');
  },
  onShow() {
    // 检测升级
    // this.checkUpdate();
    // 流量统计
    // this.appSysFlowInfo()
    // 监听城市更新事件
    uni.$on('updateCity', (city) => {
      this.currentCity = city;
      // 这里可以根据城市重新加载房源列表
      // this.loadHouseList(city);
    });
    // 监听城市选择事件
    uni.$on('updateSelectedCity', (data) => {
      this.currentCity = data.city;
      // 根据新的城市重新加载数据
      this.pageNum = 1;
      this.flowList = [];
      this.$refs.uWaterfall.clear();
      this.findHouseList();
    });
  },
  onHide() {
    // 页面隐藏时移除监听，避免重复监听
    uni.$off('updateCity');
    // 页面隐藏时移除监听
    uni.$off('updateSelectedCity');
  },
  onPageScroll(e) {
    this.scrollTop = e.scrollTop;
  },
  onReachBottom() {
    this.loadStatus = 'loading';
    // 获取数据
    this.findHouseList();
  },
  // 下拉刷新
  onPullDownRefresh() {
    // 获取数据
    this.findHouseList(1);
    // 关闭刷新
    uni.stopPullDownRefresh();
  },
  methods: {
    location() {
      this.$u.route({
        url: 'pages/location/location'
      });
    },
    toSearch() {
      // 跳转到搜索页面
      uni.navigateTo({
        url: '/pages/search/search'
      });
    },
    notice() {
      this.$u.route({
        url: 'pages/notice/notice'
      });
    },
    findHouseList(type = 0) {
      if (type == 1) {
        this.pageNum = 1;
        this.flowList = [];
        this.$refs.uWaterfall.clear();
      }
      
      const mockData = indexList;

      // 模拟分页
      const startIndex = (this.pageNum - 1) * this.pageSize;
      const endIndex = startIndex + this.pageSize;
      const data = mockData.slice(startIndex, endIndex);

      if (this.pageNum > 1 && data.length < this.pageSize) {
        return this.loadStatus = 'nomore';
      }

      this.houseList = data;
      for (let i = 0; i < this.houseList.length; i++) {
        let item = this.houseList[i];
        item.image = item.faceUrl;
        
        if (item.type == 0) {
          item.type = '整租';
        } else if (item.type == 1) {
          item.type = '合租';
        }
        
        if (item.roomType == 1) {
          item.roomType = '主卧';
        } else if (item.roomType == 2) {
          item.roomType = '次卧';
        } else {
          item.roomType = '未知';
        }

        if (this.$u.test.isEmpty(item.houseNum)) {
          item.houseNum = '';
        }
        if (this.$u.test.isEmpty(item.houseHall)) {
          item.houseHall = '';
        }
        if (this.$u.test.isEmpty(item.toiletNum)) {
          item.toiletNum = '';
        }
        if (this.$u.test.isEmpty(item.floor)) {
          item.floor = '';
        } else {
          item.floor = item.floor + '层';
        }
        
        this.flowList.push(item);
      }
      
      ++this.pageNum;
      this.loadStatus = 'loadmore';
    },
    checkUpdate() {
      uni.getSystemInfo({
        success: (res) => {
          //检测当前平台，如果是安卓则启动安卓更新
          if (res.platform == "android") {
            console.log('is android');
          }
        }
      });
    },
    clickSearch() {
      this.$u.route('/pages/search/search');
    },
    clickImage(houseId) {
      this.$u.route({
        url: '/pages/detail/detail',
        params: {
          houseId: houseId
        }
      });
    },
    clickNav(type) {
      switch(type) {
        case "1": // 找房相关
          this.$u.route('/pages/search/searchList');
          break;
        case "2": // 发布相关
          // 判断Token是否有效
          let lifeData = uni.getStorageSync('lifeData');
          let token = lifeData.vuex_token;
          if (!token) {
            return uni.reLaunch({
              url: '../login/login'
            });
          } else {
            this.$u.route('/pages/detail/preHouse');
          }
          break;
        case "3": // 租房攻略
          this.$refs.uToast.show({
            type: 'info',
            title: '页面开发中...',
            duration: 2000,
            position: 'center'
          });
          break;
        case "4": // 房租计算器
          this.$refs.uToast.show({
            type: 'info',
            title: '页面开发中...',
            duration: 2000,
            position: 'center'
          });
          break;
        case "5": // 我的收藏
          if (!uni.getStorageSync('lifeData').vuex_token) {
            return uni.reLaunch({
              url: '../login/login'
            });
          }
          this.$refs.uToast.show({
            type: 'info',
            title: '页面开发中...',
            duration: 2000,
            position: 'center'
          });
          break;
      }
    },
    code() {
      this.$mytip.toast('请咨询作者');
    },
    appSysFlowInfo() {
      let url = "web/appSysFlowInfo";
      this.$u.post(url, {
        uvCode: this.uvCode
      }).then(code => {
        this.uvCode = code;
      });
    },
    server() {
      window.open('https://sourcebyte.cn');
    },
    handleFeatureClick(type) {
      // 开发中的功能列表
      const developingFeatures = ['rentGuide', 'calculator', 'favorite'];
      
      if (developingFeatures.includes(type)) {
        this.$refs.uToast.show({
          type: 'info',
          title: '功能开发中...',
          duration: 2000,
          position: 'center'
        });
        return;
      }
      
      // 其他功能的处理逻辑...
    },
    clickRentGuide() {
      this.handleFeatureClick('rentGuide');
    },
    clickCalculator() {
      this.handleFeatureClick('calculator');
    },
    clickFavorite() {
      this.handleFeatureClick('favorite');
    }
  }
};
</script>

<style lang="scss" scoped>
.nomore {
  background-color: $u-bg-color;
}

.search {
  width: 54px;
  height: 44px;

  &:active {
    background-color: $u-bg-color;
  }
}

.rowClass {
  border-radius: 8px;
  background-color: rgb(255, 255, 255);
  margin-top: 10rpx;
}

.hoverClass {
  background-color: #E4E7ED;
}

.tabName {
  font-size: 28rpx;
  color: $u-main-color;
  margin-top: 10rpx;
}

.demo-warter {
  border-radius: 16px;
  margin: 8px 6px;
  background-color: #ffffff;
  padding: 8px;
  position: relative;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  }
}

.u-close {
  position: absolute;
  top: 20rpx;
  right: 20rpx;
}

.item-cover {
  font-size: 55rpx;
  color: $u-type-warning;
}

.house-info {
  padding: 12px 8px 8px;
}

.item-title {
  font-size: 30rpx;
  color: $u-main-color;
  font-weight: bold;
  line-height: 1.4;
  margin-bottom: 8rpx;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}

.item-price {
  margin-top: 12rpx;
  display: flex;
  align-items: baseline;
  
  .price-symbol {
    font-size: 24rpx;
    color: $u-type-warning;
    margin-right: 2rpx;
  }
  
  .price-num {
    font-size: 36rpx;
    font-weight: bold;
    color: $u-type-warning;
  }
  
  .price-unit {
    font-size: 24rpx;
    color: $u-tips-color;
    margin-left: 4rpx;
  }
}

.item-desc {
  font-weight: normal;
  font-size: 26rpx;
  color: $u-tips-color;
  line-height: 1.4;
  margin-top: 6rpx;
}

.item-tag {
  font-size: 24rpx;
  color: $u-tips-color;
  margin-top: 3px;
}

.buttom {
  .loginType {
    font-size: 14px;
    position: fixed;
    right: 30rpx;
    bottom: 300rpx;
    width: 60px;
    height: 60px;
    padding: 4px;
    cursor: pointer;
    background: #FFF;
    text-align: center;
    line-height: 60px;
    border-radius: 100%;
    -webkit-box-shadow: 0px 1px 20px 0px rgba(0, 0, 0, 0.1), inset 0px -1px 0px 0px rgba(0, 0, 0, 0.1);
    box-shadow: 0px 1px 20px 0px rgba(0, 0, 0, 0.1), inset 0px -1px 0px 0px rgba(0, 0, 0, 0.1);
  }
}

image {
  border-radius: 12rpx;  // 添加圆角
  box-shadow: 0 2rpx 4rpx rgba(0,0,0,0.1);  // 添加轻微阴影
}
</style>
