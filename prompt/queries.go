package prompt

import (
	"bufio"
	"fmt"
	utils "github.com/dxghost/pg-gradescores/utils"
	"github.com/jedib0t/go-pretty/table"
	"log"
	"os"
	"strconv"
)

var Reader = bufio.NewReader(os.Stdin)

// ShowStudents Query to get all students in database
func (p *Prompt) ShowStudents() {
	rows, err := p.db.Query("SELECT national_no, first_name, last_name, educational_grade school_name FROM Student natural join Person")
	if err != nil {
		log.Fatal(utils.Red(err))
	}

	var nno int
	var fname string
	var lname string
	var edgrade int
	// var schoolname string

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"national number", "first name", "last name", "educational grade"})

	for rows.Next() {
		err = rows.Scan(&nno, &fname, &lname, &edgrade)
		if err != nil {
			log.Fatal(utils.Red(err))
		}
		t.AppendRow([]interface{}{strconv.Itoa(nno), fname, lname, strconv.Itoa(edgrade)})
	}
	t.Render()
}

func (p *Prompt) CreateStudent() {
	var fName, lName, bDate, inNo, inEdGrade, schoolID string
	var nNo, edGrade int
	fmt.Printf(utils.Cyan("\nfirst name: "))
	fmt.Scan(&fName)
	fmt.Printf(utils.Cyan("last name: "))
	fmt.Scan(&lName)
	fmt.Printf(utils.Cyan("birthdate (in 1991-12-10 format): "))
	fmt.Scan(&bDate)
	fmt.Printf(utils.Cyan("national number (8 digits): "))
	fmt.Scan(&inNo)
	fmt.Printf(utils.Cyan("school id : "))
	fmt.Scan(&schoolID)
	nNo, err := strconv.Atoi(inNo)
	if err != nil {
		log.Println(utils.Red(err))
		fmt.Println(utils.Red("national number should be a number"))
		return
	}
	if len(inNo) != 8 {
		log.Println(utils.Red(err))
		fmt.Println(utils.Red("national number should be 8 digits"))
		return
	}
	fmt.Printf(utils.Cyan("eductational grade (1~12): "))
	fmt.Scan(&inEdGrade)
	edGrade, err = strconv.Atoi(inEdGrade)
	if err != nil {
		log.Println(utils.Red(err))
		fmt.Println(utils.Red("educational grade should be a number"))
		return
	}
	if edGrade > 12 || edGrade < 0 {
		log.Fatal(utils.Red("educational grade should be between (0,12)"))
	}
	_, err = p.db.Query(fmt.Sprintf(`insert into person (first_name, last_name, national_no, date_of_birth)
		values ('%s', '%s', %d, '%s');
		insert into student (national_no, educational_grade) 
		values (%d, %d);
		insert into studentschool (student_national_no, school_id)
		values (%d, %s);`, fName, lName, nNo, bDate, nNo, edGrade, nNo, schoolID))
	if err != nil {
		log.Println(utils.Red(err))
		return
	}
	fmt.Println(utils.Green("\ncreated successfully"))
}

func (p *Prompt) ShowSingleStudent(args []string) {
	rows, err := p.db.Query(fmt.Sprintf("SELECT national_no, first_name, last_name, educational_grade, school_id FROM  Person natural join Student  join StudentSchool on student.national_no = studentschool.student_national_no  where national_no =  %s;", args[2]))
	if err != nil {
		log.Fatal(err)
	}

	var nno int
	var fname string
	var lname string
	var edgrade int
	var school_name string

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"national number", "first name", "last name", "educational grade", "school name"})

	for rows.Next() {
		err = rows.Scan(&nno, &fname, &lname, &edgrade, &school_name)
		if err != nil {
			log.Fatal(err)
		}
		t.AppendRow([]interface{}{strconv.Itoa(nno), fname, lname, strconv.Itoa(edgrade), school_name})
	}
	t.Render()
}

func (p *Prompt) ShowStudentGrades(args []string) {
}

func (p *Prompt) ShowStudentExams(args []string) {
	// TODO
}

// ShowTeachers Query to get all teachers in database
func (p *Prompt) ShowTeachers() {
	rows, err := p.db.Query("SELECT national_no, first_name, last_name, name as school_name, degrees FROM School natural join TeacherSchool natural join Teacher natural join Person")
	if err != nil {
		log.Fatal(err)
	}

	var nno int
	var fname string
	var lname string
	var degrees string
	var schoolname string

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"national number", "first name", "last name", "school name", "degrees"})

	for rows.Next() {
		err = rows.Scan(&nno, &fname, &lname, &schoolname, &degrees)
		if err != nil {
			log.Fatal(err)
		}
		t.AppendRow([]interface{}{strconv.Itoa(nno), fname, lname, schoolname, degrees})
	}
	t.Render()
}

func (p *Prompt) CreateTeacher() {
	var fName, lName, bDate, inNo, schoolID, degrees string
	var nNo int
	fmt.Printf(utils.Cyan("\nfirst name: "))
	fmt.Scan(&fName)
	fmt.Printf(utils.Cyan("last name: "))
	fmt.Scan(&lName)
	fmt.Printf(utils.Cyan("birthdate (in 1991-12-10 format): "))
	fmt.Scan(&bDate)
	fmt.Printf(utils.Cyan("national number (8 digits): "))
	fmt.Scan(&inNo)
	fmt.Printf(utils.Cyan("educational degrees: "))
	degrees, _ = Reader.ReadString('\n')
	fmt.Printf(utils.Cyan("school id : "))
	fmt.Scan(&schoolID)
	nNo, err := strconv.Atoi(inNo)
	if err != nil {
		log.Println(utils.Red(err))
		fmt.Println(utils.Red("national number should be a number"))
		return
	}
	if len(inNo) != 8 {
		log.Println(utils.Red(err))
		fmt.Println(utils.Red("national number should be 8 digits"))
		return
	}

	_, err = p.db.Query(fmt.Sprintf(`insert into person (first_name, last_name, national_no, date_of_birth)
		values ('%s', '%s', %d, '%s');
		insert into teacher (national_no, degrees) 
		values (%d, %s);
		insert into teacherschool (teacher_national_no, school_id)
		values (%d, %s);`, fName, lName, nNo, bDate, nNo, degrees, nNo, schoolID))
	if err != nil {
		log.Println(utils.Red(err))
		return
	}
	fmt.Println(utils.Green("\ncreated successfully"))
}
func (p *Prompt) ShowSingleTeacher(args []string) {

}
func (p *Prompt) ShowTeacherExams(args []string) {

}
func (p *Prompt) ShowTeacherCourses(args []string) {

}
func (p *Prompt) ShowCourses() {
	// TODO
}

func (p *Prompt) CreateCourse() {
	var title string
	fmt.Printf(utils.Cyan("\ncourse name: "))
	fmt.Scan(&title)

	_, err := p.db.Query(fmt.Sprintf(`insert into course (title) values ('%s');`, title))
	if err != nil {
		log.Println(utils.Red(err))
		return
	}
	fmt.Println(utils.Green("\ncreated successfully"))
}
func (p *Prompt) ShowSingleCourse(args []string) {

}
func (p *Prompt) ShowCourseTeachers(args []string) {

}
func (p *Prompt) ShowCourseStudents(args []string) {

}
func (p *Prompt) ShowCourseGraduates(args []string) {

}
func (p *Prompt) ShowCourseExams(args []string) {

}
func (p *Prompt) ShowExams() {
	// TODO
}
func (p *Prompt) CreateExam() {
	// TODO
}
func (p *Prompt) ShowSingleExam(args []string) {

}
func (p *Prompt) ShowExamQuestions(args []string) {

}
func (p *Prompt) ShowQuestions() {
	rows, err := p.db.Query("select id, question_text, issued_by from question")
	if err != nil {
		log.Fatal(utils.Red(err))
	}

	var id, issuedBy int
	var qText string
	// var schoolname string

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"ID", "issued by", "question"})

	for rows.Next() {
		err = rows.Scan(&id, &qText, &issuedBy)
		if err != nil {
			log.Fatal(utils.Red(err))
		}
		t.AppendRow([]interface{}{strconv.Itoa(id), qText, strconv.Itoa(issuedBy)})
	}
	t.Render()
}
func (p *Prompt) CreateQuestion() {
	var qText, qAnswer, comments, teacherID string
	fmt.Println(utils.Yellow("\nin order to create a question you should be a teacher."))
	fmt.Printf(utils.Cyan("your national number: "))
	fmt.Scan(&teacherID)
	fmt.Printf(utils.Cyan("question text: "))
	qText, _ = Reader.ReadString('\n')
	fmt.Printf(utils.Cyan("answer: "))
	qAnswer, _ = Reader.ReadString('\n')
	fmt.Printf(utils.Cyan("comments: "))
	comments, _ = Reader.ReadString('\n')

	// four choices
	var is4Choice string
	fmt.Printf(utils.Cyan("four choices? [y/n]: "))
	fmt.Scan(&is4Choice)
	if utils.Contains(utils.Confirmation, is4Choice) {
		var choice1, choice2, choice3, choice4, correctChoice string
		fmt.Printf(utils.Cyan("\nfirst choice: "))
		choice1, _ = Reader.ReadString('\n')
		fmt.Printf(utils.Cyan("second choice: "))
		choice2, _ = Reader.ReadString('\n')
		fmt.Printf(utils.Cyan("third choice: "))
		choice3, _ = Reader.ReadString('\n')
		fmt.Printf(utils.Cyan("fourth choice: "))
		choice4, _ = Reader.ReadString('\n')
		fmt.Printf(utils.Cyan("correct choice (its index eg.:(1~4)): "))
		fmt.Scan(&correctChoice)
		_, err := p.db.Query(fmt.Sprintf(`insert into fourchoice (first_choice, second_choice, third_choice, fourth_choice)
		 values ('%s', '%s', '%s', '%s');`, choice1, choice2, choice3, choice4))
		if err != nil {
			log.Println(utils.Red(err))
			return
		}
		var id int
		row, err := p.db.Query(fmt.Sprintf(`select id from fourchoice order by id desc limit 1`))
		row.Next()
		err = row.Scan(&id)
		if err != nil {
			log.Fatal(utils.Red(err))
		}
		_, err = p.db.Query(fmt.Sprintf(`insert into question (question_text, answer_text, comments, issued_by, choices, correct_choice) 
		values ('%s','%s','%s',%s, %d, %s);`, qText, qAnswer, comments, teacherID, id, correctChoice))
		if err != nil {
			log.Println(utils.Red(err))
			return
		}
		fmt.Println(utils.Green("\ncreated successfully"))
		return
	} else if utils.Contains(utils.Refuse, is4Choice) {
		_, err := p.db.Query(fmt.Sprintf(`insert into question (question_text, answer_text, comments, issued_by) 
		 values ('%s','%s','%s',%s);`, qText, qAnswer, comments, teacherID))
		if err != nil {
			log.Println(utils.Red(err))
			return
		}
		fmt.Println(utils.Green("\ncreated successfully"))
		return
	}

}
func (p *Prompt) ShowSingleQuestion(args []string) {
	rows, err := p.db.Query(fmt.Sprintf("select question.id,question_text,answer_text,comments,issued_by,first_choice,second_choice,third_choice,fourth_choice,correct_choice from question left join fourchoice on question.choices = fourchoice.id  where question.id =  %s;", args[2]))
	if err != nil {
		log.Fatal(err)
	}
	var qID, issuedBy, correctChoice int
	var qText, qAnswer, comments, choice1, choice2, choice3, choice4 string

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"ID", "question", "answer", "comments", "issued by", "choice 1", "choice2", "choice3", "choice4", "correct choice"})

	for rows.Next() {
		err = rows.Scan(&qID, &qText, &qAnswer, &comments, &issuedBy, &choice1, &choice2, &choice3, &choice4, &correctChoice)
		if err != nil {
			rows.Scan(&qID, &qText, &qAnswer, &comments, &issuedBy)
			// log.Fatal(err)
		}
		t.AppendRow([]interface{}{strconv.Itoa(qID), qText, qAnswer, comments, strconv.Itoa(issuedBy), choice1, choice2, choice3, choice4, strconv.Itoa(correctChoice)})
	}
	t.Render()
}
func (p *Prompt) ShowExamSubmissions(args []string) {

}
func (p *Prompt) ShowQuestionSubmissions(args []string) {

}
func (p *Prompt) ShowSubmissions() {
	// TODO
}
func (p *Prompt) CreateSubmission() {
	// TODO
}
func (p *Prompt) ShowSingleSubmission(args []string) {

}
func (p *Prompt) EvalueteSubmission(args []string) {

}
func (p *Prompt) ShowSchools() {
	// TODO
}
func (p *Prompt) CreateSchool() {
	var name, manager_id, address string
	fmt.Printf(utils.Cyan("\nschool name: "))
	fmt.Scan(&name)
	fmt.Printf(utils.Cyan("manager national number: "))
	fmt.Scan(&manager_id)
	fmt.Printf(utils.Cyan("school address: "))
	fmt.Scan(&address)

	_, err := p.db.Query(fmt.Sprintf(`insert into school (name, manager_id, address)
		values ('%s', '%s', '%s');`, name, manager_id, address))
	if err != nil {
		log.Println(utils.Red(err))
		return
	}
	fmt.Println(utils.Green("\ncreated successfully"))
}
func (p *Prompt) ShowSingleSchool(args []string) {

}
func (p *Prompt) ShowSchoolTeachers(args []string) {

}
func (p *Prompt) ShowSchoolStudents(args []string) {

}
func (p *Prompt) ShowSchoolCourses(args []string) {

}
func (p *Prompt) ShowSchoolExams(args []string) {

}
