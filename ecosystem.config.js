module.exports = {
  apps: [
    {
      name: "next-project", // 项目名称
      script: "node_modules/next/dist/bin/next", // Next 启动脚本
      args: "start", // 启动参数
      instances: "max", // 开启多进程（根据服务器核数）
      autorestart: true, // 崩溃自动重启
      watch: false, // 生产环境关闭监听
      max_memory_restart: "1G", // 内存占用超 1G 重启
      env: {
        NODE_ENV: "production", // 生产环境
        PORT: 3000, // 项目端口
      },
    },
  ],
};
