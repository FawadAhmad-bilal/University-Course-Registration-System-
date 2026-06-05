CREATE DATABASE UNIVERSITY_COURSE_REGISTRATION_SYSTEM;
USE UNIVERSITY_COURSE_REGISTRATION_SYSTEM;

CREATE TABLE Departments (
    DepartmentID   INT          PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    DepartmentCode VARCHAR(10)  NOT NULL UNIQUE,
    EstablishedYear INT
);

INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentCode, EstablishedYear) VALUES
(1, 'Artificial Intelligence',   'AI',  2018),
(2, 'Computer Science',          'CS',  2005),
(3, 'Software Engineering',      'SE',  2010),
(4, 'Information Technology',    'IT',  2008);

CREATE TABLE Students (
    StudentID      INT          PRIMARY KEY AUTO_INCREMENT,
    FirstName      VARCHAR(50)  NOT NULL,
    LastName       VARCHAR(50)  NOT NULL,
    RollNumber     VARCHAR(20)  NOT NULL UNIQUE,
    Email          VARCHAR(100) NOT NULL UNIQUE,
    Gender         ENUM('Male','Female','Other') NOT NULL,
    PhoneNumber    VARCHAR(15),
    EnrollmentDate DATE         NOT NULL,
    DepartmentID   INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
);

INSERT INTO Students (StudentID, FirstName, LastName, RollNumber, Email, Gender, PhoneNumber, EnrollmentDate, DepartmentID) VALUES
(1, 'Fawad',   'Ahmad',    'F24-3079', 'fawad.ahmad@university.edu.pk',  'Male',   '03001234567', '2024-09-01', 1),
(2, 'Ibrahim', 'Khan',     'F24-3080', 'ibrahim.khan@university.edu.pk', 'Male',   '03009876543', '2024-09-01', 1),
(3, 'Akhter',  'Zaib',     'F24-3081', 'akhter.zaib@university.edu.pk',  'Male',   '03451234567', '2024-09-01', 1),
(4, 'Sana',    'Bibi',     'F24-2045', 'sana.bibi@university.edu.pk',    'Female', '03331234567', '2023-09-01', 2),
(5, 'Ayesha',  'Noor',     'F24-2046', 'ayesha.noor@university.edu.pk',  'Female', '03121234567', '2023-09-01', 2),
(6, 'Hamza',   'Ullah',    'F24-1100', 'hamza.ullah@university.edu.pk',  'Male',   '03231234567', '2022-09-01', 3);

CREATE TABLE Instructors (
    InstructorID INT          PRIMARY KEY AUTO_INCREMENT,
    FirstName    VARCHAR(50)  NOT NULL,
    LastName     VARCHAR(50)  NOT NULL,
    Email        VARCHAR(100) NOT NULL UNIQUE,
    Designation  VARCHAR(60)  NOT NULL DEFAULT 'Lecturer',
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
);

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, Designation, DepartmentID) VALUES
(1, 'Miss Sana',    'Sikandar', 'sana.sikandar@university.edu.pk', 'Lecturer',         1),
(2, 'Dr. Mubashir', 'Ahmad',    'mubashir.ahmad@university.edu.pk', 'Associate Professor', 1),
(3, 'Mr. Fahad',    'Qureshi',  'fahad.qureshi@university.edu.pk',  'Assistant Professor', 2),
(4, 'Dr. Imran',    'Shah',     'imran.shah@university.edu.pk',      'Professor',           3);

-- TABLE 4: Courses
-- Stores all courses offered by the university
CREATE TABLE Courses (
    CourseID    INT          PRIMARY KEY AUTO_INCREMENT,
    CourseCode  VARCHAR(15)  NOT NULL UNIQUE,
    CourseTitle VARCHAR(150) NOT NULL,
    Credits     INT          NOT NULL CHECK (Credits > 0 AND Credits <= 6),
    CourseType  ENUM('Core','Elective','Lab') NOT NULL DEFAULT 'Core',
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);

INSERT INTO Courses (CourseID, CourseCode, CourseTitle, Credits, CourseType, DepartmentID) VALUES
(1, 'AI-201',  'Machine Learning',              3, 'Core',     1),
(2, 'AI-202',  'Deep Learning',                 3, 'Core',     1),
(3, 'AI-301',  'Natural Language Processing',   3, 'Elective', 1),
(4, 'CS-213',  'Database Management Systems',   3, 'Core',     2),
(5, 'CS-211',  'Data Structures & Algorithms',  3, 'Core',     2),
(6, 'SE-301',  'Software Engineering',          3, 'Core',     3),
(7, 'IT-101',  'Introduction to Programming',   3, 'Core',     4);


-- TABLE 5: Sections
-- Represents a specific scheduled offering of a course
CREATE TABLE Sections (
    SectionID    INT         PRIMARY KEY AUTO_INCREMENT,
    CourseID     INT         NOT NULL,
    InstructorID INT,
    SectionName  VARCHAR(10) NOT NULL DEFAULT 'D',
    Semester     VARCHAR(20) NOT NULL,
    AcademicYear INT         NOT NULL,
    RoomNumber   VARCHAR(20),
    Schedule     VARCHAR(50),
    MaxCapacity  INT         NOT NULL DEFAULT 40 CHECK (MaxCapacity > 0),
    FOREIGN KEY (CourseID)     REFERENCES Courses(CourseID)         ON DELETE CASCADE,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID) ON DELETE SET NULL
);

INSERT INTO Sections (CourseID, InstructorID, SectionName, Semester, AcademicYear, RoomNumber, Schedule, MaxCapacity) VALUES
(4,  1, 'D', 'Spring', 2026, 'Room 301', 'Mon-Wed 08:00-09:30',  45),
(1,  2, 'D', 'Spring', 2026, 'Room 302', 'Tue-Thu 10:00-11:30',  40),
(2,  2, 'D', 'Spring', 2026, 'Room 303', 'Mon-Wed 11:30-01:00',  35),
(5,  3, 'A', 'Spring', 2026, 'Lab 101',  'Tue-Thu 08:00-09:30',  30),
(6,  4, 'B', 'Spring', 2026, 'Room 201', 'Fri     09:00-12:00',  50),
(7,  1, 'D', 'Fall',   2025, 'Room 105', 'Mon-Wed 02:00-03:30',  40);

-- TABLE 6: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID     INT  PRIMARY KEY AUTO_INCREMENT,
    StudentID        INT  NOT NULL,
    SectionID        INT  NOT NULL,
    RegistrationDate TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    Status           ENUM('Active','Dropped','Completed') NOT NULL DEFAULT 'Active',
    Grade            VARCHAR(2)   DEFAULT NULL,
    UNIQUE (StudentID, SectionID),  -- Prevents duplicate registration
    FOREIGN KEY (StudentID)  REFERENCES Students(StudentID)   ON DELETE CASCADE,
    FOREIGN KEY (SectionID)  REFERENCES Sections(SectionID)   ON DELETE CASCADE
);

INSERT INTO Enrollments (StudentID, SectionID, Status, Grade) VALUES
(1, 1, 'Active',    NULL ),  -- Fawad  → DBMS
(1, 2, 'Active',    NULL ),  -- Fawad  → Machine Learning
(1, 3, 'Active',    NULL ),  -- Fawad  → Deep Learning
(2, 1, 'Active',    NULL ),  -- Ibrahim → DBMS
(2, 2, 'Active',    NULL ),  -- Ibrahim → Machine Learning
(3, 1, 'Active',    NULL ),  -- Akhter  → DBMS
(4, 4, 'Completed', 'A'  ),  -- Sana    → DSA (completed)
(4, 5, 'Active',    NULL ),  -- Sana    → Software Engineering
(5, 4, 'Completed', 'B+' ),  -- Ayesha  → DSA (completed)
(6, 5, 'Active',    NULL );  -- Hamza   → Software Engineering

-- ANALYTICAL QUERIES

SELECT
    CONCAT(s.FirstName, ' ', s.LastName)  AS StudentName,
    s.RollNumber,
    c.CourseCode,
    c.CourseTitle,
    c.Credits,
    sec.SectionName                        AS Section,
    sec.Semester,
    sec.AcademicYear,
    sec.Schedule,
    sec.RoomNumber,
    CONCAT(i.FirstName, ' ', i.LastName)  AS Instructor,
    e.Status,
    IFNULL(e.Grade, 'In Progress')         AS Grade
FROM Enrollments e
JOIN Students    s   ON e.StudentID  = s.StudentID
JOIN Sections    sec ON e.SectionID  = sec.SectionID
JOIN Courses     c   ON sec.CourseID = c.CourseID
LEFT JOIN Instructors i ON sec.InstructorID = i.InstructorID
WHERE s.StudentID = 1;


-- QUERY 2: Nominal Roll – All Students in a Given Section (Section 1 = DBMS)
SELECT
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    s.RollNumber,
    s.Email,
    e.Status,
    IFNULL(e.Grade, 'Pending')            AS Grade
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
WHERE e.SectionID = 1
ORDER BY s.RollNumber;


-- QUERY 3: Real-Time Seat Availability per Section
SELECT
    sec.SectionID,
    c.CourseCode,
    c.CourseTitle,
    CONCAT(i.FirstName, ' ', i.LastName) AS Instructor,
    sec.Semester,
    sec.AcademicYear,
    sec.RoomNumber,
    sec.MaxCapacity,
    COUNT(e.EnrollmentID)                 AS EnrolledStudents,
    (sec.MaxCapacity - COUNT(e.EnrollmentID)) AS AvailableSeats,
    CASE
        WHEN (sec.MaxCapacity - COUNT(e.EnrollmentID)) = 0 THEN 'FULL'
        WHEN (sec.MaxCapacity - COUNT(e.EnrollmentID)) <= 5 THEN 'ALMOST FULL'
        ELSE 'OPEN'
    END AS SeatStatus
FROM Sections sec
JOIN Courses   c   ON sec.CourseID     = c.CourseID
LEFT JOIN Instructors i ON sec.InstructorID = i.InstructorID
LEFT JOIN Enrollments e ON sec.SectionID   = e.SectionID
GROUP BY sec.SectionID, c.CourseCode, c.CourseTitle, i.FirstName, i.LastName,
         sec.Semester, sec.AcademicYear, sec.RoomNumber, sec.MaxCapacity
ORDER BY sec.SectionID;


-- QUERY 4: Department-wise Enrollment Count
SELECT
    d.DepartmentName,
    COUNT(DISTINCT s.StudentID)     AS TotalStudents,
    COUNT(DISTINCT c.CourseID)      AS TotalCourses,
    COUNT(e.EnrollmentID)           AS TotalEnrollments
FROM Departments d
LEFT JOIN Students    s   ON s.DepartmentID   = d.DepartmentID
LEFT JOIN Courses     c   ON c.DepartmentID   = d.DepartmentID
LEFT JOIN Sections    sec ON sec.CourseID      = c.CourseID
LEFT JOIN Enrollments e   ON e.SectionID       = sec.SectionID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY TotalEnrollments DESC;
