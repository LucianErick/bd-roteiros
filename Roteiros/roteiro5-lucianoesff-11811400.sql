--Q1

SELECT count(sex) FROM employee WHERE sex = 'F';

--Q2

SELECT avg(e.salary) FROM employee AS e WHERE e.address LIKE '%TX%' and e.sex = 'M';

--Q3

SELECT superssn AS ssn_supervisor, count(*) AS qtd_supervisionados FROM employee GROUP BY superssn ORDER BY qtd_supervisionados ASC;

--Q4

SELECT sup.fname AS nome_supervisor, count(*) AS qtd_supervisionados FROM employee AS sup, employee AS emp GROUP BY sup.ssn, emp.superssn HAVING (sup.ssn = emp.superssn);

--Q5

SELECT sup.fname AS nome_supervisor, count(*) AS qtd_supervisionados FROM employee AS sup RIGHT JOIN employee AS emp ON sup.ssn = emp.superssn GROUP BY sup.ssn, emp.superssn ORDER BY qtd_supervisionados ASC;

-- Q6

SELECT MIN(quantidade.count) AS qtd FROM (SELECT pno, COUNT(essn) FROM works_on AS work GROUP BY pno) AS quantidade;

-- Q7

SELECT pno AS num_projeto, COUNT(essn) AS qtd_func FROM works_on AS w GROUP BY pno HAVING COUNT(essn) IN (SELECT MIN(quantidade.count) AS qtd FROM (SELECT pno, COUNT(essn) FROM works_on AS work GROUP BY pno) AS quantidade);

-- Q8

SELECT pno AS num_proj, AVG(emp.salary) AS media_sal FROM works_on AS work INNER JOIN employee AS emp ON work.essn = emp.ssn GROUP BY pno;

-- Q9

SELECT proj.pname AS name_proj, work.pno AS num_proj, AVG(emp.salary) AS media_sal FROM works_on AS work INNER JOIN employee AS emp ON work.essn = emp.ssn INNER JOIN project AS proj ON work.pno = proj.pnumber GROUP BY work.pno, proj.pname ORDER BY media_sal;

-- Q10

SELECT emp.fname, emp.salary FROM employee AS emp LEFT JOIN works_on AS w ON w.essn = emp.ssn WHERE ((w.pno != 92) OR (w.pno IS NULL)) AND emp.salary > (SELECT MAX(funcionarios.employee_salary) FROM (SELECT e.fname AS first_name, work.pno AS project_number, e.salary AS employee_salary FROM employee AS e LEFT JOIN works_on AS work ON e.ssn = work.essn) AS funcionarios WHERE funcionarios.project_number = 92);

-- Q11

SELECT emp.ssn AS ssn, COUNT(pno) AS qtd_proj FROM employee AS emp LEFT JOIN works_on AS work ON emp.ssn = work.essn GROUP BY emp.ssn ORDER BY qtd_proj ASC;

-- Q12

SELECT work.pno AS num_proj, COUNT(*) AS qtd_func FROM works_on AS work FULL OUTER JOIN employee AS emp ON emp.ssn = work.essn GROUP BY work.pno HAVING COUNT(*) < 5 ORDER BY qtd_func;

-- Q13

SELECT emp.fname FROM employee AS emp WHERE emp.ssn IN (SELECT dep.essn FROM dependent AS dep WHERE emp.dno IN (SELECT dept.dnumber FROM dept_locations AS dept WHERE dept.dlocation = 'Sugarland'));

-- Q14

SELECT dname FROM department WHERE NOT EXISTS (SELECT dnum FROM project WHERE dnumber = dnum);

-- Q15

SELECT DISTINCT fname, lname FROM employee AS e, works_on WHERE essn = ssn AND ssn <> '123456789' AND NOT EXISTS ((SELECT pno FROM works_on WHERE essn = '123456789') EXCEPT(SELECT pno FROM works_on WHERE essn = e.ssn));


-- Q16

-- O pai não tá nem on, nem off. Hoje o pai tá cansado.
