package main

import (
	"log"
	"math/rand"
	"net/http"
)

var names = []string{"Mike", "Bob", "Alice"}

func main() {
	http.HandleFunc("/name", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Write([]byte(names[rand.Intn(3)]))
	})
	if err := http.ListenAndServe(":80", nil); err != nil {
		log.Fatal("failed to listen and serve")
	}
}
