package prompt

import (
	"log"
	// "fmt"
	"github.com/jedib0t/go-pretty/table"
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
	return
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