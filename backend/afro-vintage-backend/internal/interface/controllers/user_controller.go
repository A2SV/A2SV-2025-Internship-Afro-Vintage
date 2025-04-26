package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/user"
)

type UserController struct {
	userUC user.Usecase
}

func NewUserController(userUC user.Usecase) *UserController {
	return &UserController{userUC: userUC}
}

// GetUserByID handles GET /api/users/:id
func (c *UserController) GetUserByID(ctx *gin.Context) {
	userID := ctx.Param("id")
	if userID == "" {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "user ID is required"})
		return
	}

	user, err := c.userUC.GetByID(ctx, userID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Only return public user information
	ctx.JSON(http.StatusOK, gin.H{
		"id":       user.ID,
		"username": user.Username,
		"email":    user.Email,
		"role":     user.Role,
	})
} 