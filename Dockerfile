# 使用支持 ESM 的 Node.js 22 镜像
FROM node:22

# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖并强制更新
RUN npm install -g tsx && \
    npm install -g prettier && \
    npm ci --only=production

# 复制完整项目文件（确保 src 目录存在）
COPY . .

# 执行构建命令
RUN npm run build

# 暴露端口并启动服务端
EXPOSE 8080
CMD ["node", "main.js"]
