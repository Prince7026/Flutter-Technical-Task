# Flutter Technical Task

A Flutter application built as part of a technical assessment.  
The app demonstrates authentication, tournament participation, wallet handling, and a leaderboard with pagination.

---

## Features

### Authentication
- Username & password login (DummyJSON Auth API)
- Local token storage
- Auto-login using saved token
- Logout clears session

### Tournament Listing
- Multiple tournaments with entry fee, prize pool, and slots
- Join tournament functionality
- Prevents joining when:
    - Wallet balance is insufficient
    - Tournament is full
    - User has already joined

### Wallet
- Initial wallet balance: ₹500
- Entry fee deducted on successful join

### Leaderboard
- Rank, player name, and points
- Lazy loading (pagination)
- Minimum 20 players
- Shimmer loading UI

### Splash Screen
- Validates saved token on app start
- Fetches user profile using `/auth/me`
- Redirects to Login or Tournament screen

---

## Architecture & State Management

- MVVM-style architecture
- Provider (`ChangeNotifier`) for state management
- Business logic handled in ViewModels
- UI layer responsible for rendering and navigation

This structure keeps the code clean, readable, and easy to maintain.

---

## API Note

DummyJSON authentication supports **username-based login only**.  
The app uses username instead of email and documents this limitation clearly.

---

## Tech Stack

- Flutter
- Provider
- HTTP
- Shared Preferences
- Shimmer

---

## Test Credentials

Username: emilys
Email: emily.johnson@x.dummyjson.com
Password: emilyspass

---

## How to Run

1. `flutter pub get`
2. `flutter run`