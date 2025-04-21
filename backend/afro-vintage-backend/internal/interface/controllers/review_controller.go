package controllers

import (
	"context"
	"net/http"

	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/product"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/review"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/trust"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/models"
	"github.com/gin-gonic/gin"
)

type ReviewController struct {
	usecase        review.Usecase
	trustUsecase   trust.Usecase
	productUsecase product.Usecase
}

func NewReviewController(usecase review.Usecase, trustUsecase trust.Usecase, productUsecase product.Usecase) *ReviewController {
	return &ReviewController{
		usecase:        usecase,
		trustUsecase:   trustUsecase,
		productUsecase: productUsecase,
	}
}

func (ctrl *ReviewController) SubmitReview(c *gin.Context) {
	var req models.CreateReviewRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request"})
		return
	}

	userID := c.GetString("userID")
	if userID == "" {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "unauthorized"})
		return
	}

	// Get the product to get the reseller ID and current rating
	product, err := ctrl.productUsecase.GetProductByID(c.Request.Context(), req.ProductID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "product not found"})
		return
	}

	r := &review.Review{
		OrderID:   req.OrderID,
		ProductID: req.ProductID,
		UserID:    userID,
		Rating:    req.Rating,
		Comment:   req.Comment,
	}

	if err := ctrl.usecase.SubmitReview(c.Request.Context(), r); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Update reseller trust score
	if ctrl.trustUsecase != nil {
		go ctrl.trustUsecase.UpdateResellerTrustScoreOnNewRating(
			context.Background(),
			product.ResellerID.Hex(),
			product.Rating,
			float64(req.Rating),
		)
	}

	c.JSON(http.StatusCreated, gin.H{"message": "review submitted"})
}
