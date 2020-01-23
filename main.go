package main

// TODO update ERD
import (

	"log"
	"fmt"
	// "strconv"
	utils "github.com/dxghost/pg-gradescores/utils"
	prompt "github.com/dxghost/pg-gradescores/prompt"
)



func main() {
	// fmt.Println(utils.Yellow("In order to start, you should first install postgresql and create a database named 'gradescores'"))
	// fmt.Printf(utils.Green("Connect to database [y/n]? "))
	// var answer string
	// fmt.Scan(&answer)
	// fmt.Println()
	// if answer == "n"{ return }
	// var host, port, username, password string
	// var intport int

	// fmt.Printf(utils.Cyan("host: "))
	// fmt.Scan(&host)
	// fmt.Printf(utils.Cyan("port: "))
	// fmt.Scan(&port)
	// intport, err := strconv.Atoi(port)
	// if err!=nil{log.Fatal(utils.Red("Port should be a number"))	}
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

	var answer string
	fmt.Println()
	fmt.Println(utils.Yellow("This step is only needed for the first time."))
	fmt.Printf(utils.Green("Initialize definitions? [y/n]? "))
	fmt.Scan(&answer)
	if answer == "y"{
		err = utils.CreateTables(db)
		if err != nil {
			log.Fatal(utils.Red(err))
		}
		err = utils.CreateAssertions(db)
		if err != nil {
			log.Fatal(utils.Red(err))
		}
	
		err = utils.CreateTriggers(db)
		if err != nil {
			log.Fatal(utils.Red(err))
		} 
	}

	p := prompt.CreatePrompt(db)
	p.Start()

	// rows, err := db.Query("SELECT * FROM Person")
	// if err!=nil{
	// 	log.Fatal(err)
	// }

	// var x int
	// var y int
	// var z int
	// for rows.Next(){
	// 	err = rows.Scan(&x,&y,&z)
	// 	if err!=nil{
	// 		log.Fatal(err)
	// 	}
	// 	log.Println(x,y,z)
	// }

}
