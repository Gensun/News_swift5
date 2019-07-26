#!/bin/bash

Project_name="HeadNews"

#根据配置环境构建 Release or Debug
buildType=Release

#自动更新SVN / git代码  start
#svn update
echo "git pull starting"
#git pull#
echo "git pull ending"

#输出打包文件目录
output_path=~/Desktop/ipa-build1
if [ -d $output_path ];then
rm -rf $output_path
fi
mkdir $output_path

#记录执行脚本的初始化目录
project_path=$(pwd)
compiled_path=${project_path}/build/Release-iphoneos

appdirname=$Project_name
echo "Current workspace is $(pwd)"

#清理工程
/usr/bin/xcodebuild -target $Project_name clean
#编译工程
xcodebuild -workspace *.xcwork* -scheme $Project_name -configuration ${buildType} \
CONFIGURATION_BUILD_DIR=${compiled_path} \
ONLY_ACTIVE_ARCH=NO \
CODE_SIGN_IDENTITY="iPhone Distribution: EF Language Learning Solutions Ltd" || exit

#打包ipa文件存放到桌面
xcrun -sdk iphoneos PackageApplication -v build/Release-iphoneos/*.app -o ${output_path}/${appdirname}.ipa || exit

#删除临时文件
#rm -rf build

#打开ipa桌面目录
#open $output_path

#上传蒲公英网站
#echo '/+++++++ 上传蒲公英 +++++++/'
#PASSWORD=123456
##将git最后一次提交作为更新说明
#MSG=`git log -10 --pretty=format:"%h - %cn, %cd : %s"`
#curl -F "file=@$output_path/$appdirname.ipa" \
#-F "uKey=333a7c7c0848515c7cf42d16ddf73aba" \
#-F "_api_key=d6d3680bd40811728059f92dd6fe3b5d" \
#-F "updateDescription=${MSG}" \
#-F "password=${PASSWORD}" \
#https://qiniu-storage.pgyer.com/apiv1/app/upload
