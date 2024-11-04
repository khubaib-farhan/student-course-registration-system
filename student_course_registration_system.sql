-- DATABASE SYSTEMS (Lab) --
-- Group Project: Student Course Registration System --

create database if not exists courseregistrationsystem;
use courseregistrationsystem;
-- drop database courseregistrationsystem;
create table department (
    departmentid int auto_increment primary key,
    departmentname varchar(100) not null
);

create table instructor (
    instructorid int auto_increment primary key,
    instructorname varchar(100) not null,
    instructoremail varchar(100),
    departmentid int,
    foreign key (departmentid) references department(departmentid)
);

create table student (
    studentid int auto_increment primary key,
    name varchar(100) not null,
    email varchar(100),
    password varchar(100) not null,
    departmentid int,
    phone varchar(15),
    foreign key (departmentid) references department(departmentid)
);

create table course (
    courseid int auto_increment primary key,
    coursename varchar(100) not null,
    credithours decimal(3, 1),
    section varchar(10),
    instructorid int,
    departmentid int,
    foreign key (instructorid) references instructor(instructorid),
    foreign key (departmentid) references department(departmentid)
);

create table section (
    sectionid int auto_increment primary key,
    sectionname varchar(100) not null,
    timings varchar(100) not null
);

create table registration (
    registrationid int auto_increment primary key,
    courseid int,
    studentid int,
    foreign key (courseid) references course(courseid),
    foreign key (studentid) references student(studentid)
);

insert into department (departmentname) values
('computer science'),
('mathematics'),
('physics');

insert into instructor (instructorname, instructoremail, departmentid) values
('ahmed khan', 'ahmed.khan@example.com', 1),
('fatima ali', 'fatima.ali@example.com', 2),
('mohammad iqbal', 'mohammad.iqbal@example.com', 3);

insert into student (name, email, password, departmentid) values
('ayesha bashir', 'ayesha.bashir@example.com', 'password123', 1),
('bilal riaz', 'bilal.riaz@example.com', 'securepassword', 2),
('zoya shahid', 'zoya.shahid@example.com', 'strongpassword', 3);

insert into course (coursename, credithours, section, instructorid, departmentid) values
('introduction to programming', 3, 'a', 1, 1),
('linear algebra', 4, 'b', 2, 2),
('quantum mechanics', 5, 'c', 3, 3);

insert into section (sectionname, timings) values
('morning', '9:00 am - 11:00 am'),
('afternoon', '2:00 pm - 4:00 pm'),
('evening', '6:00 pm - 8:00 pm');

insert into registration (courseid, studentid) values
(1, 1),
(2, 2),
(3, 3);

alter table student add column hobby varchar(50);

select * from student order by name;

select coursename, count(*) as studentcount 
from registration 
join course on registration.courseid = course.courseid 
group by coursename 
having count(*) > 1;

select student.name, course.coursename 
from student
join registration on student.studentid = registration.studentid
join course on registration.courseid = course.courseid;

select student.name, course.coursename 
from student
left join registration on student.studentid = registration.studentid
left join course on registration.courseid = course.courseid;

select student.name, course.coursename 
from student
right join registration on student.studentid = registration.studentid
right join course on registration.courseid = course.courseid;

select student.name, course.coursename 
from student
left join registration on student.studentid = registration.studentid
left join course on registration.courseid = course.courseid;

select * from student 
left join registration on student.studentid = registration.studentid
union
select * from student 
right join registration on student.studentid = registration.studentid;

select * from registration 
left join course on registration.courseid = course.courseid
union
select * from registration 
left join course on registration.courseid = course.courseid;

create view studentcourseview as
select student.name as studentname, course.coursename as coursename
from student
join registration on student.studentid = registration.studentid
join course on registration.courseid = course.courseid;

create index idx_student_name on student(name);

create index idx_course_name on course(coursename);

delimiter //

create procedure getstudentcourses(in studentid int)
begin
    select course.coursename 
    from course
    join registration on course.courseid = registration.courseid
    where registration.studentid = studentid;
end //

delimiter ;

delimiter //

create trigger beforestudentinsert
before insert on student
for each row
begin
    set new.email = lower(new.email);
end //

delimiter ;

call getstudentcourses(1);
