-- Retrieve names of employees assigned to more than one project, including the total number of projects

SELECT e.Name, COUNT(ep.Project_Num_P) AS Project_Count
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.Employee_Num_E
GROUP BY e.Num_E, e.Name
HAVING COUNT(ep.Project_Num_P) > 1;

-- Retrieve names of employees assigned to more than one project, including the total number of projects

SELECT d.Label, d.Manager_Name, p.Title
FROM Department d
LEFT JOIN Project p ON d.Num_S = p.Department_Num_S
ORDER BY d.Label, p.Title;

-- Retrieve names of employees working on the project "Website Redesign," including their roles

SELECT e.Name, ep.Role
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.Employee_Num_E
JOIN Project p ON ep.Project_Num_P = p.Num_P
WHERE p.Title = 'Website Redesign';

-- Retrieve the department with the highest number of employees, including department label, manager name, and total number of employees

WITH EmployeeCounts AS (
    SELECT d.Label, d.Manager_Name, COUNT(e.Num_E) AS Employee_Count
    FROM Department d
    LEFT JOIN Employee e ON d.Num_S = e.Department_Num_S
    GROUP BY d.Num_S, d.Label, d.Manager_Name
)
SELECT Label, Manager_Name, Employee_Count
FROM EmployeeCounts
WHERE Employee_Count = (SELECT MAX(Employee_Count) FROM EmployeeCounts);

-- Retrieve names and positions of employees earning a salary greater than 60,000, including their department names

SELECT e.Name, e.Position, d.Label
FROM Employee e
JOIN Department d ON e.Department_Num_S = d.Num_S
WHERE e.Salary > 60000;

-- Retrieve the number of employees assigned to each project, including the project title

SELECT p.Title, COUNT(ep.Employee_Num_E) AS Employee_Count
FROM Project p
LEFT JOIN Employee_Project ep ON p.Num_P = ep.Project_Num_P
GROUP BY p.Num_P, p.Title
ORDER BY p.Title;

-- Retrieve a summary of roles employees have across different projects, including employee name, project title, and role

SELECT e.Name, p.Title, ep.Role
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.Employee_Num_E
JOIN Project p ON ep.Project_Num_P = p.Num_P
ORDER BY e.Name, p.Title;

-- SELECT e.Name, p.Title, ep.Role
FROM Employee e
JOIN Employee_Project ep ON e.Num_E = ep.Employee_Num_E
JOIN Project p ON ep.Project_Num_P = p.Num_P
ORDER BY e.Name, p.Title;

-- Retrieve the total salary expenditure for each department, including department label and manager name

SELECT d.Label, d.Manager_Name, COALESCE(SUM(e.Salary), 0) AS Total_Salary
FROM Department d
LEFT JOIN Employee e ON d.Num_S = e.Department_Num_S
GROUP BY d.Num_S, d.Label, d.Manager_Name
ORDER BY d.Label;