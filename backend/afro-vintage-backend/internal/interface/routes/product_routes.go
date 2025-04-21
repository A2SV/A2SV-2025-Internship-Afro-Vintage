package routes

import (
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/auth"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/product"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/trust"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/interface/controllers"
	"github.com/gin-gonic/gin"
)

func RegisterProductRoutes(
	r *gin.Engine,
	productCtrl *controllers.ProductController,
	jwtSvc auth.JWTService,
	reviewCtrl *controllers.ReviewController,
	trustUC trust.Usecase,
	productUC product.Usecase,
) {
	products := r.Group("/products")
	{
		products.POST("", productCtrl.Create)
		products.GET("", productCtrl.ListAvailable)
		products.GET("/:id", productCtrl.GetByID)
		products.PUT("/:id", productCtrl.Update)
		products.DELETE("/:id", productCtrl.Delete)
		products.POST("/:id/reviews", reviewCtrl.SubmitReview)
	}
}
