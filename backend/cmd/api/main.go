package main

import (
	"log"
	"os"

	"github.com/ai-for-free/backend/internal/handlers"
	"github.com/ai-for-free/backend/internal/repository"
	"github.com/gin-gonic/gin"
)

func main() {
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		connStr = "host=localhost port=5432 user=postgres password=postgres dbname=ai_perfumer sslmode=disable"
	}

	repo, err := repository.NewRepository(connStr)
	if err != nil {
		log.Fatalf("Failed to connect to database: ", err)
	}
	defer repo.Close()

	h := handlers.NewHandler(repo)

	r := gin.Default()

	api := r.Group("/api/v1")
	{
		api.GET("/health", h.HealthCheck)
		api.GET("/ingredients", h.GetIngredients)
		api.GET("/fragrance-families", h.GetFragranceFamilies)
		api.GET("/design-tips", h.GetDesignTips)
		api.POST("/perfumes", h.CreatePerfume)
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server starting on port %s", port)
	if err := r.Run(":" + port); err != nil {
		log.Fatalf("Failed to start server: ", err)
	}
}
