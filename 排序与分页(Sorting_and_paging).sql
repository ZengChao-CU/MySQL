#*******排序与分页*******
#使用ORDER BY 排序：ASC(ascend):升序   DESC(descend):降序
#ORDER BY子句在SELECT语句的结尾

#未使用排序的操作下，查询返回的数据是按照添加数据的顺序显示的
SELECT * FROM test_2;

#**practice_1:按照salary从高到低的顺序显示员工信息
#使用ORDER BY对查询到的数据进行排序
SELECT employee_id,last_name,salary,phone_number
FROM test_2
ORDER BY salary;#结果是salary从低到高排序

#升序:ASC(ascend)
SELECT employee_id,last_name,salary,phone_number
FROM test_2
ORDER BY salary ASC;
#降序:DESC(descend)
SELECT employee_id,last_name,salary,phone_number
FROM test_2
ORDER BY salary DESC;#从大到小，降序

#使用列的别名进行排序
SELECT last_name,salary,salary * 12 annual_sal
FROM test_2
ORDER BY annual_sal; 
#列的别名只能在ORDER BY中使用，不能在WHERE中使用
/*SELECT last_name,salary,salary * 12 annual_sal
FROM test_2
where annual_sal > 5000;报错*/
#where需要声明在from后面
SELECT last_name,salary,salary * 12 annual_sal
FROM test_2
WHERE salary > 8000
ORDER BY annual_sal DESC;

#二级排序

#**practice_2：显示员工信息，按照salary的降序排序，employee_id的升序排序
SELECT * FROM test_2
ORDER BY salary DESC,employee_id ASC;
#多级排序类似


#**************分页************
#使用limit实现数据的分页显示;#LINMIT 偏移量 显示的条目数
SELECT employee_id,last_name
FROM test_2
LIMIT 0,2;#第一页

SELECT employee_id,last_name
FROM test_2
LIMIT 2,2;#第二页
SELECT employee_id,last_name
FROM test_2
LIMIT 4,2;#第三页
#LINMIT 偏移量，显示的条目数
#每页显示pagesize条记录，此时显示第pageNo页：
#公式：LIMIT (pageN0-1)*pagesize , pagesize;

#NOTICE_1:   WHERE...ORDER BY ...LIMIT声明顺序
#practice_3:按salary降序显示salary>8000的员工信息，
#采用分页方式显示，每页两条记录,显示第二页
SELECT * FROM test_2
WHERE salary > 8000
ORDER BY salary DESC
LIMIT 3,3;#第二页

#LIMIT严格格式：LINMIT 偏移量，显示的条目数
#但结构：“LIMIT 0，条目数”等价于“LIMIT 条目数”
SELECT * FROM test_2
WHERE salary > 8000
ORDER BY salary DESC
LIMIT 5;

#表里有6条数据，只显示第3、4条数据
SELECT employee_id,last_name
FROM test_2
LIMIT 2,2;#获取从第3条记录开始后面的2条记录

#MySQL 8.0中可以使用“LIMT 3 OFFSET 4”表示获取从第5条记录开始后面的3条记录
#和LIMIT 4,3;返回的结果相同
SELECT employee_id,last_name
FROM test_2
LIMIT 2 OFFSET 2;#获取从第3条记录开始后面的2条记录 offset 后面是偏移量,
#与不用offset位置相反
#practice_4:查询员工表中工资最高的员工信息
SELECT * FROM test_2
ORDER BY salary DESC
LIMIT 0,1;#limit 1;

#在不同的DBMS中使用的关键字可能不同，在MySQL、PostgreSQL、MariaDB和SQLite
#中使用关键字LIMIT,而且需要放在SELECYT语句的最后面
#LIMIT关键字不能使用在SQL Server、DB2、Oracle

#practice_4:查询员工的姓名、部门号和年薪，按年薪降序，姓名升序显示
SELECT last_name,job_id,salary * 12 annual_sal
FROM test_2
ORDER BY annual_sal DESC,last_name ASC;
#practice_5:选择工资在9000到24000的员工的姓名和工资，按工资降序，显示3到4位置的数据
SELECT last_name,salary
FROM test_2
WHERE 9000 <= salary <= 24000#salary >= 9000 and salary <= 24000
ORDER BY salary DESC
LIMIT 2,2;
#practice_6:查询邮箱中包含A的员工信息，并先按邮箱的字节数降序，再按部门号升序
SELECT * FROM test_2
WHERE email LIKE '%A%'  #WHERE email REGXP '[A]'
ORDER BY LENGTH(email) DESC, job_id ASC;

