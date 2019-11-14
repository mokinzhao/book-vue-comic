/*
 * @Author: mokinzhao
 * @Date: 2019-09-05 19:21:01
 * @Description:
 * @LastEditTime: 2019-09-06 15:02:25
 */
// vue.config.js
module.exports = {
  baseUrl: "./",
  chainWebpack: config => {
    config.module
      .rule("images")
      .use("image-webpack-loader")
      .loader("image-webpack-loader")
      .options({
        bypassOnDebug: true
      })
      .end();
  }
};
