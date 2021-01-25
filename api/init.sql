CREATE OR REPLACE FUNCTION earned_points_check()
		RETURNS trigger AS
		$BODY$
		declare
		maximum_points int;
		BEGIN
		select points from ExamQuestion where id = old.eq_id limit 1 into maximum_points;
		IF NEW.points_earned > maximum_points THEN
			raise exception 'input value exceeds maximum achievable points.';
		END IF;
		RETURN NEW;
		END;
		$BODY$ language plpgsql;

	CREATE TRIGGER earned_points_trigger AFTER update ON submission
		FOR EACH ROW EXECUTE PROCEDURE earned_points_check();

CREATE OR REPLACE FUNCTION increment_exam_points()
	RETURNS trigger AS
	$BODY$
	declare
	BEGIN
		update exam set points = points + new.points where id = new.exam_id;
		return new;
	END;
	
	$BODY$ language plpgsql;
	
	CREATE TRIGGER increment_exam_points_trigger AFTER insert ON examquestion
	FOR EACH ROW EXECUTE PROCEDURE increment_exam_points();

CREATE OR REPLACE FUNCTION calculate_points()
	RETURNS trigger AS
	$BODY$
	declare
		examid int;
		total int;
	BEGIN
		select exam_id from examquestion where id = old.eq_id into examid;
		delete from examevaluation where exam_id = examid;
		select sum(points_earned) from submission join examquestion on submission.eq_id = examquestion.id where student_no = old.student_no and exam_id = examid into total;
		insert into examevaluation values(examid,null,old.student_no,total);
		return new;
	END;
	
	$BODY$ language plpgsql;
	
	CREATE TRIGGER calculate_points_trigger AFTER update ON submission
	FOR EACH ROW EXECUTE PROCEDURE calculate_points();

Create Table Person(
		first_name varchar(20) not null,
		last_name varchar(40) not null,
		national_no serial primary key check(length(national_no::varchar) = 8),
		date_of_birth date not null,
        gender char not not null,
        check (gender in ('m', 'f')),
		check (date_of_birth < '2012-01-01')

Create Table School(
			id serial primary key,
			name varchar(50) not null,
            address_id in references Address(id) not null;
			manager_id int references Person(national_no) not null,
			gender char not null,
            check (gender in ('m','f'))
)

Create Table Address(
			id serial primary key,
            province varchar(50) not null,
            city varchar(50) not null,
            district varchar(50),
            street varchar(50),
            zipcode varchar(10) unique
)

Create Table Student(
			national_no int primary key references Person(national_no),
            educational_id int unique,
			educational_grade int not null check(educational_grade > 0 and educational_grade < 13)
)

Create Table Teacher(
			national_no int primary key references Person(national_no),
            teacher_id int unique,
			degrees varchar(200)
)

Create Table StudentParent(
                student_national_no int references Person(national_no),
                parent_national_no int references Person(national_no),
				primary key(student_national_no, parent_national_no)
)


Create Table SchoolGrade(
				school_id int references School(id),
				grade_no int not null check(grade_no > 0 and grade_no < 13),
				primary key(school_id, grade_no)
)
    
Create Table StudentSchool(
			student_national_no int references Student(national_no),
			school_id int references School(id),
			primary key(student_national_no, school_id)
)

Create Table TeacherSchool(
			teacher_national_no int references Teacher(national_no),
			school_id int references School(id),
			primary key(teacher_national_no, school_id)
)

Create Table Course(
			id serial primary key,
			title varchar(40) not null
)

Create Table Class(
            id serial primary key,
			student_national_no int references Student(national_no),
			teacher_national_no int references Teacher(national_no),
			course_id int references Course(id),
            school_id int references School(id),
            -- TODO check line below
			unique(student_no, teacher_no, course_id)
)

Create Table Exam(
			id serial primary key,
			title varchar(60),
			class_id int references Class(id) not null,
			exam_type varchar(10),
			points int default 0,
			check(exam_type in ('mid','final','quiz'))
)

Create Table FourChoice(
			id serial primary key,
			first_choice varchar(100),
			second_choice varchar(100),
			third_choice varchar(100),
			fourth_choice varchar(100)
)

Create Table Question(
			id serial primary key,
			question_text varchar(300) not null,
			answer_text varchar(500) not null,
			comments varchar(200),
			issued_by int references Teacher(national_no) not null,
			choices int references FourChoice(id),
			correct_choice int
)

Create Table ExamQuestion(
			id serial primary key,
			exam_id int references Exam(id) not null,
			question_id int references Question(id) not null,
			points int not null,
			unique (exam_id, question_id)
			
)

Create Table Submission(
			eq_id int references ExamQuestion(id) not null,
			student_no int references Student(national_no) not null,
			examiner_national_no int references Teacher(national_no),
			points_earned int,
			answer varchar(500) not null,
			answer_choice int,
            sts varchar(10),
            check (sts in ("not-reviewed", "approved", "rejected")),
            check(answer_choice > 0 and answer_choice < 5),
			primary key(eq_id, student_national_no)
			
)

Create Table ExamEvaluation(
			exam_id int references Exam(id),
			reviewed_by int references Teacher(national_no),
			student_id int references Student(national_no),
			points int,
			primary key(exam_id, student_id)
)
