package prompt

import (
	"bufio"
	"database/sql"
	"fmt"
	"github.com/dxghost/pg-gradescores/utils"
	"log"
	"os"
	"strings"
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
	reader := bufio.NewReader(os.Stdin)
	p.ShowHelp()
	// TODO add Delete functions
	for {
		p.printPrompt()
		input, err := reader.ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}
		args := strings.Split(input[:len(input)-1], " ")
		switch args[0] {
		case "students":
			if len(args) == 1 {
				p.ShowStudents()
			} else {
				switch args[1] {
				case "create":
					p.CreateStudent()
				case "number":
					if len(args) == 3 {
						p.ShowSingleStudent(args)
					} else {
						switch args[2] {
						case "grades":
							p.ShowStudentGrades(args)

						case "exams":
							p.ShowStudentExams(args)
						default:
							fmt.Println(utils.Red("Wrong command"))
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}

		case "teachers":
			if len(args) == 1 {
				p.ShowTeachers()
			} else {
				switch args[1] {
				case "create":
					p.CreateTeacher()
				case "number":
					if len(args) == 3 {
						p.ShowSingleTeacher(args)
					} else {
						switch args[2] {
						case "exams":
							p.ShowTeacherExams(args)
						case "courses":
							p.ShowTeacherCourses(args)
						default:
							fmt.Println(utils.Red("Wrong command"))
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}
		case "courses":
			if len(args) == 1 {
				p.ShowCourses()
			} else {
				switch args[1] {
				case "create":
					p.CreateCourse()
				case "number":
					if len(args) == 3 {
						p.ShowSingleCourse(args)
					} else {
						switch args[2] {
						case "teachers":
							p.ShowCourseTeachers(args)
						case "students":
							p.ShowCourseStudents(args)
						case "graduates":
							p.ShowCourseGraduates(args)
						case "exams":
							p.ShowCourseExams(args)
						default:
							fmt.Println(utils.Red("Wrong command"))
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}
		case "schools":
			// // TODO list all students studying grade n
			// // TODO list all teachers presenting that course in shcool
			// // TODO list all students taking that course in school
			// // TODO list all exams took part in school for course x
			// // TODO list all exams took part in school for grade x
			if len(args) == 1 {
				p.ShowSchools()
			} else {
				switch args[1] {
				case "create":
					p.CreateSchool()
				case "number":
					if len(args) == 3 {
						p.ShowSingleSchool(args)
					} else {
						switch args[2] {
						case "teachers":
							p.ShowSchoolTeachers(args)
						case "students":
							p.ShowSchoolStudents(args)
						case "courses":
							p.ShowSchoolCourses(args)
						case "exams":
							p.ShowSchoolExams(args)
						default:
							fmt.Println(utils.Red("Wrong command"))
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}
		case "exams":
			if len(args) == 1 {
				p.ShowExams()
			} else {
				switch args[1] {
				case "create":
					p.CreateExam()
				case "number":
					if len(args) == 3 {
						p.ShowSingleExam(args)
					} else {
						switch args[2] {
						case "questions":
							p.ShowExamQuestions(args)
						case "submissions":
							p.ShowExamSubmissions(args)
						default:
							fmt.Println(utils.Red("Wrong command"))
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}
		case "questions":
			if len(args) == 1 {
				p.ShowQuestions()
			} else {
				switch args[1] {
				case "create":
					p.CreateQuestion()
				case "number":
					if len(args) == 3 {
						p.ShowSingleQuestion(args)
					} else {
						switch args[2] {
						case "submissions":
							p.ShowQuestionSubmissions(args)
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}
		case "submissions":
			if len(args) == 1 {
				p.ShowSubmissions()
			} else {
				switch args[1] {
				case "create":
					p.CreateSubmission()
				case "number":
					if len(args) == 3 {
						p.ShowSingleSubmission(args)
					} else {
						switch args[2] {
						case "evaluate":
							p.EvalueteSubmission(args)
						default:
							fmt.Println(utils.Red("Wrong command"))
						}
					}
				default:
					fmt.Println(utils.Red("Wrong command"))
				}
			}
		default:
			fmt.Println(utils.Red("Wrong command"))
		}

	}
}

func (p *Prompt) printPrompt() {
	fmt.Println()
	fmt.Print(utils.BlinkingMagenta(";)"), utils.Yellow(" > "))
}
