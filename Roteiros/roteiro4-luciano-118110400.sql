-- Q1
SELECT * FROM department;

-- Q2
SELECT * FROM dependent;

--Q3
SELECT * FROM dept_locations;

--Q4
SELECT * FROM employee;

--Q5
SELECT * FROM project;

--Q6
SELECT * FROM works_on;

--Q7
SELECT fname, lname FROM employee;

--Q8
SELECT fname FROM employee WHERE (employee.sex = 'M') AND (employee.superssn IS NULL);

--Q9
SELECT emp.fname, sup.fname FROM employee AS emp, employee AS sup WHERE emp.superssn = sup.ssn;

--Q10
SELECT fname FROM employee WHERE employee.superssn = '333445555';

--Q11
SELECT dep.dname, loc.dlocation FROM department AS dep, dept_locations AS loc WHERE dep.dnumber = loc.dnumber;

--Q12
SELECT dep.dname FROM department AS dep, dept_locations AS loc WHERE dep.dnumber = loc.dnumber AND loc.dlocation LIKE 'S%';

--Q13
SELECT emp.fname, emp.lname, d.dependent_name FROM employee AS emp, dependent AS d WHERE emp.ssn = d.essn;

--Q14
SELECT (fname || ' ' || minit || ' ' || lname) AS full_name, salary FROM employee WHERE salary > 50000;

--Q15
SELECT proj.pname, dep.dname FROM project AS proj, department AS dep WHERE dep.dnumber = proj.dnum;

--Q16
SELECT proj.pname, mg.fname FROM project AS proj, department AS dep, employee AS mg WHERE proj.dnum = dep.dnumber AND dep.mgrssn = mg.ssn AND proj.pnumber > 30;

--Q17
SELECT proj.pname, emp.fname FROM project AS proj, employee AS emp, department AS dep WHERE proj.dnum = dep.dnumber AND dep.dnumber = emp.dno;

--Q18
SELECT emp.fname, depen.dependent_name, depen.relationship FROM employee AS emp, dependent AS depen, project AS proj, department AS dep  WHERE proj.pnumber = 91 AND proj.dnum = dep.dnumber AND dep.dnumber = emp.dno AND emp.ssn = depen.essn;

