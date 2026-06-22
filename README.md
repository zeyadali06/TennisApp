# Tennis Player Training Prediction App 🎾☀️

A Flutter-based tennis app that displays weather conditions, allowing users to add and manage multiple locations. The app includes an authentication feature and is built with a clean architecture for better code, maintainability and scalability.

## Table of contents 📑

- ### [Main Packages Used](#main-packages-used)
- ### [How to Run](#how-to-run)
- ### [Architecture](#architecture)
- ### [Folder Structure](#folder-structure)
- ### [Screen Shots](#screen-shots)
- ### [Video Link](#video-link)
- ### [Apk Link](#apk-link)

## Main Packages Used 🛠

- [dio](https://pub.dev/packages/dio) -> to integrate with APIs
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) -> as state management
- [lottie](https://pub.dev/packages/lottie) -> to add animations
- [firebase_core](https://pub.dev/packages/firebase_core) -> the main package of firebase
- [firebase_auth](https://pub.dev/packages/firebase_auth) -> to use firebase authentication
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) -> to use cloud firestore
- [modal_progress_hud_nsn](https://pub.dev/packages/modal_progress_hud_nsn) -> to create professional loading
- [get_it](https://pub.dev/packages/get_it) -> to implement dependency inversion design pattern for single creation to each object
- [geolocator](https://pub.dev/packages/geolocator) -> to get coordinates of the location
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) -> to save sensitive values
- [geocoding](https://pub.dev/packages/geocoding) -> to get the place of the coordinates of the location
- [table_calendar](https://pub.dev/packages/table_calendar) -> to create professional calendar
- [fl_chart](https://pub.dev/packages/fl_chart) -> to create charts
- [cached_network_image](https://pub.dev/packages/cached_network_image) -> to show the image and store it
- [connectivity_plus](https://pub.dev/packages/connectivity_plus) -> to check the internet connection
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) -> to load environment variables from a .env file and keep sensitive configuration separate from the source code.
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) -> to securely store sensitive data such as authentication tokens and user credentials using the device's secure storage.
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter) -> to display interactive Google Maps, show locations, and allow users to select places on a map.

## How to Run ▶️

### Flutter Application

### 1. Clone the Repository

```bash
git clone https://github.com/zeyadali06/TennisApp.git
cd TennisApp
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Environment Variables

Create a `.env` file in the project root and add the required environment variables:

```env
API_KEY=put_your_weather_api_key
```

### 4. Run the Application

```bash
flutter run
```

---

## AI Prediction API (Python)

### 1. Navigate to the Project Directory

```bash
cd TennisApp
```

### 2. Create a Virtual Environment

```bash
python -m venv venv
```

### 3. Activate the Environment

```bash
venv\Scripts\activate
```

### 4. Install Required Packages

```bash
venv\Scripts\pip.exe install flask numpy scikit-learn
```

### 5. Run the API

```bash
venv\Scripts\python.exe app.py
```

You should see output similar to:

- Running on http://127.0.0.1:5001

### 6. Verify the API

Open:

http://127.0.0.1:5001

Expected response:

Welcome to the ML Prediction API!

### Notes

1. Ensure random_forest_model.pkl is located in the same directory as app.py.
2. The Flutter application expects the API to be running on port 5001.
3. Always use the Python executable inside the venv folder to avoid dependency version conflicts.

# Architecture ⚙

This app follows **Clean Architecture**, ensuring a separation of concerns and making the codebase more modular and testable.

## Folder Structure 📂

Here is the folder structure we have been using in this project:

```
lib
├── Core
├── Features
├── firebase_options.dart
└── main.dart
```

### Core

This folder contains all services and tools related to the application

```
Core
├── Failures
├── Formatters
├── Functions
├── Models
├── Utils
├── Widgets
└── .env
```

### Features

This folder containes everything related to the screen of the application and the business logic of the application specificly state management.

```
Features
├── AuthFeature: Secure user registration and login using Firebase.
├── HomeFeature: Displays current weather conditions for the selected location, including temperature, wind speed, and weather description.
├── LocationFeature: Enables users to add new locations to monitor weather conditions.
├── NavigationBar: Handles screen switching and maintains navigation state across the application's main views.
└── SplashFeature: Simple splash screen.
```

## Screen Shots 📸

<img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/1.png" width="300"> <img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/2.png" width="300">

<img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/3.png" width="300"><img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/4.png" width="300">

<img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/5.png" width="300"> <img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/6.png" width="300">

<img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/7.png" width="300"><img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/8.png" width="300">

<img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/9.png" width="300"><img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/10.png" width="300">

<img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/11.png" width="300"><img src="https://github.com/zeyadali06/TennisApp/blob/main/ScreenShots/12.png" width="300">

# [Video Link](https://drive.google.com/file/d/1x6cjlIgZXG7CABhK7s3l8UVLTrnbKH-g/view?usp=sharing)

# [Apk Link](https://drive.google.com/file/d/15FCHU3Yde7MDqUIL2rgiKEf6e7xnpSOS/view?usp=sharing)
