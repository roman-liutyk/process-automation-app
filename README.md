# Process Automation App

A Flutter web application for managing projects and tasks with authentication features.

## Prerequisites

Before running the application, make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- [Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)
- A code editor (VS Code, IntelliJ IDEA, or Android Studio)
- Git

## Backend Information

The backend API for this application is hosted on Microsoft Azure and is maintained in a separate repository. You don't need to run the backend locally as it's already deployed and accessible. The API endpoint is configured in `lib/common/utils/app_constants.dart`.

The backend repository contains the API implementation and database configurations. If you need to modify the backend, please refer to the separate backend repository.

## Setup Instructions

1. Clone the repository:

```bash
git clone [repository-url]
cd process-automation-app
```

2. Install dependencies:

```bash
flutter pub get
dart run build_runner build
```

3. Configure Firebase:
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication with Email/Password, Google, and GitHub providers
   - Add a web app to your Firebase project
   - Copy the Firebase configuration from the Firebase Console
   - Update the `firebase_options.dart` file with your configuration

## Running the Application

### Using VS Code

1. Create or modify the `launch.json` file in the `.vscode` directory:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Process Automation App",
      "request": "launch",
      "type": "dart",
      "args": [
        "-d",
        "chrome",
        "--web-port",
        "5000", // Specify your desired port here
        "--web-browser-flag",
        "--disable-web-security"
      ]
    }
  ]
}
```

2. Press F5 or click the Run button in VS Code

### Using Command Line

Run the application with a specific port:

```bash
flutter run -d chrome --web-port 5000 --web-browser-flag --disable-web-security # Replace 5000 with your desired port
```

Or use the default port:

```bash
flutter run -d chrome
```

## Important Notes

- The application requires an active internet connection for Firebase authentication and API access
- Make sure no other application is using the specified port
- The backend API URL is configured in `lib/common/utils/app_constants.dart`
- For development purposes, it's recommended to use Chrome as the target browser

## Features

- User authentication (Email/Password, Google, GitHub)
- Project management
- Task board with drag-and-drop functionality
- User profile management
- Team collaboration tools

## Troubleshooting

If you encounter port-related issues:

1. Check if the port is already in use
2. Try a different port number
3. Kill any processes using the desired port:

   ```bash
   # On Windows
   netstat -ano | findstr :[PORT]
   taskkill /PID [PID] /F

   # On MacOS/Linux
   lsof -i :[PORT]
   kill -9 [PID]
   ```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
