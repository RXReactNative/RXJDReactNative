echo ""

echo "Delete invalid directory ..."
echo "-------start---------"
project_path=$(cd `dirname $0`; pwd)
project_name="${project_path##*/}"
echo 'project_path='$project_path
ios_bundle=$project_path"/ios/bundle"
ios_assets_path=$ios_bundle"/assets"

echo ""

# react-navigation-stack
ios_assets_node_modules_path=$ios_assets_path"/node_modules"
echo "delete node_modules->react-navigation-stack \n   path="$ios_assets_node_modules_path
/bin/rm -rf $ios_assets_node_modules_path

echo ""

# main.jsbundle.meta
ios_bundle_js_meta=$ios_bundle"/main.jsbundle.meta"
if [ -f $ios_bundle_js_meta ];then
echo "delete bundle->main.jsbundle.meta \n   path="$ios_bundle_js_meta
/bin/rm -rf $ios_bundle_js_meta
fi

echo "-------end----------"
