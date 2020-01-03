package main

import (
	"log"
	"net/http"
)

func healthcheck(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Healthcheck", "True")
	w.WriteHeader(http.StatusOK)
}

func serveFiles(w http.ResponseWriter, r *http.Request) {
	log.Printf("Path %s", r.URL.Path)
	p := "." + r.URL.Path
	if p == "./" {
		p = "./index.html"
	}
	log.Printf("Return %s", p)
	http.ServeFile(w, r, p)
}

func main() {
	http.HandleFunc("/healthcheck", healthcheck)
	http.HandleFunc("/", serveFiles)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
