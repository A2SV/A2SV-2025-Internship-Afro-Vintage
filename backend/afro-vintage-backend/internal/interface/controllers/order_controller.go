package controllers

import (
	"fmt"
	"net/http"

	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/order"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/models/common"
	"github.com/gin-gonic/gin"
)

type OrderController struct {
	orderUseCase order.Usecase
}

func NewOrderController(orderUseCase order.Usecase) *OrderController {
	return &OrderController{orderUseCase: orderUseCase}
}

func (c *OrderController) PurchaseBundle(ctx *gin.Context) {
	type Request struct {
		BundleID string `json:"bundle_id"`
	}

	var req Request
	if err := ctx.ShouldBindJSON(&req); err != nil || req.BundleID == "" {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "invalid payload; bundleId is required"})
		return
	}

	resellerID, _ := ctx.Get("userID")

	resellerIDStr, ok := resellerID.(string)
	if !ok || resellerIDStr == "" {
		ctx.JSON(http.StatusUnauthorized, common.APIResponse{
			Success: false,
			Message: "invalid or empty user ID in context",
		})
		return
	}

	order, payment, warehouseItem, err := c.orderUseCase.PurchaseBundle(ctx, req.BundleID, resellerIDStr)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{
		"order":         order,
		"payment":       payment,
		"warehouseItem": warehouseItem,
	})
}

func (c *OrderController) GetOrderByID(ctx *gin.Context) {
	orderID := ctx.Param("id")
	if orderID == "" {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "order id is required"})
		return
	}

	order, err := c.orderUseCase.GetOrderByID(ctx, orderID)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, order)
}

func (c *OrderController) GetSoldBundleHistory(ctx *gin.Context) {
	supplierID, exists := ctx.Get("userID")
	if !exists {
		ctx.JSON(http.StatusUnauthorized, common.APIResponse{
			Success: false,
			Message: "user ID not found in context",
		})
		return
	}

	supplierIDStr, ok := supplierID.(string)
	if !ok || supplierIDStr == "" {
		ctx.JSON(http.StatusUnauthorized, common.APIResponse{
			Success: false,
			Message: "invalid user ID format",
		})
		return
	}

	orders, err := c.orderUseCase.GetSoldBundleHistory(ctx, supplierIDStr)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, common.APIResponse{
			Success: false,
			Message: fmt.Sprintf("failed to get sold bundle history: %v", err),
		})
		return
	}

	ctx.JSON(http.StatusOK, common.APIResponse{
		Success: true,
		Data:    orders,
	})
}