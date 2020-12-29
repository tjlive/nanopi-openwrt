cd friendlywrt-rk3328
cd kernel/
git apply ../../add_fullconenat.diff
wget https://raw.githubusercontent.com/coolsnowwolf/lede/c39177efcfd9df8ea8e5d8e687d327fe77bfde52/target/linux/rockchip/patches-5.4/003-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
git apply 003-arm64-dts-rockchip-add-more-cpu-operating-points-for.patch
cd ../
git clone -b openwrt-18.06-k5.4 --single-branch https://github.com/project-openwrt/openwrt && cd openwrt/
git checkout 20c62b15584e5c902d51abdcec6e056584daa926
cp -a ./target/linux/generic/files/* ../kernel/
./scripts/patch-kernel.sh ../kernel target/linux/generic/backport-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/pending-5.4
./scripts/patch-kernel.sh ../kernel target/linux/generic/hack-5.4
cd ../
wget https://github.com/torvalds/linux/raw/master/scripts/kconfig/merge_config.sh && chmod +x merge_config.sh
grep -i '_NETFILTER_\|FLOW' ../.config.override > .config.override
./merge_config.sh -m .config.override kernel/arch/arm64/configs/nanopi-r2_linux_defconfig && mv .config kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
echo '
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_SHORTCUT_FE=y
CONFIG_XFRM=y
CONFIG_NF_CONNTRACK_CHAIN_EVENTS=y
' >> kernel/arch/arm64/configs/nanopi-r2_linux_defconfig

sed -i -r 's/# (CONFIG_.*_ERRATUM_.*?) is.*/\1=y/g' kernel/arch/arm64/configs/nanopi-r2_linux_defconfig
