# 使用支持 ESM 的 Node.js v20
FROM node:20

# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装全局依赖（关键修复）
RUN npm install -g tsx@4.19.4 prettier@3.5.2

# 安装项目依赖
RUN npm ci --only=production

# 强制复制完整项目文件（确保 src 目录存在）
COPY . .

# 执行构建命令
RUN npm run bakei18n && npm run build

# 暴露端口并启动服务端
EXPOSE 8080
CMD ["node", "main.js"]
