<!--
 * @Author: mokinzhao
 * @Date: 2019-09-05 14:34:29
 * @Description: 
 * @LastEditTime: 2019-09-05 15:17:53
 -->
<template>
  <div class="pay">
    <span>请选择支付方式</span>
    <el-tabs
      type="border-card"
      :tab-position="tabPosition"
      :stretch="true"
      style="height: 200px;marginTop:15px"
    >
      <el-tab-pane label="微信支付">
        <span slot="label" class="span-tap">
          <img src="../assets/wechat.png" height="20" width="20" style="marginRight: 10px;" /> {{data[0].title}}
        </span>
        <div class="pay-qr">
          <span>{{data[0].tip}}</span>
          <img src="../assets/qr_wechat.png" height="120" width="120" />
        </div>
      </el-tab-pane>
      <el-tab-pane label="支付宝支付">
        <span slot="label" class="span-tap">
          <img src="../assets/alipay.png" height="20" width="20" style="marginRight: 10px;" />  {{data[1].title}}
        </span>
        <div class="pay-qr">
          <span> {{data[1].tip}}</span>
          <img src="../assets/qr_alipay.png" height="120" width="120" />
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
export default {
  props: {
    data: Object
  },
  data() {
    return {
      tabPosition: "left"
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.pay {
  height: 100%;
}
.span-tap {
  display: flex;
  flex-direction: row;
  align-items: center;
}
.pay-qr {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
</style>
