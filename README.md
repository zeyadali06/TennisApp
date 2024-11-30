# Tennis Player Training Prediction App 🎾☀️

A Flutter-based tennis app that displays weather conditions, allowing users to add and manage multiple locations. The app includes an authentication feature and is built with a clean architecture for better code, maintainability and scalability.

## Table of contents 📑

- ### [Main Packages Used =>](#main-packages-used)
- ### [Architecture =>](#architecture)
- ### [Folder Structure =>](#folder-structure)
- ### [Screen Shots =>](#screen-shots)
- ### [Video Link =>](#video-link)
- ### [Apk Link =>](#apk-link)

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

## Architecture ⚙

This app follows **Clean Architecture**, ensuring a separation of concerns and making the codebase more modular and testable.

## Folder Structure 📂

Here is the folder structure we have been using in this project:

```
lib
├── Core
├── Features
├── CustomNavigationBar.dart
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
├── Utils
├── Widgets
└── .env
```

### Features

This folder containes everything related to the screen of the application and the business logic of the application specificly state management.

```
Features
├── AuthFeature**: Secure user registration and login using Firebase.
├── HomeFeature: Displays current weather conditions for the selected location, including temperature, wind speed, and weather description.
├── LocationFeature: Enables users to add new locations to monitor weather conditions.
└── SplashFeature: Simple splash screen
```

## Screen Shots 📸

![](/ScreenShots/Screenshot_1732995507.png)
![](/ScreenShots/Screenshot_1732995522.png)
![](/ScreenShots/Screenshot_1732995538.png)
![](/ScreenShots/Screenshot_1732995556.png)
![](/ScreenShots/Screenshot_1732995561.png)
![](/ScreenShots/Screenshot_1732996123.png)
![](/ScreenShots/Screenshot_1732996163.png)
![](/ScreenShots/Screenshot_1732996172.png)
![](/ScreenShots/Screenshot_1732996176.png)
![](/ScreenShots/Screenshot_1732996183.png)
![](/ScreenShots/Screenshot_1732996254.png)

# [Video Link](https://drive.google.com/file/d/1x6cjlIgZXG7CABhK7s3l8UVLTrnbKH-g/view?usp=sharing)

# [Apk Link](https://drive.google.com/file/d/15FCHU3Yde7MDqUIL2rgiKEf6e7xnpSOS/view?usp=sharing)
