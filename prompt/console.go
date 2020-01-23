package prompt

import (
	"database/sql"
	"fmt"
	"strings"

	"github.com/dxghost/pg-gradescores/utils"
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
			if len(args) == 1 {
				p.ShowStudents()
			} else {
				continue
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
