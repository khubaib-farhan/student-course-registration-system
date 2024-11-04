# Student Course Registration System

The project is a basic implementation of a Student Course Registration System using SQL. The system enables students to register for courses, manage departments, instructors, and view registrations.

## Database Schema

The project schema consists of the following tables:

1. **department**
   - `departmentid` (Primary Key): Unique identifier for each department.
   - `departmentname`: Name of the department.

2. **instructor**
   - `instructorid` (Primary Key): Unique identifier for each instructor.
   - `instructorname`: Name of the instructor.
   - `instructoremail`: Email address of the instructor.
   - `departmentid` (Foreign Key): Links to the `department` table.

3. **student**
   - `studentid` (Primary Key): Unique identifier for each student.
   - `name`: Name of the student.
   - `email`: Email address of the student.
   - `password`: Password for the student account.
   - `departmentid` (Foreign Key): Links to the `department` table.
   - `phone`: Phone number of the student.
   - `hobby`: (Added column) A hobby of the student.

4. **course**
   - `courseid` (Primary Key): Unique identifier for each course.
   - `coursename`: Name of the course.
   - `credithours`: Credit hours assigned to the course.
   - `section`: Course section.
   - `instructorid` (Foreign Key): Links to the `instructor` table.
   - `departmentid` (Foreign Key): Links to the `department` table.

5. **section**
   - `sectionid` (Primary Key): Unique identifier for each section.
   - `sectionname`: Name of the section.
   - `timings`: Timings for the section.

6. **registration**
   - `registrationid` (Primary Key): Unique identifier for each registration.
   - `courseid` (Foreign Key): Links to the `course` table.
   - `studentid` (Foreign Key): Links to the `student` table.

## Data Insertion

The following initial data has been added to the tables:
- Departments: Computer Science, Mathematics, Physics
- Instructors: Ahmed Khan, Fatima Ali, Mohammad Iqbal
- Students: Ayesha Bashir, Bilal Riaz, Zoya Shahid
- Courses: Introduction to Programming, Linear Algebra, Quantum Mechanics
- Sections: Morning, Afternoon, Evening
- Registrations: Sample student-course registrations

## SQL Features

The project uses various SQL features, including:

- **Views**: `studentcourseview` provides a view for student-course relationships.
- **Indexes**: Created for optimizing queries on `student` and `course` names.
- **Stored Procedures**: `getstudentcourses` takes a `studentid` as input and returns the courses the student is registered in.
- **Triggers**: `beforestudentinsert` ensures that the `email` field for students is stored in lowercase format.
  
## Sample Queries

1. **List Students by Name**:
   ```sql
   SELECT * FROM student ORDER BY name;
   ```

2. **Course Registrations Count**:
   ```sql
   SELECT coursename, COUNT(*) AS studentcount 
   FROM registration 
   JOIN course ON registration.courseid = course.courseid 
   GROUP BY coursename 
   HAVING COUNT(*) > 1;
   ```

3. **Join Examples**:
   - Inner, Left, and Right joins used to fetch student-course relationships.

4. **Union Example**:
   - Combines left and right join results for `student` and `registration`.

5. **View Usage**:
   ```sql
   SELECT * FROM studentcourseview;
   ```

6. **Procedure Call**:
   ```sql
   CALL getstudentcourses(1);  -- Example for student with ID 1
   ```

## How to Run

1. Clone or download the repository.
2. Open a SQL client and execute the commands in the `courseregistrationsystem.sql` file.
3. Use the sample data and queries provided to test the database structure and relationships.
