#!/bin/bash

# X86 (master) - Passwall2 feeds
# 官方：packages = 内核/依赖，passwall2 = luci-app-passwall2
# 1i 插在第 1 行前；后执行的会在最上面

sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '1i src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main' feeds.conf.default
