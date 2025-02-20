#!/bin/bash

# color
CYAN='\033[0;36m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e ""
echo -e '\033[0;32m'
echo -e ' █████╗ ██╗      ██████╗██╗  ██╗███████╗███╗   ███╗██╗   ██╗███████╗██╗███╗   ██╗ █████╗ ███╗   ██╗ ██████╗███████╗'
echo -e '██╔══██╗██║     ██╔════╝██║  ██║██╔════╝████╗ ████║╚██╗ ██╔╝██╔════╝██║████╗  ██║██╔══██╗████╗  ██║██╔════╝██╔════╝'
echo -e '███████║██║     ██║     ███████║█████╗  ██╔████╔██║ ╚████╔╝ █████╗  ██║██╔██╗ ██║███████║██╔██╗ ██║██║     █████╗  '
echo -e '██╔══██║██║     ██║     ██╔══██║██╔══╝  ██║╚██╔╝██║  ╚██╔╝  ██╔══╝  ██║██║╚██╗██║██╔══██║██║╚██╗██║██║     ██╔══╝  '
echo -e '██║  ██║███████╗╚██████╗██║  ██║███████╗██║ ╚═╝ ██║   ██║   ██║     ██║██║ ╚████║██║  ██║██║ ╚████║╚██████╗███████╗'
echo -e '╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝'
echo -e '\033[0m'
echo -e ""
echo -e "${GREEN}油管频道:${RESET} ${CYAN}https://www.youtube.com/@alchemyfinance/"${RESET};
echo -e "${GREEN}法师社群:${RESET} ${CYAN}https://t.me/ytalchemy/"${RESET};
echo ""
echo -e "${BLUE}===================🚀 欢迎使用 PiPe 网络节点安装程序 🚀======================${RESET}"
echo -e "🌟 去中心化网络之旅从这里开始！"
echo -e "✨ 按照步骤操作，脚本将自动为您运行！"
echo ""

# 向用户询问输入
read -p "🔢 输入内存大小 (in GB, e.g., 8): " RAM
read -p "💾 输入硬盘容量 (in GB, e.g., 160): " DISK
read -p "🔑 输入你的 SOL 钱包地址: " PUBKEY

# 索要转介代码，但执行默认一个
read -p "🫂 输入邀请码: " USER_REFERRAL
REFERRAL_CODE="812d4ce2b90976b1"  # 您的默认推荐代码

# 打印实际使用的推荐代码
echo -e "\n✅ 确认邀请码: $REFERRAL_CODE (默认执行)"

# 确认详细信息
echo -e "\n📌 配置摘要:"
echo "   🔢 内存大小: ${RAM}GB"
echo "   💾 硬盘容量: ${DISK}GB"
echo "   🔑 钱包地址: ${PUBKEY}"
read -p "⚡ 确认安装? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "❌ 取消安装！"
    exit 1
fi

# 更新系统
echo -e "\n🔄 升级系统包..."
sudo apt update -y && sudo apt upgrade -y

# 安装依赖项
echo -e "\n⚙️ 安装所需的依赖项..."
sudo apt install -y curl wget jq unzip tmux

# 为 PiPe 节点创建目录
echo -e "\n📂 设置 PiPe 节点目录..."
mkdir -p ~/pipe-node && cd ~/pipe-node

# 下载最新的 PiPe 网络二进制文件 (pop)
echo -e "\n⬇️ 下载 PiPe 网络节点 (pop)..."
curl -L -o pop "https://dl.pipecdn.app/v0.2.8/pop"

# 赋予二进制文件可执行权限
chmod +x pop

# 验证安装
echo -e "\n🔍 验证 pop 二进制..."
./pop --version || { echo "❌ Error: pop 二进制文件不起作用！"; exit 1; }

# 创建下载缓存目录
echo -e "\n📂 创建下载缓存目录..."
mkdir -p download_cache

# 使用推荐码注册
echo -e "\n📌 通过推荐注册 PiPe Network..."
./pop --signup-by-referral-route "$REFERRAL_CODE"
if [ $? -ne 0 ]; then
    echo "❌ Error: 注册失败！"
    exit 1
fi

# 创建推荐
echo -e "\n🫂 你的推荐代码..."
./pop --gen-referral-route

# 启动 PiPe 节点
echo -e "\n🚀 启动 PiPe 网络节点..."
sudo ./pop --ram "$RAM" --max-disk "$DISK" --cache-dir /data --pubKey "$PUBKEY" &

# 保存节点信息
echo -e "\n📜 保存节点信息..."
cat <<EOF > ~/node_info.json
{
    "RAM": "$RAM",
    "Disk": "$DISK",
    "PubKey": "$PUBKEY",
    "Referral": "$REFERRAL_CODE"
}
EOF

echo -e "\n✅ 节点信息已保存！ (可以使用该指令编辑：nano ~/node_info.json)"
