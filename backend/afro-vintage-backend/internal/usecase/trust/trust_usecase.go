package trustusecase

import (
	"context"
	"fmt"
	"math"

	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/bundle"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/product"
	"github.com/Zeamanuel-Admasu/afro-vintage-backend/internal/domain/user"
)

type trustUsecase struct {
	productRepo product.Repository
	bundleRepo  bundle.Repository
	userRepo    user.Repository
}

func NewTrustUsecase(
	productRepo product.Repository,
	bundleRepo bundle.Repository,
	userRepo user.Repository,
) *trustUsecase {
	return &trustUsecase{
		productRepo: productRepo,
		bundleRepo:  bundleRepo,
		userRepo:    userRepo,
	}
}

func (uc *trustUsecase) UpdateSupplierTrustScoreOnNewRating(
	ctx context.Context,
	supplierID string,
	declaredRating float64,
	productRating float64,
) error {
	fmt.Println("🔥 TRUST UPDATE CALLED")
	fmt.Println("➡️ Supplier ID:", supplierID)
	fmt.Println("➡️ Declared Rating:", declaredRating)
	fmt.Println("➡️ Product Rating:", productRating)

	// Step 1: Fetch the supplier user
	supplier, err := uc.userRepo.GetByID(ctx, supplierID)
	if err != nil {
		fmt.Println("❌ Failed to fetch supplier:", err)
		return err
	}

	fmt.Println("✅ Supplier Found:", supplier.ID)

	// Step 2: Calculate absolute difference
	diff := math.Abs(productRating - declaredRating)

	// Step 3: Update cumulative error and count
	newTotalError := supplier.TrustTotalError + diff
	newRatedCount := supplier.TrustRatedCount + 1

	// Step 4: Calculate new trust score
	// Calculate new trust score based on average error
	// Score = 100 - (average_error * 20)
	averageError := newTotalError / float64(newRatedCount)
	newTrust := 100 - (averageError * 20)
	if newTrust < 0 {
		newTrust = 0
	} else if newTrust > 100 {
		newTrust = 100
	}
	if newTrust < 40 {
		fmt.Println("⚠️ Supplier trust score below threshold — blacklisting")
		supplier.IsBlacklisted = true
	} else {
		supplier.IsBlacklisted = false // Optional: recover if they improve
	}

	fmt.Println("📊 TRUST SCORE CALCULATION")
	fmt.Println("➡️ Previous Score:", supplier.TrustScore)
	fmt.Println("➡️ New Total Error:", newTotalError)
	fmt.Println("➡️ New Rated Count:", newRatedCount)
	fmt.Println("➡️ New Trust Score (calculated):", newTrust)

	// Step 5: Persist the changes
	supplier.TrustScore = int(newTrust)
	supplier.TrustRatedCount = newRatedCount
	supplier.TrustTotalError = newTotalError

	err = uc.userRepo.UpdateTrustData(ctx, supplier)
	if err != nil {
		fmt.Println("❌ Failed to update supplier trust data:", err)
	} else {
		fmt.Println("✅ Supplier trust data updated successfully")
	}

	return err
}

func (uc *trustUsecase) UpdateResellerTrustScoreOnNewRating(
	ctx context.Context,
	resellerID string,
	declaredRating float64,
	productRating float64,
) error {
	fmt.Println("🔥 RESELLER TRUST UPDATE CALLED")
	fmt.Println("➡️ Reseller ID:", resellerID)
	fmt.Println("➡️ Declared Rating:", declaredRating)
	fmt.Println("➡️ Product Rating:", productRating)

	// Step 1: Fetch the reseller user
	reseller, err := uc.userRepo.GetByID(ctx, resellerID)
	if err != nil {
		fmt.Println("❌ Failed to fetch reseller:", err)
		return err
	}

	fmt.Println("✅ Reseller Found:", reseller.ID)

	// Reset trust data if it's the first rating or if the previous calculation was on a different scale
	if reseller.TrustRatedCount == 0 || reseller.TrustTotalError > 5 {
		fmt.Println("🔄 Resetting trust data for new calculation method")
		reseller.TrustTotalError = 0
		reseller.TrustRatedCount = 0
		reseller.TrustScore = 100
	}

	// Normalize both ratings to 0-5 scale
	normalizedDeclaredRating := (declaredRating / 20.0) // Convert from 0-100 to 0-5 scale
	normalizedProductRating := productRating // Already on 0-5 scale

	// Step 2: Calculate absolute difference on normalized scale
	diff := math.Abs(normalizedProductRating - normalizedDeclaredRating)
	fmt.Println("📊 Rating Difference:", diff)

	// Step 3: Update cumulative error and count
	newTotalError := reseller.TrustTotalError + diff
	newRatedCount := reseller.TrustRatedCount + 1

	// Step 4: Calculate new trust score
	// Calculate new trust score based on average error
	// Score = 100 - (average_error * 20)
	averageError := newTotalError / float64(newRatedCount)
	newTrust := 100 - (averageError * 20)
	if newTrust < 0 {
		newTrust = 0
	} else if newTrust > 100 {
		newTrust = 100
	}
	if newTrust < 40 {
		fmt.Println("⚠️ Reseller trust score below threshold — blacklisting")
		reseller.IsBlacklisted = true
	} else {
		reseller.IsBlacklisted = false // Optional: recover if they improve
	}

	fmt.Println("📊 TRUST SCORE CALCULATION")
	fmt.Println("➡️ Previous Score:", reseller.TrustScore)
	fmt.Println("➡️ New Total Error:", newTotalError)
	fmt.Println("➡️ New Rated Count:", newRatedCount)
	fmt.Println("➡️ New Trust Score (calculated):", newTrust)

	// Step 5: Persist the changes
	reseller.TrustScore = int(newTrust)
	reseller.TrustRatedCount = newRatedCount
	reseller.TrustTotalError = newTotalError

	err = uc.userRepo.UpdateTrustData(ctx, reseller)
	if err != nil {
		fmt.Println("❌ Failed to update reseller trust data:", err)
	} else {
		fmt.Println("✅ Reseller trust data updated successfully")
	}

	return err
}
