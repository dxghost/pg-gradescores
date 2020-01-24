package prompt

import (
	"fmt"
)
// TODO add treeview for helps using termui
func (p *Prompt) ShowHelp() {
	helpMessage :=`
	fmt.Println()
	fmt.Println(utils.Green("Available commands:"))
	fmt.Println(utils.Green("	students"))
	fmt.Println(utils.Green("	teachers"))
	fmt.Println()
`
	fmt.Println(helpMessage)
}
