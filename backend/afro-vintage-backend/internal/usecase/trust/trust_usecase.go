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
	fmt.Println("\n🔥 TRUST UPDATE DEBUG START")
	fmt.Println("➡️ Supplier ID:", supplierID)
	fmt.Println("➡️ Declared Rating:", declaredRating)
	fmt.Println("➡️ Product Rating:", productRating)

	supplier, err := uc.userRepo.GetByID(ctx, supplierID)
	if err != nil {
		fmt.Println("❌ Failed to fetch supplier:", err)
		return err
	}

	fmt.Println("\n📊 CURRENT USER DATA")
	fmt.Println("User ID:", supplier.ID)
	fmt.Println("Role:", supplier.Role)
	fmt.Println("Current Trust Score:", supplier.TrustScore)
	fmt.Println("Current Total Error:", supplier.TrustTotalError)
	fmt.Println("Current Rated Count:", supplier.TrustRatedCount)
	fmt.Println("Is Blacklisted:", supplier.IsBlacklisted)

	// Initialize trust data if it's the first rating
	if supplier.TrustRatedCount == 0 {
		fmt.Println("\n🔄 Initializing trust data for new supplier")
		supplier.TrustTotalError = 0
		supplier.TrustRatedCount = 0
		supplier.TrustScore = 100
	}

	// Step 2: Calculate absolute difference
	diff := math.Abs(productRating - declaredRating)
	fmt.Println("\n📊 RATING DIFFERENCE")
	fmt.Println("Difference:", diff)

	// Step 3: Update cumulative error and count
	newTotalError := supplier.TrustTotalError + diff
	newRatedCount := supplier.TrustRatedCount + 1

	fmt.Println("\n📊 UPDATED METRICS")
	fmt.Println("New Total Error:", newTotalError)
	fmt.Println("New Rated Count:", newRatedCount)

	// Step 4: Calculate new trust score
	avgError := newTotalError / float64(newRatedCount)
	newTrust := 100 - (avgError * 2) // ❗ Soft penalty: each point of avg error costs 2 trust

	// Clamp between 0 and 100
	if newTrust < 0 {
		newTrust = 0
	} else if newTrust > 100 {
		newTrust = 100
	}

	fmt.Println("\n📊 TRUST SCORE CALCULATION")
	fmt.Println("Final Trust Score:", newTrust)

	if newTrust < 40 {
		fmt.Println("⚠️ Supplier trust score below threshold — blacklisting")
		supplier.IsBlacklisted = true
	} else {
		supplier.IsBlacklisted = false
	}

	// Step 5: Persist the changes
	supplier.TrustScore = int(newTrust)
	supplier.TrustRatedCount = newRatedCount
	supplier.TrustTotalError = newTotalError

	fmt.Println("\n💾 SAVING UPDATED DATA")
	fmt.Println("New Trust Score:", supplier.TrustScore)
	fmt.Println("New Total Error:", supplier.TrustTotalError)
	fmt.Println("New Rated Count:", supplier.TrustRatedCount)

	err = uc.userRepo.UpdateTrustData(ctx, supplier)
	if err != nil {
		fmt.Println("❌ Failed to update supplier trust data:", err)
	} else {
		fmt.Println("✅ Supplier trust data updated successfully")
	}
	fmt.Println("🔥 TRUST UPDATE DEBUG END")

	return err
}

func (uc *trustUsecase) UpdateResellerTrustScoreOnNewRating(
	ctx context.Context,
	resellerID string,
	declaredRating float64,
	productRating float64,
) error {
	fmt.Println("\n🔥 RESELLER TRUST UPDATE CALLED")
	fmt.Println("➡️ Reseller ID:", resellerID)
	fmt.Println("➡️ Declared Rating:", declaredRating)
	fmt.Println("➡️ Product Rating:", productRating)

	reseller, err := uc.userRepo.GetByID(ctx, resellerID)
	if err != nil {
		fmt.Println("❌ Failed to fetch reseller:", err)
		return err
	}

	fmt.Println("✅ Reseller Found:", reseller.ID)

	if reseller.TrustRatedCount == 0 {
		fmt.Println("🔄 Resetting trust data for new reseller")
		reseller.TrustTotalError = 0
		reseller.TrustRatedCount = 0
		reseller.TrustScore = 100
	}

	diff := math.Abs(productRating - declaredRating)
	fmt.Println("📊 Rating Difference:", diff)

	newTotalError := reseller.TrustTotalError + diff
	newRatedCount := reseller.TrustRatedCount + 1

	// Calculate new trust score
	avgError := newTotalError / float64(newRatedCount)
	newTrust := 100 - (avgError * 2)

	if newTrust < 0 {
		newTrust = 0
	} else if newTrust > 100 {
		newTrust = 100
	}

	fmt.Println("\n📊 TRUST SCORE CALCULATION")
	fmt.Println("➡️ New Trust Score:", newTrust)

	if newTrust < 40 {
		fmt.Println("⚠️ Reseller trust score below threshold — blacklisting")
		reseller.IsBlacklisted = true
	} else {
		reseller.IsBlacklisted = false
	}

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
