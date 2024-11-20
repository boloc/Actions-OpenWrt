#!/bin/bash

# 查找当前路径下的第一个 .img.gz 文件
file=$(find . -type f -name "*.img.gz" | head -n 1)

# 检查是否找到了文件
if [ -z "$file" ]; then
    echo "No .img.gz file found in the current directory."
    exit 1
fi

# 检查 sudo 是否已安装
if ! command -v sudo &>/dev/null; then
    echo "sudo is not installed. Installing sudo..."
    # 安装 sudo
    apt-get update -qq
    apt-get install -y sudo
fi

# 检查 gunzip 是否已安装
if ! command -v gunzip &>/dev/null; then
    echo "gunzip is not installed. Installing gunzip..."

    # 使用 apt 安装 gunzip
    sudo apt-get update -qq
    sudo apt-get install -y gzip # gunzip 是 gzip 包的一部分

    # 再次检查安装是否成功
    if ! command -v gunzip &>/dev/null; then
        echo "Failed to install gunzip. Exiting."
        exit 1 # 如果安装失败，退出脚本
    fi
fi

# gunzip -kf "$file"  # 解压文件并保留原文件
# 获取解压后的 img 文件名
img_file="${file%.gz}"

# 获取文件名（不含路径和后缀）
base_name=$(basename "$img_file" .img)
# 打包文件名与 .img 文件同名，后缀为 .tar.gz
tar_file="${base_name}.tar.gz"

# 挂载 img 文件
echo "Mounting $img_file to /mnt/img"
sudo mkdir -p /mnt/img                  # 创建挂载点
sudo mount -o loop "$img_file" /mnt/img # 挂载
# 判断挂载是否不成功
if [ $? -ne 0 ]; then
    echo "Mount Error!" >&2
    exit 1  # 挂载失败时退出脚本，并返回状态码 1
fi

# 返回到工作目录（假设是 GitHub Actions 的工作空间）
cd $GITHUB_WORKSPACE  # 返回到工作流的根目录

# 在挂载的目录中执行操作，这里进行打包为 ct 模板
echo "Creating ct template..."
tar -czf ./$tar_file -C /mnt/img . # 将打包文件保存到指定目录

# 卸载&删除挂载点
echo "Unmounting $img_file"
sudo umount /mnt/img
sudo rmdir /mnt/img
