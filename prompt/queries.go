package prompt

import (
	"fmt"
	utils "github.com/dxghost/pg-gradescores/utils"
	"github.com/jedib0t/go-pretty/table"
	"log"
	"os"
	"strconv"
)

// ShowStudents Query to get all students in database
func (p *Prompt) ShowStudents() {
	rows, err := p.db.Query("SELECT national_no, first_name, last_name, educational_grade, name as school_name FROM School natural join StudentSchool natural join Student natural join Person")
	if err != nil {
		log.Fatal(err)
	}

	var nno int
	var fname string
	var lname string
	var edgrade int
	var schoolname string

	t := table.NewWriter()
	t.SetOutputMirror(os.Stdout)
	t.AppendHeader(table.Row{"national number", "first name", "last name", "educational grade", "school name"})

	for rows.Next() {
		err = rows.Scan(&nno, &fname, &lname, &edgrade, &schoolname)
		if err != nil {
			log.Fatal(err)
		}
		t.AppendRow([]interface{}{strconv.Itoa(nno), fname, lname, strconv.Itoa(edgrade), schoolname})
	}
	t.Render()
}

func (p *Prompt) CreateStudent() {
	var fName, lName, bDate, inNo, inEdGrade string
	var nNo, edGrade int
	fmt.Printf(utils.Cyan("\nfirst name: "))
	fmt.Scan(&fName)
	fmt.Printf(utils.Cyan("last name: "))
	fmt.Scan(&lName)
	fmt.Printf(utils.Cyan("birthdate (in 1991-12-10 format): "))
	fmt.Scan(&bDate)
	fmt.Printf(utils.Cyan("national number (8 digits): "))
	fmt.Scan(&inNo)
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
	if (edGrade > 12 || edGrade<0) {
		log.Fatal(utils.Red("educational grade should be between (0,12)"))
	}
	_, err = p.db.Query(fmt.Sprintf(`insert into person (first_name, last_name, national_no, date_of_birth)
		values ('%s', '%s', %d, '%s');
		insert into student (national_no, educational_grade) 
		values (%d, %d);`,fName, lName, nNo, bDate,nNo,edGrade))
	if err != nil{
		log.Println(utils.Red(err))
		return
	}
}
func (p *Prompt) ShowSingleStudent(args []string) {
	return
}
func (p *Prompt) ShowStudentGrades(args []string) {
}
func (p *Prompt) ShowStudentExams(args []string) {
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
	return
}
func (p *Prompt) ShowSingleTeacher(args []string) {

}
func (p *Prompt) ShowTeacherExams(args []string) {

}
func (p *Prompt) ShowTeacherCourses(args []string) {

}
func (p *Prompt) ShowCourses() {

}
func (p *Prompt) CreateCourse() {

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

}
func (p *Prompt) CreateExam() {

}
func (p *Prompt) ShowSingleExam(args []string) {

}
func (p *Prompt) ShowExamQuestions(args []string) {

}
func (p *Prompt) ShowQuestions() {

}
func (p *Prompt) CreateQuestion() {

}
func (p *Prompt) ShowSingleQuestion(args []string) {

}
func (p *Prompt) ShowExamSubmissions(args []string) {

}
func (p *Prompt) ShowQuestionSubmissions(args []string) {

}
func (p *Prompt) ShowSubmissions() {

}
func (p *Prompt) CreateSubmission() {

}
func (p *Prompt) ShowSingleSubmission(args []string) {

}
func (p *Prompt) EvalueteSubmission(args []string) {

}
func (p *Prompt) ShowSchools() {

}
func (p *Prompt) CreateSchool() {

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
