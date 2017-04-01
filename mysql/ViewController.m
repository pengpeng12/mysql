//
//  ViewController.m
//  mysql
//
//  Created by apple  on 2017/3/30.
//  Copyright © 2017年 apple . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //  mysql --mac 启动配置
    
    /*
     
     sudo /usr/local/mysql/support-files/mysql.server start
     停止：
     
     sudo /usr/local/mysql/support-files/mysql.server stop
     还是比较麻烦，可以简化一下：在~/.bash_aliases中添加这样的命令：
     
     alias mysqlstart='sudo /usr/local/mysql/support-files/mysql.server start'
     alias mysqlstop='sudo /usr/local/mysql/support-files/mysql.server stop'
     
     如果没有.bash_aliases文件，可以创建一个，并在.bash_profile文件的最后加上这样的代码：
     if [ -f ~/.bash_aliases ]; then
     . ~/.bash_aliases
     fi
     
     参考：
     osx - start mySQL server from command line on Mac OS Lion - Stack Overflow
     http://stackoverflow.com/questions/7927854/start-mysql-server-from-command-line-on-mac-os-lion
     
     bashrc bash_profile bash_aliases | Bash | SS64.com
     https://ss64.com/bash/syntax-bashrc.html
     
     
     
     
     -------- -------- -------- -------- -------- -------- -------- --------
     
     //mysql 语句
     
     create database 数据库名字;
     show databases;
     
     create database dbName default character set utf8; --指定默认字符集
     show create database dbName; --查看数据库的字符集
     alter database dbName default character set gbk; -- 改变数据库的字符集为gbk编码
     
     //---查看表与修改表的编码方式语句与改变数据库的一样
     show create table tbName;
     alter table tbName default character set utf8; --这句不包括里面的字段
     alter table tbName convert to character set utf8; --这句会把表里面的字段编码也一起改了(建议使用这句)
     
     drop database dbName;--删除数据库
     
     ///////
     use dbName;
     show tables;
     
     create table tbName(
     id int,
     name varchar(20),
     age int
     );
     
     desc tbName; --查看表
     
     drop table tbName; --删除表
     
     //修改表增加属性
          alter table tbName add column 字段名 类型；
     比如：alter table student add column sgender varchar(2);
     
     //删除表的属性
     alter table tbName drop column 字段名;
     
     //修改字段类型
          alter table tbName modify 字段名 要改为的类型;
     比如：alter table student modify name varchar(30);--改成长度为30
     
     //修改字段名
         alter table tbName change 旧字段名 新字段名 字段类型;
     比如：alter table student change name sName varchar(20);
     
     //修改表名
        alter table 旧表名 rename to 新表名;
     比如：alter table student rename to teacher;

     
     //增加数据
     --插入所有字段，依次按顺序插入
     insert into tbName values(1,'张三'，'男'，20);
     --插入部分字段
     insert into tbName(id,name) values(2,'李四');
     //查询
     select * from tbName;
     
     --1.2修改数据
     update tbName set gender='女'; --修改所有的数据（建议少用）
     //带条件的修改（推荐使用）
     update tbName set gender='女' where id=1;
     //修改多个字段 注意：set 字段名=值,字段名=值,... 
     update TBName set gender='女',age=20 where id=2;
     
     --1.3删除数据
     //删除所有数据（慎重使用）(--delete- 1.可以带条件的删除  2.不能删除表的约束)
     delete from tbname;
     //带条件的删除（推荐使用）
     delete form tbName where id=2;
     --另一种方式 删除所有数据（慎重使用）
     truncate table tbName;(--truncate- 1.不能带条件的删除，只能用于删除表中所有数据 2.可以删除表的约束）
     
     //主键
     primary key auto_increment(自增长约束，一般跟在id属性后面)
     
     
     */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
