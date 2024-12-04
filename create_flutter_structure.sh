#!/bin/bash

# Base directory
BASE_DIR="lib/src"

# Create directories
mkdir -p $BASE_DIR/app/home
mkdir -p $BASE_DIR/app/authentication
mkdir -p $BASE_DIR/app/ride_request
mkdir -p $BASE_DIR/app/driver_portal
mkdir -p $BASE_DIR/app/customer_dashboard
mkdir -p $BASE_DIR/app/models
mkdir -p $BASE_DIR/app/widgets

# Create files
touch $BASE_DIR/main.dart
touch $BASE_DIR/routes.dart
touch $BASE_DIR/app/home/home_page.dart
touch $BASE_DIR/app/home/home_view_model.dart
touch $BASE_DIR/app/authentication/auth_repository.dart
touch $BASE_DIR/app/authentication/auth_service.dart
touch $BASE_DIR/app/authentication/sign_in_page.dart
touch $BASE_DIR/app/authentication/sign_up_page.dart
touch $BASE_DIR/app/ride_request/ride_request_service.dart
touch $BASE_DIR/app/ride_request/ride_request_repository.dart
touch $BASE_DIR/app/ride_request/ride_request_page.dart
touch $BASE_DIR/app/driver_portal/driver_portal_page.dart
touch $BASE_DIR/app/customer_dashboard/customer_dashboard_page.dart
touch $BASE_DIR/app/models/user.dart
touch $BASE_DIR/app/models/ride.dart
touch $BASE_DIR/app/widgets/custom_map.dart

echo "Flutter project structure created successfully!"
