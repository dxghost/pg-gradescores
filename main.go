package main
// TODO update ERD
import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"log"
	"github.com/fatih/color"
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

func createTables(db *sql.DB) error {
	// TODO add constraints
	// TODO add not nulls
	// TODO Check table design
	// PERSON
	log.Println(Yellow("Creating table 'Person'."))
	_, err := db.Query(`Create Table Person(
			first_name varchar(20),
			last_name varchar(40),
			national_no serial primary key,
			date_of_birth date
		)`)
	if err != nil {
		return err
	}

	// STUDENT
	log.Println(Yellow("Creating table 'Student'."))
	_, err = db.Query(`Create Table Student(
			national_no int primary key references Person(national_no),
			educational_grade varchar(10)
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
			manager_id int references Person(national_no),
			address varchar(300)
		)`)
	if err != nil {
		return err
	}

	// SCHOOLGRADE
	log.Println(Yellow("Creating table 'SchoolGrade'."))
	_, err = db.Query(`Create Table SchoolGrade(
			school_id int references School(id),
			grades_no int,
			primary key(school_id,grades_no)
		)`)
	if err != nil {
		return err
	}

	// SCHOOLSTAFF
	log.Println(Yellow("Creating table 'SchoolStaff'."))
	_, err = db.Query(`Create Table SchoolStaff(
			school_id int references School(id),
			person_id int references Person(national_no),
			role varchar(20),
			primary key(school_id,person_id)
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
			title varchar(40)
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
			course_id int references Course(id),
			exam_type varchar(10)
		)`)
	if err != nil {
		return err
	}

	// Subject
	log.Println(Yellow("Creating table 'Subject'."))
	_, err = db.Query(`Create Table Subject(
			id serial primary key,
			category varchar(100),
			course_id int references Course(id)
		)`)
	if err != nil {
		return err
	}

	// QUESTION
	log.Println(Yellow("Creating table 'Question'."))
	_, err = db.Query(`Create Table Question(
			id serial primary key,
			question_text varchar(300),
			answer_text varchar(500),
			comments varchar(200),
			issued_by int references Teacher(national_no),
			choices int references FourChoice(id),
			correct_choice int
		)`)
	if err != nil {
		return err
	}

	// EXAMQUESTION
	// TODO add assertion : total points of an exam shouldnt exceed 20
	log.Println(Yellow("Creating table 'ExamQuestion'."))
	_, err = db.Query(`Create Table ExamQuestion(
			id serial primary key,
			exam_id int references Exam(id),
			question_id int references Question(id),
			points int
			
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
			points_earned int
			
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