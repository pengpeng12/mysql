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
     
     增加多个属性(用逗号隔开，add不能省）
     alter table student add name varchar(20),add age int;
     
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
     //删除所有数据（慎重使用）(--delete- 1.可以带条件的删除  2.不能删除表的约束 3.被删的数据可以回滚(事务))
     delete from tbname;
     //带条件的删除（推荐使用）
     delete from tbName where id=2;
     --另一种方式 删除所有数据（慎重使用）
     truncate table tbName;(--truncate- 1.不能带条件的删除，只能用于删除表中所有数据 2.可以删除表的约束 3.被删的数据不能回滚）
     
     //主键
     primary key auto_increment(自增长约束，一般跟在id属性后面)
     
        //增加表的字段
        //String sql = "alter table student add servlet int,add jsp int,add address varchar(50)";
        //修改列名
        //String sql = "alter table student change sage age int";
        //把sid字段设置为主键
		//String sql = "alter table student add constraint primary key(sid)";
        //把sid字段设置为自增的主键（需要先删除）
        //String sql = "alter table student drop column sid";
        //String sql = "alter table student add sid int primary key auto_increment";
        //改变字段在表中的位置	
        String sql ="alter table student modify sid int auto_increment first";
     
     
     -------查询数据（重点）--基于一张表
     1.查询所有列-- select * from tbName;
     
     2.查询指定列-- select id,name from tbName;
     
     3.查询时指定别名-- select id as '编号',name as '姓名' from tbName as s01;(多表查询时会用到）
     
     4.查询时添加常量列
     需求：在查询student表时添加一个班级列，内容为‘java班’
     select id,name,gender,age,'java班' as '班级' from student;
     
     5.查询时和并列(只能合并数值类型的字段）
     //查询每个学生的servlet 和 jsp 的总成绩
     select id,name,(servlet+jsp) as '总成绩' from student;
     
     6.查询时去除重复记录
     select distinct age from student; 作为关键字
     select distinct(age) from student;另一种语法作为函数
     
     7.条件查询(where)
         1.逻辑条件：and(与) or(或)
            需求：查询id为2，且姓名为李四的学生
              select * from student where id=2 and name='李四';
            需求：查询id为2，或姓名为张三的学生
              select * from student where id=2 or name='张三';
     
         2.比较条件：> < >= <= == <>(不等于）between and(>= 且 <=)
            需求：查询servlet成绩大于70分的学生
            select * from student where servlet>70;
            需求：查询jsp成绩大于等于75分 且小于等于90 的学生
            select * from student where jsp>=75 and jsp<=90;
            //另一种语法
            select * from student where jsp between 75 and 90;
            <>(不等于）的用法
            select * from student where gender<>'男';
     
     
     
         3.判空条件（null 空字符串）：is null / is not null / ='' /<>''
         -- 需求：查询adress 为空的学生
         -- null:表示没有值
         -- 空字符串:是有值的
         select * from student where address is null;
         select * from student where address='';
         //综合
         select * from student where address is null or address='';
         -- 需求：查询有地址的学生
         select * from student where address is not null and address<>'';
     
         4.模糊条件 like
         -- 需求：查询姓‘张’的学生
         select * from student where sname like '张%';
         -- 需求：查询姓‘李’且姓名只有两个字的学生
         select * from student WHERE sname like '李_';
     
     8.聚合查询
         常用的聚合函数：sum() avg() max() min() count()
         需求：查询学生的servlet总成绩
         select sum(servlet) as 'servlet的总成绩' from student;
         需求：查询学生的servlet平均分
         select avg(servlet) as 'servlet的平均分' from student;
         需求：查询学生的servlet最高分
         select max(servlet) as 'servlet最高分' from student;
         需求：查询学生的servlet最低分
         select min(servlet) as 'servlet最低分' from student;
         需求：统计学生的数量（count(字段)）
         select count(*) from student;
         select count(sid) from student;
         //注意：count() 会忽略掉null的数据,所以表的id一般不能为空,用来统计数据。
         select count(address) from student;
     
     9.分页查询 （limit 起始行，查询几行）
         --需求：查询第1，2条记录
         select * from student limit 0,2;
         --需求：查询第3，4条记录
         select * from student limit 2,2;
     
     10.查询排序(order by)
         语法：order by 字段 asc/desc;
         //正序--也是默认的排序
         select * from student order by sid;
         select * from student order by sid asc;
         //反序
         select * from student order by sid desc;
         注意：多个排序条件
         需求：按照servlet正序，jsp的倒序排列
         select * from student order by servlet asc , jsp desc;
     
     11.分组查询 (group by)
         需求：查询男女的人数
         select gender,count(*) from student group by gender;
     
     12.分组查询后筛选 有group by 后面不能再用where 要用having
         需求：查询总人数大于20的性别
         select gender,count(*) from student (这里还可以再用where加条件) group by gender having count(*)>20;
     -------------------------------------------------------------------------------------------------------------------------------------------------
     1.数据约束
     not null / unique -唯一(对null不起作用)
      primary key --主键
     //自增长约束
      auto_increment
     例如：id int primary key auto_increment;
          id int(4) zerofill primary key auto_increment;--自增长，从0开始，zerofill用0填充
     //外键(foreing key(外键) references 参考表名(参考字段))：--两张表的约束
     员工表与部门表(需求：--员工表的deptId字段添加外键约束)
     constraint emlyee_dept_fk foreing key(deptId) references dept(id)
     --          外键名称                    外键               参考表(参考字段)
     注意：1.被约束的表称为副表，约束别人的表称为主表，外键设置在副表上的！
          2.主表的参考字段通用为主键！
          3.添加数据顺序先加主表，再加副表
          4.修改数据时先修改副表，再改主表
          5.删除数据时先删除副表，再删主表 
     
     //级联修改(修改) - 删除
     --需求直接修改部门,员工表数据跟着改变---on update cascade / on delete casecade
     constraint emlyee_dept_fk foreing key(deptId) references dept(id) on update cascade on delete cascade
     
     2.数据库设计（表设计）
     三大范式：
     第一：表的每个字段必须是不可分割的独立单元
     第二：在第一的基础上，每张表只表达一个意思，表的每个字段都和表的主键有依赖
     第三：在第二的基础上，每张表的主键之外的其他字段都和主键有直接依赖关系
     
     3.存储过程 :带有逻辑的sql语句
     -- 声明结束符
     delimiter $
     -- 创建存储过程
     create procedure pro_test()
     begin
            --可以写多个sql语句+流程控制
            select * from student;
     end $
     -- 执行存储过程
     call pro_test();
     
     参数：
     ---- in：表示输入参数，可以携带数据带存储过程中
         --需求：传入一个员工id，查询员工信息
         delimiter $
         create procedure pro_findById(in eid int)
         begin
         select * from student where sid = eid;
         end $
         -- 调用
         call pro_findById(2);
     
     
     ******* mysql的变量 ********
     1. 全局变量（内置变量）：mysql数据库内置的变量
     -- 查看所有全局变量： show variables
     -- show variables like 'character_%';
     -- 查看某个全局变量： select @@character_set_client;
     -- 修改编码： set 变量名=utf8;
     character_set_client :mysql服务器的接收数据的编码
     character_set_results :mysql服务器输出数据的编码
     character_set_client :mysql服务器的接收数据的编码
     character_set_results :mysql服务器输出数据的编码
     2. 会话变量：只存在当前客户端与服务器端的一次连接当中，如果连接断开，那么会话变量全部丢失。
     定义会话变量： set @变量=值
     查看会话变量： select @变量
     3. 局部变量：在存储过程中使用的变量就叫局部变量。只要存储过程执行完毕，局部变量就丢失
     
     
     ---- out：表示输出参数，可以从存储过程中返回结果
         delimiter $
         create procedure pro_testOut(out str varchar(20))
         begin
         -- 	给参数赋值
         set str='这是一个输出参数';
         end $
         -- 定义一个会话变量
         set @name='eric';
         SELECT @name;
         -- 定义一个会话变量name 并且使用name会话变量接收存储过程的返回值
         call pro_testOut(@name);
     
     ---- inout：表示输入输出参数，既可以输入，也可以输出
         delimiter $
         create procedure pro_testInOut(inout n int)
         begin
         -- 查看局部变量
         select n;
         set n = 500;
         end $
         -- 调用
         set @n=10;
         call pro_testInOut(@n);
         select @n;
     
     
     
     -- --------带有条件判断的存储过程
     -- 需求：输入一个整数，如果1，则返回“星期一”，如果2，返回“星期二”，如果3，返回“星期三”，其他数字，返回错误
     delimiter $
     create procedure pro_testIf(in num int, out str varchar(20))
     begin
     if num = 1 then
     set str='星期一';
     elseif num = 2 then
     set str='星期二';
     elseif num = 3 then
     set str='星期三';
     else
     set str='输入错误';
     end if;
     end $
     call pro_testIf(3,@week);
     select @week;
     
     
     -- --------带有循环的存储过程
     -- 需求：输入一个整数，求和
     delimiter $
     create procedure pro_testWhile(in num int , out result int)
     begin
     -- 	定义一个局部变量
     declare i int default 1;
     declare vsum int default 0;
     while i<=num do
     set vsum = vsum + i;
     set i = i + 1;
     end while;
     set result = vsum;
     end $
     call pro_testWhile(100, @sumstr);
     select @sumstr;
     
     -- -------- 使用查询的结果作为返回值 into
     delimiter $
     create procedure pro_findById2(in eid int , out vname varchar(20))
     begin
     select sname into vname from student where sid = eid;
     end $
     call pro_findById2(1,@result);
     select @result;
     
     
     -- ******** 4.触发器 ********
     select *from student;
     -- 日志表
     create table test_log(
     id int primary key auto_increment,
     content varchar(100)
     )
     -- 需求：当向student表插入数据时，希望mysql自动同时往日志表插入数据
     -- 创建触发器(添加)
     create trigger tri_studentAdd after insert on student for each row
     insert into test_log(content) values('学生表插入了一条数据');
     -- 插入数据
     insert into student (sid ,sname, age) values(16,'蓝古扎',1000);
     select * from test_log;
     
     -- 创建触发器(修改)
     create trigger tri_studentUpdate after update on student for each row
     insert into test_log(content) values('学生表修改了一条数据');
     -- 修改数据
     update student set sname='蓝古扎1' where sid=16;
     select * from test_log;
     
     -- 创建触发器(删除)
     create trigger tri_studentDelete after delete on student for each row
     insert into test_log(content) values('学生表删除了一条数据');
     -- 删除数据
     delete from student where sid = 12;
     select * from test_log;
     
     
     
     5.mysql权限问题
     root :拥有所有权限
     --权限账户，只拥有部分权限（crud）例如：只能操作某个数据库的某张表
     --如何修改mysql的用户密码
     --password： md5加密函数（单项加密）
     select password('root'); --*81F5E21E35407D884A6CD4A731AEBFB6AF209E1B
     -- mysql数据表,用户配置：user表
     use mysql;
     select * from user;
     -- 修改密码
     update user set authentication_string=password('123456') where user='root';
     -- 分配权限账户
     grant select on day01.student to 'songpengpeng'@'localhost' identified by '123456';
     grant delete on day01.employee to 'songpengpeng'@'localhost' identified by '123456';
     ------****** 数据库备份 ********
     在终端直接输入，不需要在mysql里面输
     mysqldump -u root -p day01 > /Users/apple/Desktop/day01.sql
     数据库还原：建一个空的数据库day01
     mysql -u root -p day01 < /Users/apple/Desktop/day01.sql
     
     
     
     
     
     ------ 基于多张表查询------关联查询-------------
     需求：查询员工及其所在部门
         1.交叉连接查询（产生笛卡尔乘积现象，有重复问题）
         select empName,deptName from employee,dept;
     --多表查询规则：1）确定查询那些表 2）确定哪些字段 3）表与表之间连接条件
         2.内连接查询
     select empName,deptName                --2)确定哪些字段
            from employee,dept              --1)确定查询哪些表
            where employee.deptId=dept.id   --3)表与表之间的连接条件 n张表就有n-1个连接条件
     内连接的另一种语法
     select empName,deptName
            from employee
            innet join dept
            on employee.deptId=dept.id;
     使用别名
     select empName,deptName
            from employee as e
            innet join dept as d
            on e.deptId = d.id;
     省略as的写法
     select e.empName,d.deptName
            from employee e
            innet join dept d
            on e.deptId = d.id;
     
     ---需求：查询每个部门的员工
     select d.deptName,e.empName
     from dept d,employee e
     where d.id = e.deptId;
     如果用这样的内连接查询，部门员工为null的就会不显示--不符合需求
     这里要用：
     --左外连接查询：null的情况也会显示
     select d.deptName,e.empName
            from dept d
            left outer join employee e
            on d.id=e.deptId;
     --右外连接查询
     select d.deptName,e.empName
     from employee e
     right outer join dept d
     on d.id=e.deptId;
     
     两种写法执行结果是相同的，outer也可以省略不写。
     
     ----2.4 自连接查询---
     一个员工表中有员工id和bossId
     需求：查询员工及其上司
     select e.employee,b.empName
            from employee e
            left outer join employee b
            on e.bossId=b.id;
     */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
