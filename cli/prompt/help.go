package prompt

import (
	"fmt"
)
// TODO add treeview for helps using termui

// ShowHelp shows help message
func (p *Prompt) ShowHelp() {
	helpMessage :=`
Available commands:
	Students:
		students
		students create
		students number 12345678
	Teachers:
		teachers
		teachers create
		teachers number 12345678
`
	fmt.Println(helpMessage)
}
