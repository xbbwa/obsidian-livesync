# 使用官方 Node.js 镜像作为基础镜像
FROM node:22
# 设置工作目录
WORKDIR /usr/src/app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制项目源代码（关键步骤）
COPY . .

# 执行构建命令
RUN npm run build

# 指定默认命令（替代缺失的 npm start）
CMD ["sh", "-c", "ls -la dist/"]
