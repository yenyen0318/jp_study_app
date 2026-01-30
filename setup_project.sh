#!/bin/bash

# Initialize Flutter Project
echo "Initializing Flutter project..."
flutter create . --platforms android,ios

# Initialize Git
echo "Initializing Git..."
git init

# Firebase Init (User to execute manually)
echo "Project setup complete."
echo "Please run the following command manually to set up Firebase:"
echo "firebase init"
