# 💬 Rechap - Real-time Chat Application

<p align="center">
  <img src="screenshots/banner.png" alt="Rechap Banner" width="100%"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Riverpod-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Riverpod"/>
</p>

## 📱 Overview

**Rechap** is a simple real-time chat application built with Flutter and Firebase. The app features phone number authentication, real-time messaging with Firestore, and contact integration.

<p align="center">
  <img src="screenshots/mockup_all.png" alt="App Mockup" width="100%"/>
</p>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **Phone Authentication** | Secure login using Firebase phone auth with OTP verification |
| 💬 **Real-time Messaging** | Instant message delivery using Firestore streams |
| 👥 **Contact Integration** | Access device contacts to start new conversations |
| 🔔 **Unread Count Badge** | Visual indicator for unread messages |
| 🗑️ **Swipe to Delete** | Intuitive chat deletion with confirmation dialog |

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a feature-first folder structure:

```
lib/
├── core/                      # Shared utilities & themes
│   ├── common/               # Result wrapper, extensions
│   ├── routing/              # GoRouter configuration
│   ├── themes/               # Colors, typography, dimensions
│   └── ui/                   # Shared widgets
│
├── di/                        # Dependency Injection (Riverpod providers)
│
└── features/
    ├── login/                 # Authentication feature
    │   ├── data/             # Repository implementations
    │   ├── domain/           # Entities, repositories, use cases
    │   └── presentation/     # Screens, view models, widgets
    │
    ├── chat/                  # Chat messaging feature
    ├── chat-list/            # Chat list feature
    ├── contacts/             # Device contacts feature
    ├── profile/              # User profile feature
    └── onboard/              # Onboarding feature
```

### Layer Responsibilities

| Layer | Description |
|-------|-------------|
| **Data** | Repository implementations, models, mappers, data sources |
| **Domain** | Business logic, entities, repository interfaces, use cases |
| **Presentation** | UI screens, view models (Riverpod Notifiers), widgets |

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.10+ |
| **State Management** | Riverpod 3.0 |
| **Navigation** | GoRouter |
| **Backend** | Firebase (Auth, Firestore) |
| **Authentication** | Firebase Phone Auth |
| **Database** | Cloud Firestore |
| **Icons** | Icons Plus |
| **Animations** | Lottie |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.10+
- Dart 3.0+
- Firebase project with Firestore and Authentication enabled
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/rechap.git
   cd rechap
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Phone Authentication
   - Enable Cloud Firestore
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📂 Firestore Data Structure

```
├── users/
│   └── {userId}/
│       ├── uid: string
│       ├── username: string
│       ├── phoneNumber: string
│       └── createdAt: timestamp
│
├── phone_index/
│   └── {docId}/
│       ├── phoneNumber: string
│       └── uid: string
│
└── conversations/
    └── {conversationId}/
        ├── participants_id: array
        ├── participant_map: map<string, bool>
        ├── participant_names: map<string, string>
        ├── unread_count: map<string, int>
        ├── last_message: string
        ├── last_message_at: timestamp
        │
        └── messages/
            └── {messageId}/
                ├── sender_id: string
                ├── text: string
                ├── type: string
                └── created_at: timestamp
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Ananda Priya Yustira**

<p>
  <a href="https://linkedin.com/in/yourprofile">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
  <a href="https://github.com/yourusername">
    <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
  <a href="mailto:your.email@example.com">
    <img src="https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email"/>
  </a>
</p>

---

<p align="center">
  Made with ❤️ and Flutter
</p>
