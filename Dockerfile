# 构建阶段（用国内源安装依赖）
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
# 用淘宝源加速 npm 安装
RUN npm install --registry=https://registry.npmmirror.com
COPY . .
RUN npm run build

# 运行阶段（精简镜像）
FROM node:20-alpine AS runner
WORKDIR /app
# 非 root 用户运行（安全）
USER node
# 复制构建产物
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --from=builder --chown=node:node /app/.next ./.next
COPY --from=builder --chown=node:node /app/public ./public
COPY --from=builder --chown=node:node /app/package.json ./package.json
# 暴露端口
EXPOSE 3000
# 生产环境变量
ENV NODE_ENV=production
# 启动服务
CMD ["npm", "start"]