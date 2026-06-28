package models

import "time"

type Ingredient struct {
	ID          int       `json:"id"`
	Name        string    `json:"name"`
	NoteType    string    `json:"note_type"`
	Description string    `json:"description"`
	CreatedAt   time.Time `json:"created_at"`
}

type FragranceFamily struct {
	ID          int       `json:"id"`
	Name        string    `json:"name"`
	Description string    `json:"description"`
	CreatedAt   time.Time `json:"created_at"`
}

type Perfume struct {
	ID          int       `json:"id"`
	Name        string    `json:"name"`
	Brand       string    `json:"brand"`
	FamilyID    int       `json:"family_id"`
	Description string    `json:"description"`
	CreatedAt   time.Time `json:"created_at"`
}

type DesignTip struct {
	ID        int       `json:"id"`
	Tip       string    `json:"tip"`
	Category  string    `json:"category"`
	CreatedAt time.Time `json:"created_at"`
}
