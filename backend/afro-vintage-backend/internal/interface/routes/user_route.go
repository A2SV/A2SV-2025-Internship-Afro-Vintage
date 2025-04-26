package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/user"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/interface/controllers"
)

func SetupUserRoutes(router *gin.Engine, userUC user.Usecase) {
	userController := controllers.NewUserController(userUC)
	
	// Public user routes
	userRoutes := router.Group("/api/users")
	{
		userRoutes.GET("/:id", userController.GetUserByID)
	}
} 