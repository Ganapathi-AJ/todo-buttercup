# Gradient Todo

A beautiful and feature-rich Todo application built with Flutter, featuring a gradient UI, animations, light/dark theme support, and local database storage.

## Features

- ✨ Beautiful gradient UI with smooth animations
- 🌓 Light and Dark theme support
- 📝 Create, edit, and delete tasks
- 📋 Organize tasks with categories
- 📌 Pin important tasks to the top
- 🔄 Filter tasks (All, Active, Completed, Today)
- 🔍 Search functionality
- ⏰ Set due dates and priorities
- 📊 Task stats and completion tracking
- 💾 Persistent local storage using Hive

## Web Application

This application is optimized for web delivery. The production build uses CanvasKit renderer for best performance and visual consistency.

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Web browser (Chrome recommended for development)

### Installation

1. Clone this repository
```
git clone <repository-url>
```

2. Navigate to the project directory
```
cd todo_app
```

3. Install dependencies
```
flutter pub get
```

4. Generate Hive adapters
```
flutter pub run build_runner build --delete-conflicting-outputs
```

5. Run the application
```
flutter run -d chrome
```

### Building for Production

To create a production build for web deployment:

```
flutter build web --web-renderer canvaskit --release
```

The build output will be located in the `build/web` directory, which can be deployed to any web hosting service.

## Architecture and Design

The application follows a clean architecture approach:

- **Models**: Data classes for Todo and Category items
- **Providers**: State management using Provider package
- **Services**: Database service for Hive operations
- **Screens**: UI screens for different app features
- **Widgets**: Reusable UI components
- **Constants**: App-wide constants and configurations
- **Themes**: Light and dark theme definitions
- **Utils**: Utility functions and helpers

## License

This project is licensed under the MIT License.

## Acknowledgements

- [Flutter](https://flutter.dev) - Beautiful native apps in record time
- [Provider](https://pub.dev/packages/provider) - State management
- [Hive](https://pub.dev/packages/hive) - Lightweight and fast key-value database
- [Flutter Slidable](https://pub.dev/packages/flutter_slidable) - Slidable list items
- [Animate Do](https://pub.dev/packages/animate_do) - Beautiful animations 