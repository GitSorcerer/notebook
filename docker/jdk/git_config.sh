#!/bin/bash
cd $WORK_PATH/$OPENJDK_SRC_DIR

# 判断jdk是否clone下来
if [ ! -d "jdk" ];then
  git clone https://gitee.com/open-project-github/jdk.git
  cd jdk
  git checkout jdk8-b120
  mv ../start_make.sh ./
  # 编译jdk
  ./start_make.sh
else
  echo  "jdk is already"
fi

echo "************************************************************************"
echo ""
echo "start git"
echo ""
echo "************************************************************************"

echo "git clone end" > git.txt

# 避免shell执行完毕容器退出
tail -f /dev/null