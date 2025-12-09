#!/bin/bash

# R4SE (master) - feeds 定制

# 在顶部插入 passwall (先执行的会在下面，后执行的会在上面)
sed -i '1i src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;main' feeds.conf.default
sed -i '1i src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' feeds.conf.default

# # 追加 AdGuardHome 的第三方源
# echo 'src-git luci_adguardhome https://github.com/sirpdboy/luci-app-adguardhome.git' >> feeds.conf.default

# 删除 ImmortalWrt 自带的 fullconenat-nft，避免与 TurboACC 冲突
rm -rf package/network/utils/fullconenat-nft/ || true

# 安装 TurboACC（不启用 SFE）
# 参考 https://github.com/chenmozhijin/turboacc/tree/luci
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh --no-sfe


