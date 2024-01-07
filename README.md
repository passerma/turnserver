# Docker 安装 TURN 服务，基于 coturn 及 alpine

## 镜像获取

### 自行构建

```sh
docker build -t passerma/turnserver .
```

### dockerhub 拉取

```sh
docker pull passerma/turnserver
```

## 运行

### 直接运行

```sh
docker run -itd --name turnserver -p 3478:3478 -p 3478:3478/udp passerma/turnserver
```

### 带参数运行

支持修改公网 ip、用户名、密码

```sh
docker run -itd --name turnserver \
-e EXTERNAL_IP=1.25.23.21 -e TURN_USERNAME=myuser -e TURN_PASSWORD=mypass \
-p 3478:3478 -p 3478:3478/udp \
passerma/turnserver
```

## 配置文件

文件位置 **/etc/turnserver.conf**

默认用户名密码 user:pass

## 测试功能

![测试](https://www.passerma.com/img/2024/01/06/7f55f5ee-5496-4f17-6f88-97400d0f69fb-0.jpg)
