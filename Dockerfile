FROM node:18

# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制项目源代码
COPY . .

# 暴露端口
EXPOSE 8080

# 启动命令
CMD ["node", "index.js"]
