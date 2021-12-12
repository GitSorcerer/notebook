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

