package routes

import (
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/auth"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/user"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/interface/controllers"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/interface/middlewares"
	"github.com/gin-gonic/gin"
)

func SetupUserRoutes(router *gin.Engine, userUsecase user.Usecase, jwtSvc auth.JWTService) {
	userController := controllers.NewUserController(userUsecase)

	// Public user routes
	userRoutes := router.Group("/api/users")
	{
		userRoutes.GET("/:id", userController.GetUserByID)
	}

	userGroup := router.Group("/api/users")
	{
		userGroup.Use(middlewares.AuthMiddleware(jwtSvc))
		userGroup.PUT("/profile", userController.UpdateProfile)
	}
}
func SetupUploadRoutes(router *gin.Engine) {
	uploadController := controllers.NewUploadController()

	uploadGroup := router.Group("/api")
	{
		uploadGroup.POST("/upload", uploadController.UploadImage)
	}
}
