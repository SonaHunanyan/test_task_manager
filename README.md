### Task Management Application
A Task Management Application built using Flutter, designed to streamline task creation, management, and tracking. This app supports dynamic routing, efficient networking, and structured data handling, making it robust and scalable.

### Features
- Task Management: Create, update, and track tasks efficiently.
- Dynamic Navigation: Powered by auto_route for type-safe and declarative routing.
- Networking: Uses dio for seamless API integration.
- Data Handling: json_serializable ensures easy JSON serialization and deserialization.
- Localization: Multi-language support with easy_localization.
- Responsive Design: Adapts to different screen sizes using flutter_screenutil.

### 🎥 Application Preview
🚀 **[Watch the App Preview on YouTube](https://youtube.com/shorts/oMB_dSamD4g)** 🎥


### Getting Started

Follow these steps to set up and run the project locally:

## Project Setup

### Prerequisites

Ensure you have the following installed on your system:

- Flutter SDK: [Installation Guide](https://docs.flutter.dev/get-started/install)
- Dart SDK (comes with Flutter)
- Make (optional, for using `make` commands)

### Prepare the Project

To set up and prepare the project for development, run the following command:

```bash
make prepare
```

This command will:

1. Clean the project using `flutter clean`.
2. Fetch all necessary dependencies using `flutter pub get`.
3. Generate necessary files for code generation using `build_runner`.

Ensure that you have [Make](https://www.gnu.org/software/make/) installed on your system before running this command. If you encounter any issues, verify that Flutter is properly installed and set up on your machine.

### Manual Setup

If you prefer not to use `make`, you can manually run the following commands:

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```
### Running the Application
1. Run the app on your preferred platform:
   ```bash
   flutter run
   ```

2. To run on a specific platform:
   - For Android:
     ```bash
     flutter run -d android
     ```
   - For iOS:
     ```bash
     flutter run -d ios
     ```

### Localization
This app supports multiple languages. To change the locale, navigate to the settings within the app and select your desired language.

