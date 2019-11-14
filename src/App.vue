<!--
 * @Author: mokinzhao
 * @Date: 2019-09-05 11:31:34
 * @Description: 
 * @LastEditTime: 2019-09-06 11:51:33
 -->
<template>
<div id="app">
  <head class="header">
    <img alt="Vue logo" src="./assets/header_logo.png" width="130" height="35" />
    <button class="button" @click="loginClick">登录/注册</button>
  </head>
  <el-divider></el-divider>
  <div class="content">
    <img alt="Vue logo" src="./assets/banner.png" @click="paynClick" width="75%" />
    <div class="tabs">
      <el-radio-group v-model="radio1" disabled>
        <el-radio-button label="周榜"></el-radio-button>
        <el-radio-button label="日榜"></el-radio-button>
        <el-radio-button label="新人榜"></el-radio-button>
      </el-radio-group>
    </div>
    <div class="sudoku_row">
      <div
        class="sudoku_item"
        :class="curSelect==sudoku.id?'opacity':''"
        v-for="(sudoku,index) in imgList"
        :key="index"
        @touchstart="touchstart(index)"
        @touchend="touchend"
      >
        <img class="title-img" :src="sudoku.imgUrl" width="230" height="344" @click="paynClick" />
        <div class="flex-row">
          <div class="flex-row2">
            <img :src="sudoku.avatar" width="30" height="30" class="head-img" />
            <span class="img_name">{{sudoku.name}}</span>
          </div>
          <div class="flex-row2">
            <img src="./assets/eyes.png" width="20px" />
            <span class="img_name">{{sudoku.views}}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
  <footer class="footer">
    <img alt="Vue logo" src="./assets/footer.png" width="80%" height="20%" />
  </footer>
  <!-- <登录/> -->
  <el-dialog title="登录/注册" :visible.sync="loginVisible">
    <div class="dialog-login">
      <img src="./assets/header_logo.png" width="160" height="40" />
      <el-input placeholder="您的手机号" v-model="input" clearable class="el-input"></el-input>
      <el-input
        placeholder="短信验证码"
        v-model="input1"
        clearable
        class="el-input"
        suffix-icon="el-icon-s-comment"
      ></el-input>
      <el-input placeholder="您的邀请码" v-model="input2" clearable class="el-input"></el-input>
      <img src="./assets/login_tips.png" width="70%" height="30" class="login_tips" />
      <button class="button_create" @click="loginClick">创建账号/登录</button>
    </div>
  </el-dialog>
  <!-- <支付/> -->
  <el-dialog title="支付" :visible.sync="payVisible">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="充值Uki币" name="first">
        <div class="dialog-content">
          <span>请选择充值金额</span>
          <div class="ul-lists">
            <li
              v-for="(item,index) in payList"
              class="list-item"
              :key="item.id"
              @click="selectedClick(index)"
              :style="{'border':index == selectedIndex ? '2px solid #6E6FE7' : '2px solid #ececf2',}"
            >
              <img src="./assets/money.png" width="30" height="30" />
              <span class="top-up-num">{{item.num}}</span>
              <span class="top-up-money">{{item.money}}</span>
              <img
                src="./assets/radio_top.png"
                width="30"
                height="30"
                class="radio-top-img"
                v-show="index == selectedIndex"
              />
            </li>
          </div>
          <PayCpt />
        </div>
      </el-tab-pane>
      <el-tab-pane label="开通会员" name="second">
        <!-- <开会员/> -->
        <div class="ul-lists">
          <li
            v-for="(item,index) in membersList"
            class="list-item"
            :key="item.id"
            @click="selectedClick(index)"
            :style="{'border':index == selectedIndex ? '2px solid #6E6FE7' : '2px solid #ececf2',}"
          >
            <span
              class="top-up-num2"
              :style="{'color':index == selectedIndex ?'red':'black'}"
            >{{item.num}}</span>
            <span class="top-up-money">{{item.money}}</span>
            <img
              src="./assets/radio_top.png"
              width="30"
              height="30"
              class="radio-top-img"
              v-show="index == selectedIndex"
            />
          </li>
        </div>
        <PayCpt />
      </el-tab-pane>
    </el-tabs>
  </el-dialog>
</div>
</template>

<script>
// import HelloWorld from "./components/HelloWorld.vue";
import { ImgList } from "./assets/img-data";

import PayCpt from "./components/PayCpt.vue";
export default {
  name: "app",
  data() {
    return {
      radio1: "周榜",
      activeName: "first",
      loginVisible: false,
      payVisible: false,
      input: "",
      input1: "",
      input2: "",
      selectedIndex: 0,
      curSelect: null,
      payList: [
        {
          id: 1,
          num: "10,000",
          money: "¥ 10,00"
        },
        {
          id: 2,
          num: "20,000",
          money: "¥ 20,00"
        },
        {
          id: 3,
          num: "30,000",
          money: "¥ 30,00"
        },
        {
          id: 4,
          num: "40,000",
          money: "¥ 40,00"
        },
        {
          id: 5,
          num: "50,000",
          money: "¥ 50,00"
        },
        {
          id: 6,
          num: "请输入",
          money: "¥ 0,00"
        }
      ],
      membersList: [
        {
          id: 11,
          num: "连续包年",
          money: "¥ 120,00"
        },
        {
          id: 22,
          num: "一个季度",
          money: "¥ 80,00"
        },
        {
          id: 33,
          num: "一个月",
          money: "¥ 50,00"
        },
        {
          id: 44,
          num: "三天",
          money: "¥ 20,00"
        }
      ],
      imgList: ImgList
    };
  },
  components: { PayCpt },
  mounted() {
    // eslint-disable-next-line no-console
    console.log("ImgList" + ImgList);
    this.imgList = ImgList;
  },
  methods: {
    loginClick() {
      this.loginVisible = true;
    },
    paynClick() {
      this.payVisible = true;
    },
    handleClick(tab, event) {
      // eslint-disable-next-line no-console
      console.log(tab, event);
    },
    selectedClick(index) {
      // eslint-disable-next-line no-console
      console.log(index);
      this.selectedIndex = index;
    },
    touchstart: function(e) {
      var that = this;
      var list = that.imgList;
      for (var i = 0, len = list.length; i < len; ++i) {
        if (list[i].id == e) {
          that.curSelect = i;
        }
      }
    },
    touchend: function() {
      var that = this;
      that.curSelect = null;
    }
  }
};
</script>

<style scoped>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 0px;
  width: 100%;
}
.header {
  width: 75%;
  margin: 0 auto;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
}
.footer {
  text-align: center;
}
.button {
  width: 96px;
  height: 34px;
  background: rgba(110, 111, 231, 1);
  border-radius: 6px;
  color: white;
}
.button_create {
  margin: 20px;
  width: 126px;
  height: 34px;
  background: rgba(110, 111, 231, 1);
  border-radius: 6px;
  color: white;
}
.content {
  text-align: center;
}
#app /deep/ .el-dialog {
  /* width: 80%; */
  border-radius: 8px;
}
#app /deep/ .el-dialog__header {
  background-color: #6e6fe7;
  text-align: center;
  color: white;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}
#app /deep/ .el-dialog__title {
  color: white;
}
.login_tips {
  margin-top: 10px;
}
.el-input {
  margin-top: 15px;
}
.radio-top-img {
  position: absolute;
  top: 0;
  right: 0;
}
.dialog-login {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.dialog-content {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
.ul-lists {
  display: flex;
  flex-direction: row;
}
.list-item {
  position: relative;
  padding: 15px;
  display: flex;
  flex-direction: column;
  margin: 10px;
  border: 2px solid #ececf2;
  border-radius: 5px;
  justify-content: center;
  align-items: center;
}
.top-up-num {
  margin-top: 10px;
  color: #6e6fe7;
  font-size: 16px;
}
.top-up-num2 {
  margin-top: 10px;
  color: black;
  font-size: 16px;
}
.top-up-money {
  margin-top: 10px;
  color: #747e8b;
}
/* imgdata */
.sudoku_row {
  display: flex;
  margin: 0 auto;
  align-items: center;
  width: 77%;
  flex-wrap: wrap;
}
.sudoku_item {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 20%;
  padding-top: 10px;
  padding-bottom: 10px;
}
.opacity {
  opacity: 0.4;
  background: #e5e5e5;
}
.sudoku_item img {
  /* border-radius: 6px; */
  margin-bottom: 3px;
  display: block;
}
.flex-row {
  width: 85%;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
}
.flex-row2 {
  display: flex;
  flex-direction: row;
  align-items: center;
  align-content: center;
  align-self: center;
}
.img_name {
  margin-left: 5px;
  color: #747e8b;
  font-size: 12px;
}
.title-img {
  border-radius: 6px;
}
.head-img {
  border-radius: 20px;
}
</style>
