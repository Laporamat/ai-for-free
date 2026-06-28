package repository

import (
	"database/sql"
	"fmt"
	"github.com/ai-for-free/backend/internal/models"
	_ "github.com/lib/pq"
	"log"
)

type Repository struct {
	DB *sql.DB
}

func NewRepository(connStr string) (*Repository, error) {
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}
	
	if err := db.Ping(); err != nil {
		return nil, err
	}
	
	log.Println("Connected to database successfully")
	return &Repository{DB: db}, nil
}

func (r *Repository) GetIngredients() ([]models.Ingredient, error) {
	rows, err := r.DB.Query("SELECT id, name, note_type, description, created_at FROM ingredients")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var ingredients []models.Ingredient
	for rows.Next() {
		var i models.Ingredient
		if err := rows.Scan(&i.ID, &i.Name, &i.NoteType, &i.Description, &i.CreatedAt); err != nil {
			return nil, err
		}
		ingredients = append(ingredients, i)
	}
	return ingredients, nil
}

func (r *Repository) GetFragranceFamilies() ([]models.FragranceFamily, error) {
	rows, err := r.DB.Query("SELECT id, name, description, created_at FROM fragrance_families")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var families []models.FragranceFamily
	for rows.Next() {
		var f models.FragranceFamily
		if err := rows.Scan(&f.ID, &f.Name, &f.Description, &f.CreatedAt); err != nil {
			return nil, err
		}
		families = append(families, f)
	}
	return families, nil
}

func (r *Repository) GetDesignTips() ([]models.DesignTip, error) {
	rows, err := r.DB.Query("SELECT id, tip, category, created_at FROM design_tips")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var tips []models.DesignTip
	for rows.Next() {
		var t models.DesignTip
		if err := rows.Scan(&t.ID, &t.Tip, &t.Category, &t.CreatedAt); err != nil {
			return nil, err
		}
		tips = append(tips, t)
	}
	return tips, nil
}

func (r *Repository) CreatePerfume(p models.Perfume) (int, error) {
	var id int
	err := r.DB.QueryRow(
		"INSERT INTO perfumes (name, brand, family_id, description) VALUES ($1, $2, $3, $4) RETURNING id",
		p.Name, p.Brand, p.FamilyID, p.Description,
	).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

func (r *Repository) Close() error {
	return r.DB.Close()
}
