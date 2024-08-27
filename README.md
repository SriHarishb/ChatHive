
# ChatHive: A Whatsapp Clone

ChatHive is a WhatsApp clone built using Flutter. It features a dark theme with a user-friendly interface, . The app is designed with a custom UI, and it leverages JSON data for storing and displaying chat details.

## Screenshot

![chathive](https://github.com/user-attachments/assets/fd9343b5-1a86-4ab1-bfc1-231e4536b90b)

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK installed
- A code editor (e.g., Visual Studio Code)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/chathive.git
   ```

2. Navigate to the project directory:

   ```bash
   cd chathive
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

### Project Structure

- `main.dart`: Entry point of the application.
- `chat.dart`: Handles the chat screen.
- `newchat.dart`: Handles the new chat screen.
- `assets/`: Contains images and other assets.
- `chatdeets.json`: JSON file containing chat details.

### JSON Structure

The `chatdeets.json` file stores chat information in the following format:

```json
[
  {
    "name": "Steve",
    "pfp": "assets/steve_avatar.png",
    "rec": "Good morning! 😊❤️"
  },
  {
    "name": "Ash",
    "pfp": "assets/ash_avatar.png",
    "rec": "hello world!"
  }
]
```

### Customization

You can customize the colors, fonts, and other UI elements in the `main.dart` file.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
