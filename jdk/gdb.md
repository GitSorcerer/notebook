# gdb

```shell
$:gdb ./java

gdb$:set args ThreadTest

gdb$:start

gdb$:list

gdb$:s #进入方法

gdb$:n #执行下一行
# 设置断点
gdb$:b java.c:187
gdb$:r #run 运行

gdb$:b 248 # 当前文件248 断点
gdb$:c #cont* 继续运行

gdb$:finish #结束当前方法

gdb$:info threads #查看线程
```



man pthread_create

```shell
yum install man-pages libstdc++-docs
```





执行c

```shell
gcc mythread.c -o mythread.out -pthread
```



打包成库文件

```shell
gcc -fPIC -I /resources/openjdk/jdk/build/linux-x86_64-normal-server-slowdebug/jdk/include -I /resources/openjdk/jdk/build/linux-x86_64-normal-server-slowdebug/jdk/include/linux -shared -o LibMyThreadNative.so mythread.c
```

