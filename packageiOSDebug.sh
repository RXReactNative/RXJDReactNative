echo "---RN----debug----package-----"

#如果`bundle`文件夹不存在 并创建
project_path=$(cd `dirname $0`; pwd)
ios_bundle=$project_path'/ios/bundle'
if [ ! -f $ios_bundle ];then
mkdir -pm 777 $ios_bundle
fi

#编译 RN
react-native bundle --platform ios --dev yes --entry-file index.ios.js --bundle-output ./ios/bundle/main.jsbundle --assets-dest ./ios/bundle/


# 删除`多余文件`的脚本
delete_name="package_delete_iOS_invalid_directory.sh"
package_delete_iOS_invalid_path=$project_path'/'$delete_name
/bin/sh $package_delete_iOS_invalid_path
