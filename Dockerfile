FROM registry.cn-hangzhou.aliyuncs.com/uki-web/web-base-image:nginx
RUN mkdir -p /usr/src/app/official/comic/

EXPOSE 81
COPY ./dist /usr/src/app/official/comic/
