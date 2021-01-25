package utils

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"log"
)

func ConnectPG(username string, password string, port int, host string) (*sql.DB, error) {
	log.Println(Yellow(fmt.Sprintf("Connecting to postgres with username '%s' on '%s:%d'.", username, host, port)))
	connStr := fmt.Sprintf("user=%s  host=%s port=%d password=%s database=gradescores", username, host, port, password)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}
	log.Println(Green("Connected Successfully."))
	return db, nil
}

func CreateAssertions(db *sql.DB) error {
	// TODO check studentschool insertion with grades defined in schoolgrade
	// submitted question points earned shouldnt exceed question points
	log.Println(Yellow("Creating earned points constraint."))
	_, err := db.Query(`
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
	`)
	if err != nil {
		return err
	}
	log.Println(Green("All assertions created scuccessfully."))
	return nil
}

func CreateTriggers(db *sql.DB) error {
	// update exam's total points whenever a new question is added to exam
	log.Println(Yellow("Creating exam total points incrementor trigger."))
	_, err := db.Query(`
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
	`)
	if err != nil {
		return err
	}

	// Update examevaluation point for student which its tow in submission is examined
	log.Println(Yellow("Creating examevaluation calculator trigger."))
	_, err = db.Query(`
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
	`)
	if err != nil {
		return err
	}
	log.Println(Green("All triggers created successfully."))
	return nil
}

func CreateTables(db *sql.DB) error {

	// PERSON
	log.Println(Yellow("Creating table 'Person'."))
	_, err := db.Query(`Create Table Person(
		first_name varchar(20) not null,
		last_name varchar(40) not null,
		national_no serial primary key check(length(national_no::varchar) = 8),
		date_of_birth date not null,
		check (date_of_birth < '2012-01-01')
	)`)
	if err != nil {
		return err
	}

	// STUDENT
	log.Println(Yellow("Creating table 'Student'."))
	_, err = db.Query(`Create Table Student(
			national_no int primary key references Person(national_no),
			educational_grade int not null check(educational_grade > 0 and educational_grade < 13)
		)`)
	if err != nil {
		return err
	}

	// TEACHER
	log.Println(Yellow("Creating table 'Teacher'."))
	_, err = db.Query(`Create Table Teacher(
			national_no int primary key references Person(national_no),
			degrees varchar(200)
		)`)
	if err != nil {
		return err
	}

	// SCHOOL
	log.Println(Yellow("Creating table 'School'."))
	_, err = db.Query(`Create Table School(
			id serial primary key,
			name varchar(50) not null,
			manager_id int references Person(national_no) not null,
			address varchar(300)
		)`)
	if err != nil {
		return err
	}

	// SCHOOLGRADE
	log.Println(Yellow("Creating table 'SchoolGrade'."))
	_, err = db.Query(`
	Create Table SchoolGrade(
				school_id int references School(id),
				grade_no int not null check(grade_no > 0 and grade_no < 13),
				primary key(school_id, grade_no)
			)`)
	if err != nil {
		return err
	}

	// STUDENTSCHOOL
	log.Println(Yellow("Creating table 'StudentSchool'."))
	_, err = db.Query(`Create Table StudentSchool(
			student_national_no int references Student(national_no),
			school_id int references School(id),
			primary key(student_national_no, school_id)
		)`)
	if err != nil {
		return err
	}

	// TEACHERSCHOOL
	log.Println(Yellow("Creating table 'TeacherSchool'."))
	_, err = db.Query(`Create Table TeacherSchool(
			teacher_national_no int references Teacher(national_no),
			school_id int references School(id),
			primary key(teacher_national_no, school_id)
		)`)
	if err != nil {
		return err
	}

	// COURSE
	log.Println(Yellow("Creating table 'Course'."))
	_, err = db.Query(`Create Table Course(
			id serial primary key,
			title varchar(40) not null
		)`)
	if err != nil {
		return err
	}

	// FOURCHOICE
	log.Println(Yellow("Creating table 'FourChoice'."))
	_, err = db.Query(`Create Table FourChoice(
			id serial primary key,
			first_choice varchar(100),
			second_choice varchar(100),
			third_choice varchar(100),
			fourth_choice varchar(100)
		)`)
	if err != nil {
		return err
	}

	// STUDENTTEACHERCOURSE
	log.Println(Yellow("Creating table 'StudentTeacherCourse'."))
	_, err = db.Query(`Create Table StudentTeacherCourse(
			student_no int references Student(national_no),
			teacher_no int references Teacher(national_no),
			course_id int references Course(id),
			primary key(student_no, teacher_no, course_id)
		)`)
	if err != nil {
		return err
	}

	// EXAM
	log.Println(Yellow("Creating table 'Exam'."))
	_, err = db.Query(`Create Table Exam(
			id serial primary key,
			title varchar(60),
			teacher_national_no int references Teacher(national_no),
			course_id int references Course(id) not null,
			exam_type varchar(10),
			points int default 0,
			check(exam_type in ('mid','final','quiz'))
		)`)
	if err != nil {
		return err
	}

	// QUESTION
	log.Println(Yellow("Creating table 'Question'."))
	_, err = db.Query(`Create Table Question(
			id serial primary key,
			question_text varchar(300) not null,
			answer_text varchar(500),
			comments varchar(200),
			issued_by int references Teacher(national_no) not null,
			choices int references FourChoice(id),
			correct_choice int
		)`)
	if err != nil {
		return err
	}

	// EXAMQUESTION
	log.Println(Yellow("Creating table 'ExamQuestion'."))
	_, err = db.Query(`Create Table ExamQuestion(
			id serial primary key,
			exam_id int references Exam(id) not null,
			question_id int references Question(id) not null,
			points int not null,
			unique (exam_id, question_id)
			
		)`)
	if err != nil {
		return err
	}

	// SUBMISSION
	log.Println(Yellow("Creating table 'Submission'."))
	_, err = db.Query(`Create Table Submission(
			eq_id int references ExamQuestion(id),
			student_no int references Student(national_no),
			examiner_no int references Teacher(national_no),
			points_earned int,
			answer varchar(500) not null,
			answer_choice int,
			primary key(eq_id, student_no)
			
		)`)
	if err != nil {
		return err
	}

	// ExamEvaluation
	log.Println(Yellow("Creating table 'ExamEvaluation'."))
	_, err = db.Query(`Create Table ExamEvaluation(
			exam_id int references Exam(id),
			reviewed_by int references Teacher(national_no),
			student_id int references Student(national_no),
			points int,
			primary key(exam_id, student_id)
		)`)
	if err != nil {
		return err
	}

	log.Println(Green("All tables created scuccessfully"))
	return nil
}
