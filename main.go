package main

// TODO update ERD
import (
	"fmt"
	"log"
	// "strconv"
	prompt "github.com/dxghost/pg-gradescores/prompt"
	utils "github.com/dxghost/pg-gradescores/utils"
)

func main() {
	// Message handle
	var recreateSchema = `If you want a fresh DDL first you should recreate the schma
in order to do that execute commands bellow:

drop schema public cascade;
create schema public;
	`
	var answer string

	// fmt.Println(utils.Yellow("In order to start, you should first install postgresql and create a database named 'gradescores'"))
	// fmt.Printf(utils.Green("Connect to database [y/n]? "))
	// fmt.Scan(&answer)
	// fmt.Println()
	// if utils.Contains(utils.Refuse, answer) {
	// 	return
	// }
	// var host, port, username, password string
	// var intport int
	// fmt.Printf(utils.Cyan("host: "))
	// fmt.Scan(&host)
	// fmt.Printf(utils.Cyan("port: "))
	// fmt.Scan(&port)
	// intport, err := strconv.Atoi(port)
	// if err != nil {
	// 	log.Fatal(utils.Red("Port should be a number"))
	// }
	// fmt.Printf(utils.Cyan("username: "))
	// fmt.Scan(&username)
	// fmt.Printf(utils.Cyan("password: "))
	// fmt.Scan(&password)
	// fmt.Println()
	// db, err := utils.ConnectPG(username, password, intport, host)
	// if err != nil {
	// 	log.Fatal(utils.Red(err))
	// }
	// TODO remove below and uncomment up
	db, err := utils.ConnectPG("postgres", "dx", 5432, "localhost")
	if err != nil {
		log.Fatal(utils.Red(err))
	}

	fmt.Println()
	fmt.Println(utils.Yellow("This step is only needed for the first time."))
	fmt.Printf(utils.Green("Initialize definitions? [y/n]? "))
	fmt.Scan(&answer)
	if utils.Contains(utils.Confirmation, answer) {
		err = utils.CreateTables(db)
		if err != nil {
			log.Println(utils.Red(err))
			fmt.Println(utils.Red(recreateSchema))
			return
		}
		err = utils.CreateAssertions(db)
		if err != nil {
			log.Println(utils.Red(err))
			fmt.Println(utils.Red(recreateSchema))
			return
		}

		err = utils.CreateTriggers(db)
		if err != nil {
			log.Println(utils.Red(err))
			fmt.Println(utils.Red(recreateSchema))
			return
		}
	} else if utils.Contains(utils.Refuse, answer) {
		p := prompt.CreatePrompt(db)
		p.Start()
	}

}
