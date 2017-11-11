-- Q1A. from bölümünde where bölümündeymiş gibi koşul eklenmiş. Research departmanında çalışanların isim soyisim ve adreslerini getiren sorgu
SELECT Fname, Lname, Address
FROM (EMPLOYEE JOIN DEPARTMENT ON Dno=Dnumber)
WHERE Dname='Research';

-- ---------------------------------------

-- Q1B. çalışmadı
SELECT Fname, Lname, Address
FROM (EMPLOYEE NATURAL JOIN(DEPARTMENT AS DEPT(Dname, Dno, Mssn, Msdate)))
WHERE Dname='Research';

-- ---------------------------------------

-- Q8B. çalışanların soyismini ve onların supervisorlarının soyisimlerini listeleyen sorgu
SELECT E.Lname AS Employee_name, S.Lname AS Supervisor_name
FROM (EMPLOYEE AS E LEFT OUTER JOIN EMPLOYEE AS S ON E.Super_ssn=S.Ssn);

-- ---------------------------------------

-- Q2A. Stafford'da yapılan projelerin ve bu projelerin yürütüldüğü departmanların yöneticilerinin bilgilerini listeleyen sorgu
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM ((PROJECT JOIN DEPARTMENT ON Dnum=Dnumber) JOIN EMPLOYEE ON Mgr_ssn=Ssn)
WHERE Plocation='Stafford';

-- ---------------------------------------

-- Q8C. bu kod MySQL de çalışmadı fakat Q8B ile aynı işi yapıyor, sadece farklı bir yazım tarzı
SELECT E.Lname, S.Lname
FROM EMPLOYEE E, EMPLOYEE S
WHERE E.Super_ssn += S.Ssn;

-- ---------------------------------------

-- Q19. Employee tablosundaki tüm maaşların toplamı, maksimumu, minimumu ve ortalamasını listeleyen sorgu
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM EMPLOYEE;

-- ---------------------------------------

-- Q20. Research departmanında çalışanların maaşının toplamı, maksimumu, minimumu ve ortalamasını listeleyen sorgu
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM (EMPLOYEE JOIN DEPARTMENT ON Dno=Dnumber)
WHERE Dname='Research';

-- ---------------------------------------

-- Q21. Tüm çalışanların sayısını veren sorgu
SELECT COUNT(*)
FROM EMPLOYEE;

-- ---------------------------------------

-- Q22. Research departmanında toplam çalışan sayısını veren sorgu
SELECT COUNT(*)
FROM EMPLOYEE, DEPARTMENT
WHERE DNO=DNUMBER AND DNAME='Research';

-- ---------------------------------------

-- Q23. Birbirinden farklı olan maaşların sayısını veren sorgu
SELECT COUNT (DISTINCT Salary)
FROM EMPLOYEE;

-- ---------------------------------------

-- Q5. 2 den fazla yakını olan çalışanların adını ve soyadını listeleyen sorgu
SELECT Lname, Fname
FROM EMPLOYEE
WHERE ( SELECT COUNT(*)
		FROM DEPENDENT
		WHERE Ssn=Essn ) >= 2;

-- ---------------------------------------

-- Q24. Her depertman için departman numarasını, o departmanda çalışan kişi sayısını ve ortalama maaşı listeleyen sorgu
SELECT Dno, COUNT(*), AVG(Salary)
FROM EMPLOYEE
GROUP BY Dno;

-- ---------------------------------------

-- Q25. Her proje için proje numarasını, proje ismini ve o projede çalışan toplam kişi sayısını listeleyen sorgu
SELECT Pnumber, Pname, COUNT(*)
FROM PROJECT, WORKS_ON
WHERE Pnumber=Pno
GROUP BY Pnumber, Pname;

-- ---------------------------------------

-- Q26. 2 den fazla çalışanı olan projelerin numarasını, ismini, ve toplam çalışan kişi sayısını listeleyen sorgu
SELECT Pnumber, Pname, COUNT (*)
FROM PROJECT, WORKS_ON
WHERE Pnumber=Pno
GROUP BY Pnumber, Pname
HAVING COUNT (*) > 2;

-- ---------------------------------------

-- Q27. Her proje için proje ismini, numarasını ve o 5 numaralı departmandan o projede çalışanların sayısını listeleyen sorgu
SELECT Pnumber, Pname, COUNT(*)
FROM PROJECT, WORKS_ON, EMPLOYEE
WHERE Pnumber=Pno AND Ssn=Essn AND Dno=5
GROUP BY Pnumber, Pname;

-- ---------------------------------------

-- Q28. 5 kişiden fazla çalışanı olan departmanlar için, departman numarasını ve o departmanda 40.000 dolardan fazla geliri olanların sayısını listleyen sorgu
SELECT Dnumber, COUNT(*)
FROM DEPARTMENT, EMPLOYEE
WHERE Dnumber=Dno AND Salary>40000 AND (SELECT Dno
										FROM EMPLOYEE
										GROUP BY Dno
										HAVING COUNT(*) > 5)