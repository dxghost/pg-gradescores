package prompt

import (
	"database/sql"
	"fmt"
	"strings"

	"github.com/dxghost/pg-gradescores/utils"
)

// Prompt is the commandline interface
type Prompt struct {
	db *sql.DB
	// queryAgent *utils.Query
}

// CreatePrompt creates a prompt
func CreatePrompt(db *sql.DB) *Prompt {
	p := &Prompt{
		db: db,
	}
	return p
}

// Start the prompt
func (p *Prompt) Start() {
	var input string
	// TODO implement ShowHelps func
	fmt.Println()
	fmt.Println(utils.Green("Available commands:"))
	fmt.Println(utils.Green("	Students"))
	fmt.Println(utils.Green("	Teachers"))
	fmt.Println()
	for {
		p.printPrompt()
		fmt.Scan(&input)
		args := strings.Split(input, " ")
		switch args[0] {
		case "Students":
			// TODO List all students grades
			// TODO signup for a student
			// TODO show Student #x
			// TODO show students exams taken
			// TODO show students exams evaluations
			if len(args) == 1 {
				p.ShowStudents()
			} else {
				continue
			}

		case "Teachers":
			// TODO List all Teachers
			// TODO signup for a teacher
			// TODO list all Exams created by that teacher
			if len(args) == 1 {
				p.ShowTeachers()
			} else {
				continue
			}
		case "Courses":
			// TODO list all courses
			// TODO list all teachers presenting course #x
			// TODO list all students taking course #x
			// TODO list all Exams for course #x
			// TODO create a course
			if len(args)==1{
				continue
			}
		case "School":
			// TODO list all schools
			// TODO list all students
			// TODO list all teachers
			// TODO list all grades
			// TODO list all students studying grade n
			// TODO list all courses presented in shcool
			// TODO list all teachers presenting that course in shcool
			// TODO list all students taking that course in school
			// TODO list all exams took part in school
			// TODO list all exams took part in school for course x
			// TODO list all exams took part in school for grade x
			// TODO create a school
			if len(args) == 1 {
				continue
			}
		case "Exams":
			// TODO show all exams
			// TODO show Exam #x
			// TODO show exam #x questions
			// TODO Create an exam
			if len(args) == 1 {
				continue
			}
		case "Questions":
			// TODO show all Questions
			// TODO Create a Question (during it ask for fourchoices)
			if len(args) == 1 {
				continue
			}
		case "Submissions":
			// TODO list all submissions for exam #x
			// TODO list all question #x for exam #y
			// TODO evaluate submission for exam #x question #y for student #z
			// TODO create a submission fo student #x for exam #y question #z with answer #a
			if len(args) == 1 {
				continue
			}
		default:
			fmt.Println(utils.Red("Wrong command"))
		}

	}
}

func (p *Prompt) printPrompt() {
	fmt.Println()
	fmt.Printf(utils.Cyan("> "))
}
