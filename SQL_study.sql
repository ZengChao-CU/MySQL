--  select * from employees;
#1.SQL的分类
/*
DDL:数据定义语言。这些语句定义了不同的数据库、表、视图、索引等数据库对象，
还可以用来创建、删除、修改数据库和数据表的结构 
	CREATE\ALTER\DROP\RENAME\TRUNCATE
DML:数据操作语言。用于添加、删除、更新和查询数据库记录，并检查数据完整性
	INSERT\DELETE\UPDATE\SELECT（SELECT是SQL语言的基础，最为重要）
DCL:数据控制语言。用于定义数据库、表、字段、用户的访问权限和安全级别
	COMMIT\ROLLBACK\SAVEPOINT\GRANT\REVOKE
*/

/*
SQL可以写在一行或多行。
每条命令以‘;’或‘\g’或‘\G’结束
关键字不能被缩写也不能分行
列的别名尽量使用双引号"",而且不建议省略as
字符串型和日期时间类型的数据可以使用单引号''表示

注释：1、#	2、--(后面有空格)	3、/*  */
USE dbtest1;	
CREATE TABLE test_3_practices(
job_id INT,
per_name VARCHAR(15),
mon_salary INT);
SHOW TABLES;
#drop table test_3_practice;


USE dbtest1;
SELECT * FROM employees;-- 查询语句
INSERT INTO employees 
VALUES(2003,'张三');
SHOW CREATE TABLE employees;

INSERT INTO test_3_practices
VALUES(01,'曾超',15000),(02,'张三',14000),
(02,'李四',13000),(03,'王五',9000),(04,'老刘',5000);

SHOW CREATE TABLE test_3_practices;
SELECT * FROM test_3_practices;
/*
导入现有的数据表、表的数据
方式一:source 文件的全路径名
eg:source d:\atguigudb.sql;
方式二：基于具体图形化界面的工具可以导入数据
eg:SQLyog中选择工具，执行sql脚本，选中XXX.sql即可
*/

#基本的SELECT语句：SELECT 字段1，字段2，...FROM 表名
SELECT 1+1,3*2
FROM DUAL;#dual:伪表

SELECT * FROM employees;#*:表中所有的字段（或列）

#列的别名
#as:全称：alias（别名），可省略
#列的别名可以使用一对""引起来。
SELECT id
FROM employees;

SELECT id*2 "工号"
FROM employees;

SELECT id id_test
FROM employees;

SELECT `name` 
FROM employees;

#去除重复行select distinct     
#eg:select distinct id from employees;

#空值参与运算 引入ifnull,否则结果会是null
#空值:null

#着重号 ``
SELECT NAME 
FROM employees;
SELECT `name` 
FROM employees;

#查询常数
SELECT 'zc',624,id,`name` FROM employees; 
#显示表结构
DESCRIBE employees;#显示了表中字段的详细信息
DESC employees;
#过滤数据
#查询2001号的信息
SELECT * FROM employees
WHERE id = 2001;#过滤条件  >  < =等等
#查询'曾超'的信息
SELECT * FROM employees
WHERE `name` = '曾超';#过滤条件

#***************基本的select语句练习*******************#
#1、查询员工12个月的工资总和，并起名为ANNUAL SALARY    #
SELECT job_id,per_name,mon_salary*12 "ANNUAL SALARY"   #
FROM test_3_practices;                                 #
#2、查询test_3_practices表中去除重复的job_id以后的数据 #
SELECT DISTINCT job_id                                #
FROM test_3_practices;                                 #
#3、查询工资大于12000的员工的姓名和工资		       #
SELECT per_name,mon_salary			       #
FROM test_3_practices				       #
WHERE mon_salary > 12000;			       #
#4、查询员工工号为3的员工姓名和工资		       #
SELECT per_name,mon_salary			       #
FROM test_3_practices			               #	  
WHERE job_id = 3;				       #
#5、显示表employees的结构，并查询其中全部数据          #
DESCRIBE employees;				       #
SELECT * FROM employees;			       #
#******************************************************#


#**********************运算符*************************#
#----------1、算术运算符

-- + - * /(DIV)   %(MOD)
#示例：SELECT A+B;SELECT A-B; SELECT A*B;
#      SELECT A/B;或SELECT A DIV B;SELECT A%B;或SELECT A MOD B;
SELECT 100, 100 + 0, 100 - 0, 100 + 50, 100 + 50 - 30, 
	100 + 35.5, 100 - 35.5, 100 + 50 * 30
FROM DUAL;
#在SQL中，+ 没有连接的作用，就表示加法运算。此时，会将字符串转换为数值(隐式转换)
SELECT 100 + '1' FROM DUAL;

SELECT 100 + 'a' FROM DUAL;#此时将'a'看作0处理
SELECT 100 + NULL FROM DUAL;#null值参与运算，结果为null

SELECT 100, 100 * 1, 100 * 1.0, 100 / 1.0, 100 / 2,
100 + 2 * 5 / 2, 100 / 3, 100 MOD 3, 100 DIV 0#分母为0，结果为null
FROM DUAL;

SELECT 12%3, 12%5 ,-12%5, -12%-5
FROM DUAL;

#练习：查询员工id为偶数的员工信息
SELECT * FROM test_3_practices
WHERE job_id%2=0;

#-----------2、比较运算符
#比较运算符用来对表达式左边的操作数和右边的操作数进行比较，比较结果为真则返回1，
#比较结果为假，则返回0，其他情况则返回null
#比较运算符经常被用来作为SELECT查询语句的条件使用，返回符合条件的结果记录。

# = 判断两个值、字符串或表达式是否相等  select c from table where a=b;

SELECT 1=2,1 !=2,1='1',1!='1',1='a',0='a' 
FROM DUAL;#字符串存在隐式转换，如果转换不成功，则看作0
SELECT 'a'='a','a'='b'
FROM DUAL;#如果等号两边均为字符串，则会按照字符串进行比较，
#     其比较的是每个字符串中字符的ANSI编码是否相等。
SELECT 1=NULL FROM DUAL;#如果两边中有一个是null，结果为null


# <=> 安全等于运算符  安全地判断两个值、字符串或表达式是否相等 
#select c from table where a<=>b;

# <>(!=) 不等于运算符 判断两值、字符串或表达式是否不相等 select c from table 
#							where a<>b;或(a!=b)

#< 小于符号 >大于符号 <=小于等于 >=大于等于

#-----非符号类型运算符

#IS NULL 为空运算符 判断值、字符串或表达式是否为空
#		select b from table where a is null;

#ISNULL  为空运算符 判断一个值、字符串或表达式是否为空
#		select b from table where a is null;

#IS NOT NULL 不为空运算符 判断一个值、字符串或表达式是否不为空
#		select b from table where a is not null;

#LEAST(least) 最小值运算符 在多个值中返回最小值
#		select d from table where c least(a,b);

#GREATEST(greatest)最大值运算符 在多个值中返回最大值
#		select d from table where c greatest(a,b);

#BETWEEN AND(between and) 判断一个值是否在两值之间
#		select d from table where c between a and b;

#IN 属于运算符 判断一个值是否为列表中的任意一个值
#		select d from table where c in(a,b);

#NOT IN 不属于运算符 判断一个值是否不是列表中的任意一个值
#		select d from table where c not in(a,b);

#LIKE 模糊匹配运算符 判断一个值是否符合模糊匹配规则 
#		select c from table where a like b;

#REGEXP(regexp) 正则表达式运算符 判断一个值是否符合正则表达式规则
#		select c from table where a regexp b;

#
#
#
#
#
#
#
#
#
#


































