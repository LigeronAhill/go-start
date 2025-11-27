package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	println("Starting server ")
	http.HandleFunc("/", handler)
	fmt.Println("Сервер запущен на http://localhost:34567")
	if err := http.ListenAndServe(":34567", nil); err != nil {
		log.Fatal(err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	if _, err := fmt.Fprintf(w, "Hello, Go!"); err != nil {
		panic(err)
	}
}
