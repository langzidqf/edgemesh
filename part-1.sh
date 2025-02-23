#!/bin/bash

set -e

# 错误处理函数
handle_error() {
    echo " * * * * * An error occurred. Exiting... * * * * *  * * * * *  * * * * *  * * * * *  * * * * * "
    exit 1
}
trap 'handle_error' ERR

EDGE4="192.168.1.61"
EDGE5="192.168.1.62"
EDGE6="192.168.1.64"

MASTER="192.168.1.70"
SLAVE1="192.168.1.71"
#SLAVE2="192.168.1.209"




make agentimage
echo "- - - - - make amd64 successfully - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
docker save langzijiangnan/edgemesh-agent:v1 > /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-amd64.tar

make docker-cross-build PLATFORMS=linux/arm64 COMPONENTS=agent
echo "- - - - - make arm64 successfully - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
docker save langzijiangnan/edgemesh-agent:v1-linux-arm64 > /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-arm64.tar


# 传递给给机器：
# k8s-0
scp /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-amd64.tar root@$MASTER:/home/ubuntu/Documents/image/
# k8s-1
scp /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-amd64.tar root@$SLAVE1:/home/ubuntu/Documents/image/

# k8s-2
# scp /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-amd64.tar root@$SLAVE2:/home/ubuntu/Documents/image/

# edge-4
scp /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-arm64.tar dqf@$EDGE4:/home/dqf/image
# edge-5
scp /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-arm64.tar dqf@$EDGE5:/home/dqf/image
# edge-6
scp /Users/dengquanfeng/Desktop/space-ground/image/edgemesh-arm64.tar dqf@$EDGE6:/home/dqf/image
