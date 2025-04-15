# /bin/bash

# 预备 git、docker 命令

# 下载带用户名和密码的链接
# git clone https://github.com/jaimly/catalog-exam.git
# git remote add origin git@github.com:jaimly/catalog-exam.git

Project=catalog-exam

# 更新代码
git pull origin master
echo "更新代码成功"

# 判断是否需要npm
cp package.json package.json1
package1_md5=`md5sum package.json1 | awk '{ print $1 }'`
package_md5=`md5sum package.json | awk '{ print $1 }'`
if [ ! -d "node_modules" ] || [ $package1_md5 != $package_md5 ]; then
    npm i --production --ignore-scripts
fi
rm -rf package.json1
echo "npm成功"

# build前端
npm run build
echo "build前端成功"

# 复制静态文件到nginx映射目录
if [ ! -d "/home/www/$Project" ]; then
    mkdir /home/www/$Project
fi
cp -avx ./dist/* /home/www/$Project
docker restart nginx
echo "静态文件已复制"