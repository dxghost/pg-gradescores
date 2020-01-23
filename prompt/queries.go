package prompt

import (
	"log"
	"github.com/jedib0t/go-pretty/table"
	"os"
	"strconv"	

)
// ShowStudents Query to get all students in database
func (p *Prompt) ShowStudents(){
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
		t.AppendRow([]interface{}{strconv.Itoa(nno), fname, lname, strconv.Itoa(edgrade),schoolname})
	}
	t.Render()
}