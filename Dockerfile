FROM node:18

WORKDIR /app

COPY . .

RUN npm ci && npm run build

# 输出构建产物的路径
CMD ["ls", "-lah", "./dist"]
