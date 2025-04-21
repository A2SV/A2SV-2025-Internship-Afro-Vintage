package review

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func TestReview_Validate(t *testing.T) {
	tests := []struct {
		name    string
		review  Review
		wantErr bool
	}{
		{
			name: "valid review",
			review: Review{
				OrderID:   primitive.NewObjectID().Hex(),
				ProductID: primitive.NewObjectID().Hex(),
				UserID:    primitive.NewObjectID().Hex(),
				Rating:    4,
				Comment:   "Great product!",
			},
			wantErr: false,
		},
		{
			name: "invalid rating",
			review: Review{
				OrderID:   primitive.NewObjectID().Hex(),
				ProductID: primitive.NewObjectID().Hex(),
				UserID:    primitive.NewObjectID().Hex(),
				Rating:    6,
				Comment:   "Great product!",
			},
			wantErr: true,
		},
		{
			name: "missing required fields",
			review: Review{
				Rating:  4,
				Comment: "Great product!",
			},
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := tt.review.Validate()
			if tt.wantErr {
				assert.Error(t, err)
			} else {
				assert.NoError(t, err)
			}
		})
	}
}

func TestReview_CalculateTrustImpact(t *testing.T) {
	tests := []struct {
		name           string
		declaredRating float64
		actualRating   int
		wantImpact     float64
	}{
		{"perfect match", 4.5, 4, 0.5},
		{"small difference", 4.0, 3, 1.0},
		{"large difference", 2.0, 4, 2.0},
		{"negative difference", 4.5, 2, 2.5},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			r := Review{Rating: tt.actualRating}
			impact := r.CalculateTrustImpact(tt.declaredRating)
			assert.Equal(t, tt.wantImpact, impact)
		})
	}
}

func TestReview_NewReview(t *testing.T) {
	orderID := primitive.NewObjectID().Hex()
	productID := primitive.NewObjectID().Hex()
	userID := primitive.NewObjectID().Hex()

	r := NewReview(orderID, productID, userID, 4, "Great product!")

	assert.NotEmpty(t, r.ID)
	assert.Equal(t, orderID, r.OrderID)
	assert.Equal(t, productID, r.ProductID)
	assert.Equal(t, userID, r.UserID)
	assert.Equal(t, 4, r.Rating)
	assert.Equal(t, "Great product!", r.Comment)
	assert.NotEmpty(t, r.CreatedAt)
}

func TestReview_UpdateRating(t *testing.T) {
	r := Review{
		Rating: 4,
	}

	// Test valid rating update
	err := r.UpdateRating(5)
	assert.NoError(t, err)
	assert.Equal(t, 5, r.Rating)

	// Test invalid rating update
	err = r.UpdateRating(6)
	assert.Error(t, err)
	assert.Equal(t, 5, r.Rating) // Rating should remain unchanged
}
