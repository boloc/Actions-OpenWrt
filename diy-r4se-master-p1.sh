#!/bin/bash

# R4SE (master) - feeds & TurboACC 定制

# 追加 passwall 与 AdGuardHome 的第三方源（避免重复追加）
if ! grep -q 'passwall_packages' feeds.conf.default; then
  echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' >> feeds.conf.default
fi

if ! grep -q 'passwall_luci' feeds.conf.default; then
  echo 'src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;main' >> feeds.conf.default
fi

if ! grep -q 'luci_adguardhome' feeds.conf.default; then
  echo 'src-git luci_adguardhome https://github.com/sirpdboy/luci-app-adguardhome.git' >> feeds.conf.default
fi

# 删除 ImmortalWrt 自带的 fullconenat-nft，避免与 TurboACC 冲突
rm -rf package/network/utils/fullconenat-nft/ || true

# 安装 TurboACC（不启用 SFE）
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh \
  && bash add_turboacc.sh --no-sfe


