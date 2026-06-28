package handlers

import (
	"github.com/ai-for-free/backend/internal/models"
	"github.com/ai-for-free/backend/internal/repository"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Handler struct {
	Repo *repository.Repository
}

func NewHandler(repo *repository.Repository) *Handler {
	return &Handler{Repo: repo}
}

func (h *Handler) GetIngredients(c *gin.Context) {
	ingredients, err := h.Repo.GetIngredients()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, ingredients)
}

func (h *Handler) GetFragranceFamilies(c *gin.Context) {
	families, err := h.Repo.GetFragranceFamilies()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, families)
}

func (h *Handler) GetDesignTips(c *gin.Context) {
	tips, err := h.Repo.GetDesignTips()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, tips)
}

func (h *Handler) CreatePerfume(c *gin.Context) {
	var perfume models.Perfume
	if err := c.ShouldBindJSON(&perfume); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	id, err := h.Repo.CreatePerfume(perfume)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, gin.H{"id": id})
}

func (h *Handler) HealthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{"status": "ok", "service": "ai-for-free perfume API"})
}
