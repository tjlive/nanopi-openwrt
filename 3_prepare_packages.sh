./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf feeds/packages/libs/libcap/ && svn co https://github.com/openwrt/packages/trunk/libs/libcap feeds/packages/libs/libcap
rm -rf feeds/packages/lang/golang/ && svn co https://github.com/coolsnowwolf/packages/trunk/lang/golang feeds/packages/lang/golang
sed -i '/enable-jsonc/i\\t--disable-cloud \\' feeds/packages/admin/netdata/Makefile 

cd package/lean/
if [[ `pwd` == *"rk3328"* ]]; then
  rm -rf luci-app-oled/ && git clone https://github.com/NateLol/luci-app-oled
fi
[ ! -d luci-app-adguardhome ] && git clone https://github.com/kongfl888/luci-app-adguardhome
[ ! -d luci-app-mentohust ] && git clone https://github.com/BoringCat/luci-app-mentohust
[ ! -d mentohust ] && svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/mentohust
rm -rf luci-theme-argon*/ ../lean/luci-theme-argon/ && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon
#rm -rf luci-theme-edge/ && git clone -b 18.06 https://github.com/garypang13/luci-theme-edge
#rm -rf luci-theme-infinityfreedom/ && git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom
rm -rf luci-app-chinadns-ng/ && git clone https://github.com/WuSiYu/luci-app-chinadns-ng
rm -rf openwrt-chinadns-ng/ && git clone https://github.com/pexcn/openwrt-chinadns-ng
rm -rf v2ray/ && svn co https://github.com/coolsnowwolf/lede/tree/master/package/lean/v2ray
rm -rf v2ray-plugin/ && svn co https://github.com/coolsnowwolf/lede/tree/master/package/lean/v2ray-plugin
rm -rf xray/ && svn co https://github.com/coolsnowwolf/lede/tree/master/package/lean/xray
rm -rf trojan/ && svn co https://github.com/coolsnowwolf/lede/tree/master/package/lean/trojan
git clone https://github.com/songchenwen/nanopi-r2s

##smartdns
mv nanopi-r2s/luci-app-r2sflasher/ .
rm -rf nanopi-r2s/
git clone https://github.com/pymumu/smartdns.git
mv smartdns smartdns1
mv smartdns1/package/openwrt .
mv openwrt smartdns
rm -rf smartdns1
cp -r ../../../../package/luci-app-smartdns .

cd ../../


#git clone https://github.com/jerrykuku/lua-maxminddb.git
#git clone https://github.com/jerrykuku/luci-app-vssr.git
#cd luci-app-vssr/root/etc/
#echo 'china_ssr.txt
#config/black.list
#config/white.list
#dnsmasq.oversea/oversea_list.conf
#dnsmasq.ssr/ad.conf
#dnsmasq.ssr/gfw_base.conf
#dnsmasq.ssr/gfw_list.conf' | xargs rm
#cd ../../../
