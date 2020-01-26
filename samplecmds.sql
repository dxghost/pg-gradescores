
drop schema public cascade;
create schema
public;

insert into person
values('dx', 'ghost', '12345678', '2010-11-20');
insert into person
values('oliver', 'queen', 87654321, '2000-10-1');
insert into student
values(12345678, 12);
insert into teacher
values(87654321, 'MA');
insert into fourchoice
    (first_choice, second_choice, third_choice, fourth_choice)
values('10', '2', '12', '3');
insert into question
    (question_text, answer_text, comments, issued_by, choices, correct_choice)
values('What is 2+1?', '3', 'comment sample', 87654321, 1, 4);
insert into course
    (title)
values('Calculus');
insert into exam
    (title,teacher_national_no,course_id,exam_id,exam_type,points)
values('Basic math', 87654321, 1, 'final', 0);
insert into examquestion
    (exam_id,question_id,points)
values(1, 1, 8);
insert into submission
    (eq_id,student_no,examiner_no,points_earned,answer,answer_choice)
values(1, 12345678, null, null);
update submission set points_earned = 3 where eq_id=1 and student_no=12345678;

insert into question
values(2, 'What is 2*5?', '10', 'comment sample', 87654321, 1, 1);
insert into examquestion
    (exam_id,question_id,points)
values(1, 2, 12);
insert into submission
    (eq_id,student_no,examiner_no,points_earned,answer,answer_choice)
values(2, 12345678, null, null);
update submission set points_earned = 10 where eq_id=2 and student_no=12345678;

select *
from exam;
select *
from submission
select *
from examevaluation;
