package main

// TODO update ERD
import (
	"database/sql"
	"fmt"
	"github.com/fatih/color"
	_ "github.com/lib/pq"
	"log"
)

var Green = color.New(color.FgHiGreen).SprintFunc()
var Red = color.New(color.FgRed).SprintFunc()
var Yellow = color.New(color.FgHiYellow).SprintFunc()


func main() {

	db, err := connectPG("postgres", "dx", 5432, "127.0.0.1")
	if err != nil {
		log.Fatal(Red(err))
	}

	err = createTables(db)
	if err != nil {
		log.Fatal(Red(err))
	}

	err = createAssertions(db)
	if err != nil {
		log.Fatal(Red(err))
	}

	// rows, err := db.Query("SELECT * FROM Person")
	// if err!=nil{
	// 	log.Fatal(err)
	// }

	// var x int
	// var y int
	// var z int
	// for rows.Next(){
	// 	err = rows.Scan(&x,&y,&z)
	// 	if err!=nil{
	// 		log.Fatal(err)
	// 	}
	// 	log.Println(x,y,z)
	// }

}

func connectPG(username string, password string, port int, host string) (*sql.DB, error) {
	log.Println(Yellow(fmt.Sprintf("Connecting to postgres with username '%s' on '%s:%d'.", username, host, port)))
	connStr := fmt.Sprintf("user=%s  host=%s port=%d password=%s database=gradescores", username, host, port, password)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}
	log.Println(Green("Connected Successfully."))
	return db, nil
}

func createAssertions(db *sql.DB) error {
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
	log.Println(Green("All Assertions created scuccessfully"))
	return nil
}

func createTables(db *sql.DB) error {

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

	// SCHOOLTEACHER
	log.Println(Yellow("Creating table 'SchoolTeacher'."))
	_, err = db.Query(`Create Table SchoolTeacher(
			teacher_national_no int references teacher(national_no),
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

	// EXAM
	log.Println(Yellow("Creating table 'Exam'."))
	_, err = db.Query(`Create Table Exam(
			id serial primary key,
			title varchar(60),
			teacher_national_no int references Teacher(national_no),
			course_id int references Course(id) not null,
			exam_type varchar(10),
			points int,
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
	// TODO add trigger: increment exam points by question points
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

// TODO add trigger after submitting a point to a question score for
//  the coresponding exam gets updated

// TODO add trigger for summing up students exam points
