# 🎓 University Course Registration System
### Database Design & Implementation Project

## 👤 Student Information

| Field | Details |
|-------|---------|
| **Student Name** | Fawad |
| **Roll No** | F24-3079 |
| **Program** | BSAI – Section D |
| **Semester** | 4th Semester |
| **Subject** | Database Management Systems (DBMS) |
| **Submitted To** | Miss Sana Sikandar |
| **University** | University of Haripur |

---

## 📌 Project Overview

The **University Course Registration System (UCRS)** is a fully normalized relational database built in **MySQL**. It automates the complete academic registration workflow — from department setup to student enrollment tracking, seat availability monitoring, and grade management.

---

## 🗄️ Database Schema – 6 Tables

| Table | Primary Key | Description |
|-------|-------------|-------------|
| `Departments` | DepartmentID | Stores all academic departments |
| `Students` | StudentID | Student personal & enrollment info |
| `Instructors` | InstructorID | Faculty information & department link |
| `Courses` | CourseID | Course catalog with credits & type |
| `Sections` | SectionID | Scheduled course offerings per semester |
| `Enrollments` | EnrollmentID | Bridge table: Students ↔ Sections |

---

## 🔗 Entity Relationships

```
Departments  ──< Courses       (1 to Many)
Departments  ──< Instructors   (1 to Many)
Courses      ──< Sections      (1 to Many)
Instructors  ──< Sections      (1 to Many)
Students    >──< Sections      (Many to Many → via Enrollments)
```

---

## 📊 Analytical Queries

| Query | Description |
|-------|-------------|
| **Q1** | Student Registration Profile – full course slip for a student |
| **Q2** | Instructor Nominal Roll – all students in a section |
| **Q3** | Real-Time Seat Availability Tracker with CASE-based status |
| **Q4** | Department-wise Enrollment Count |

---

## ✅ Key DBMS Concepts Applied

- `PRIMARY KEY` with `AUTO_INCREMENT`
- `FOREIGN KEY` with `ON DELETE CASCADE` and `ON DELETE SET NULL`
- `UNIQUE` constraint (prevents duplicate enrollments)
- `CHECK` constraint (Credits > 0, MaxCapacity > 0)
- `ENUM` types (Gender, CourseType, Status)
- `JOIN` operations (INNER JOIN, LEFT JOIN)
- `GROUP BY` with `COUNT()` aggregation
- `CASE` expression for dynamic status labels
- **3NF Normalization** (1NF ✓, 2NF ✓, 3NF ✓)

---

## 📁 Repository Files

| File | Description |
|------|-------------|
| `UCRS_Database_Fawad_F24-3079.sql` | Complete SQL source code (DDL + DML + Queries) |
| `UCRS_Report_Fawad_F24-3079.docx` | Full project report with ERD and query results |
| `UCRS_Presentation_Fawad_F24-3079.pptx` | 8-slide project presentation |
| `README.md` | overview about project |

---

## 🚀 How to Run

1. Open **MySQL Workbench** or any MySQL client
2. Open the file `UCRS_Database_Fawad_F24-3079.sql`
3. Run the entire script — it will:
   - Create the database
   - Create all 6 tables
   - Insert sample data
   - Execute all 4 analytical queries
4. View results in the output panel

---

## 🏛️ University of Haripur – BSAI Section D – 2026
