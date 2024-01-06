# Docker 安装 TURN 服务，基于 coturn 及 alpine

## 镜像获取

### 自行构建

```sh
docker build -t turnserver:1.0.0 .
```

### dockerhub 拉取

```sh
docker pull passerma/turnserver:1.0.0
```

## 运行

### 直接运行

```sh
docker run -itd --name turnserver -p 3478:3478 -p 3478:3478/udp turnserver:1.0.0
```

### 带参数运行

支持修改公网 ip、用户名、密码

```sh
docker run -itd --name turnserver \
-e EXTERNAL_IP=1.25.23.21 -e TURN_USERNAME=myuser -e TURN_PASSWORD=mypass \
-p 3478:3478 -p 3478:3478/udp \
turnserver:1.0.0
```

## 配置文件

文件位置 **/etc/turnserver.conf**
默认用户名密码 user:pass
