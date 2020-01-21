package main

// TODO update ERD
import (

	"log"
	utils "pg-gradescores/utils"
)



func main() {

	db, err := utils.ConnectPG("postgres", "dx", 5432, "127.0.0.1")
	if err != nil {
		log.Fatal(utils.Red(err))
	}

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

