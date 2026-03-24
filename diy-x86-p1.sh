#!/bin/bash

# X86 (master) - feeds 定制

# 在顶部插入 passwall (先执行的会在下面，后执行的会在上面)
sed -i '1i src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall.git;main' feeds.conf.default
