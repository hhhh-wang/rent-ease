#!/bin/bash

# 打包
npm run build:h5

# 确保目标目录存在
ssh username@your-server-ip "mkdir -p /usr/share/nginx/html/house-life"

# 将打包文件传输到服务器
scp -r dist/build/h5/* username@your-server-ip:/usr/share/nginx/html/house-life/

# 重启Nginx
ssh username@your-server-ip "sudo systemctl restart nginx" 