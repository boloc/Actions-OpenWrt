#!/bin/bash

# R4SE (master) - 默认主题与 IP 定制

# 修改默认主题为 argon（luci-light / luci-nginx 集合）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile 2>/dev/null || true
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile 2>/dev/null || true

# 修改默认 IP 地址为 192.168.2.60
sed -i 's/192.168.1.1/192.168.2.60/g' package/base-files/files/bin/config_generate 2>/dev/null || true



