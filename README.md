# Pipe 节点一键部署

- 油管频道：https://www.youtube.com/@alchemyfinance/
- 法师社群：https://t.me/ytalchemy/

## 配置要求
- 内存 4G
- 硬盘 100G

## VPS 试用
- 使用 DigitalOcean，新用户可获得 **60 天 $200** 的试用额度

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=9de664fa6fad&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

## 一键部署代码
### 新建会话窗口
```bash
tmux new -s pipenode
```

### 一键安装运行
```bash
curl -O https://raw.githubusercontent.com/btcalchemyfinance/PipeNetwork/refs/heads/main/pipe.sh && chmod +x pipe.sh && ./pipe.sh
```

## 检查节点状态
```bash
curl -O https://raw.githubusercontent.com/btcalchemyfinance/PipeNetwork/refs/heads/main/pipestatus.sh && chmod +x pipestatus.sh && ./pipestatus.sh
```
