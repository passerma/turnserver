#!/bin/sh

createConf() {
  if [ -z "$EXTERNAL_IP" ]; then
    ip_tmp=$(curl http://icanhazip.com)
    if [ $? -eq 0 ]; then
      echo "获取 EXTERNAL_IP 成功: $ip_tmp"
      EXTERNAL_IP="$ip_tmp"
    else
      echo "获取 EXTERNAL_IP 失败，请手动修改"
      EXTERNAL_IP="0.0.0.0"
    fi
  else
    echo "EXTERNAL_IP 已经设置为: $EXTERNAL_IP"
  fi

  cat <<EOF >>/etc/turnserver.conf
listening-device=eth0
listening-port=3478
listening-ip=$listening_ip
external-ip=$EXTERNAL_IP
fingerprint
lt-cred-mech
user=$user_tmp
realm=$listening_ip
no-tlsv1
no-tlsv1_1
no-tlsv1_2
EOF
}

getEth0Ip() {
  ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1
}

echo "====== 配置 turnserver ======"

user_tmp=${TURN_USERNAME:-"user"}:${TURN_PASSWORD:-"pass"}
listening_ip=$(getEth0Ip)

if [ ! -f /etc/turnserver.conf ]; then
  echo "创建 /etc/turnserver.conf 配置文件"
  createConf
  echo "====== 启动 turnserver ======"
  echo "external-ip=$EXTERNAL_IP"
  echo "user=$user_tmp"
else
  echo "/etc/turnserver.conf 配置文件已存在"
  echo "====== 启动 turnserver ======"
fi

exec turnserver -c /etc/turnserver.conf
