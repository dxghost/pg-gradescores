package prompt

import (
	"database/sql"
	"log"
	"fmt"
	"github.com/dxghost/pg-gradescores/utils"
	"strings"
)

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

func (p *Prompt) Start() {
	var input string
	fmt.Println()
	fmt.Println(utils.Green("Available commands:"))
	fmt.Println(utils.Green("	Students"))
	fmt.Println(utils.Green("	Teachers"))
	fmt.Println()
	for {
		printPrompt()
		fmt.Scan(&input)
		args := strings.Split(input, " ")
		switch args[0] {
		case "Students":
			rows, err := p.db.Query("SELECT national_no, first_name, last_name, educational_grade FROM Student natural join Person")
			if err != nil {
				log.Fatal(err)
			}
			var nno int
			var fname string
			var lname string
			var edgrade int
			for rows.Next() {
				err = rows.Scan(&nno, &fname, &lname, &edgrade)
				if err != nil {
					log.Fatal(err)
				}
				// TODO table design (spacing)
				// TODO migrate query functions
				fmt.Println(nno, fname, lname, edgrade)
			}

		case "Teachers":
			fmt.Println(utils.Red("Teaches"))
		default:
			fmt.Println(utils.Red("Wrong command"))
		}

	}
}

func printPrompt() {
	fmt.Println()
	fmt.Printf(utils.Cyan("> "))
}
