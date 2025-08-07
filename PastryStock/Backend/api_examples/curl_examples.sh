#!/bin/bash

# PastryStock API - CURL Examples
# Base URL for local development
BASE_URL="http://localhost:5000/api"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== PastryStock API CURL Examples ===${NC}"
echo ""

# Function to print section headers
print_section() {
    echo -e "${YELLOW}$1${NC}"
    echo "----------------------------------------"
}

# Function to execute curl with pretty output
execute_curl() {
    echo -e "${GREEN}Request:${NC} $1"
    echo ""
    eval $1
    echo ""
    echo "----------------------------------------"
    echo ""
}

# 1. AUTHENTICATION ENDPOINTS
print_section "1. AUTHENTICATION ENDPOINTS"

# Login
execute_curl 'curl -X POST \
  '"$BASE_URL"'/auth/login \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "email": "demo@pastrystock.com",
    "password": "password123"
  }'"'"' \
  | jq .'

# Signup
execute_curl 'curl -X POST \
  '"$BASE_URL"'/auth/signup \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "name": "New User",
    "email": "newuser@example.com",
    "password": "newpassword123",
    "role": "user"
  }'"'"' \
  | jq .'

# Reset Password
execute_curl 'curl -X POST \
  '"$BASE_URL"'/auth/reset-password \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "email": "demo@pastrystock.com"
  }'"'"' \
  | jq .'

# 2. USER MANAGEMENT
print_section "2. USER MANAGEMENT"

# Get User Profile (requires authentication)
# Note: Replace JWT_TOKEN with actual token from login response
JWT_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.example.token"

execute_curl 'curl -X GET \
  '"$BASE_URL"'/users/profile \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Update User Profile
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/users/profile \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "name": "Updated Name",
    "email": "updated@example.com"
  }'"'"' \
  | jq .'

# 3. SALES ENDPOINTS
print_section "3. SALES ENDPOINTS"

# Get Recent Sales
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales/recent \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Today Sales
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales/today \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Add New Sale
execute_curl 'curl -X POST \
  '"$BASE_URL"'/sales \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "menuName": "Muffin",
    "quantity": 5,
    "pricePerItem": 20000,
    "metadata": {
      "paymentMethod": "cash",
      "customerName": "Walk-in Customer",
      "notes": "Regular order"
    }
  }'"'"' \
  | jq .'

# Get Sales by Date Range
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales?startDate=2025-01-01&endDate=2025-01-08 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Sales Analytics
execute_curl 'curl -X GET \
  '"$BASE_URL"'/sales/analytics?period=weekly \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# 4. INVENTORY ENDPOINTS
print_section "4. INVENTORY ENDPOINTS"

# Get All Ingredients
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ingredients \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Low Stock Ingredients
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ingredients/low-stock \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Specific Ingredient
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ingredients/ing001_keju \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Update Ingredient Stock
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/ingredients/ing001_keju/stock \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "currentStock": 200,
    "operation": "add",
    "notes": "New stock delivery"
  }'"'"' \
  | jq .'

# Add New Ingredient
execute_curl 'curl -X POST \
  '"$BASE_URL"'/ingredients \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "ingredientName": "Vanilla Extract",
    "currentStock": 500,
    "unit": "ml",
    "minThreshold": 100,
    "dailyConsumption": 25,
    "supplier": {
      "name": "Vanilla Supplier",
      "contact": "+62812345678",
      "email": "supplier@vanilla.com"
    }
  }'"'"' \
  | jq .'

# Update Ingredient Details
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/ingredients/ing001_keju \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "minThreshold": 150,
    "supplier": {
      "name": "New Cheese Supplier",
      "contact": "+62823456789",
      "email": "newcheese@supplier.com"
    }
  }'"'"' \
  | jq .'

# 5. PREDICTION ENDPOINTS
print_section "5. PREDICTION ENDPOINTS"

# Get All Predictions
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get ARIMA Prediction for Specific Ingredient
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions/ing001_keju/arima \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Prediction History
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions/ing001_keju/history \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Generate New Prediction
execute_curl 'curl -X POST \
  '"$BASE_URL"'/predictions/generate \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "ingredientId": "ing001_keju",
    "predictionDays": 7,
    "modelType": "arima"
  }'"'"' \
  | jq .'

# Get Prediction Accuracy
execute_curl 'curl -X GET \
  '"$BASE_URL"'/predictions/accuracy?ingredientId=ing001_keju&days=30 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# 6. MENU ITEMS ENDPOINTS
print_section "6. MENU ITEMS ENDPOINTS"

# Get All Menu Items
execute_curl 'curl -X GET \
  '"$BASE_URL"'/menu-items \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Specific Menu Item
execute_curl 'curl -X GET \
  '"$BASE_URL"'/menu-items/menu001 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Add New Menu Item
execute_curl 'curl -X POST \
  '"$BASE_URL"'/menu-items \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "name": "Chocolate Eclair",
    "price": 28000,
    "category": "pastry",
    "description": "French pastry filled with cream and topped with chocolate",
    "ingredients": ["ing001_keju", "ing002_susu", "ing005_cokelat"],
    "recipe": {
      "ing001_keju": 8.0,
      "ing002_susu": 25.0,
      "ing005_cokelat": 5.0
    },
    "preparationTime": 40,
    "difficulty": "medium",
    "allergens": ["dairy", "gluten", "eggs"]
  }'"'"' \
  | jq .'

# Update Menu Item
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/menu-items/menu001 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "price": 22000,
    "description": "Updated delicious chocolate muffin with premium ingredients"
  }'"'"' \
  | jq .'

# 7. ANALYTICS ENDPOINTS
print_section "7. ANALYTICS ENDPOINTS"

# Get Dashboard Analytics
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/dashboard \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Sales Trends
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/sales-trends?period=monthly \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Inventory Turnover
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/inventory-turnover \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Get Popular Items
execute_curl 'curl -X GET \
  '"$BASE_URL"'/analytics/popular-items?limit=5 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# 8. CONSUMPTION HISTORY ENDPOINTS
print_section "8. CONSUMPTION HISTORY ENDPOINTS"

# Get Consumption History for Ingredient
execute_curl 'curl -X GET \
  '"$BASE_URL"'/consumption-history/ing001_keju?days=30 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Add Consumption Record
execute_curl 'curl -X POST \
  '"$BASE_URL"'/consumption-history \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "ingredientId": "ing001_keju",
    "date": "2025-01-08",
    "consumption": 45.5,
    "notes": "Manual consumption entry"
  }'"'"' \
  | jq .'

# Update Consumption Record
execute_curl 'curl -X PUT \
  '"$BASE_URL"'/consumption-history/M12352 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "consumption": 47.0,
    "notes": "Corrected consumption value"
  }'"'"' \
  | jq .'

# 9. HEALTH CHECK ENDPOINTS
print_section "9. HEALTH CHECK ENDPOINTS"

# Ping Server
execute_curl 'curl -X GET \
  '"$BASE_URL"'/ping \
  -H "Content-Type: application/json" \
  | jq .'

# Get Server Status
execute_curl 'curl -X GET \
  '"$BASE_URL"'/status \
  -H "Content-Type: application/json" \
  | jq .'

# Get API Version
execute_curl 'curl -X GET \
  '"$BASE_URL"'/version \
  -H "Content-Type: application/json" \
  | jq .'

# 10. BATCH OPERATIONS
print_section "10. BATCH OPERATIONS"

# Batch Update Stock
execute_curl 'curl -X POST \
  '"$BASE_URL"'/ingredients/batch-update-stock \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "updates": [
      {
        "ingredientId": "ing001_keju",
        "currentStock": 500,
        "operation": "set"
      },
      {
        "ingredientId": "ing002_susu",
        "currentStock": 100,
        "operation": "add"
      }
    ]
  }'"'"' \
  | jq .'

# Batch Add Sales
execute_curl 'curl -X POST \
  '"$BASE_URL"'/sales/batch \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  -d '"'"'{
    "sales": [
      {
        "menuName": "Muffin",
        "quantity": 3,
        "pricePerItem": 20000
      },
      {
        "menuName": "Croissant",
        "quantity": 2,
        "pricePerItem": 18000
      }
    ]
  }'"'"' \
  | jq .'

# 11. EXPORT/IMPORT ENDPOINTS
print_section "11. EXPORT/IMPORT ENDPOINTS"

# Export Sales Data
execute_curl 'curl -X GET \
  '"$BASE_URL"'/export/sales?format=csv&startDate=2025-01-01&endDate=2025-01-08 \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Accept: text/csv"'

# Export Inventory Data
execute_curl 'curl -X GET \
  '"$BASE_URL"'/export/inventory?format=json \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

# Import Demo Data
execute_curl 'curl -X POST \
  '"$BASE_URL"'/import/demo-data \
  -H "Authorization: Bearer '"$JWT_TOKEN"'" \
  -H "Content-Type: application/json" \
  | jq .'

echo -e "${GREEN}=== All API Examples Completed ===${NC}"
echo ""
echo -e "${BLUE}Notes:${NC}"
echo "1. Replace JWT_TOKEN with actual token from login response"
echo "2. Ensure backend server is running on localhost:5000"
echo "3. Install jq for JSON formatting: sudo apt-get install jq"
echo "4. Some endpoints require admin privileges"
echo "5. Check API documentation for complete parameter list"
echo ""
echo -e "${YELLOW}Common HTTP Status Codes:${NC}"
echo "200 - Success"
echo "201 - Created"
echo "400 - Bad Request"
echo "401 - Unauthorized"
echo "403 - Forbidden"
echo "404 - Not Found"
echo "500 - Internal Server Error"
echo ""
echo -e "${GREEN}Happy Testing! 🚀${NC}"
