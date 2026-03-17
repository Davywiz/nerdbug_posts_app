# Nerdbug Posts App

A Flutter assessment project for Nerdbug that fetches posts from `jsonplaceholder.typicode.com`, displays them in a responsive list, shows post details, and lets users mark posts as favorites.

## Project Overview

This app was built to keep the implementation simple, readable, and interview-friendly. It focuses on the core assessment requirements:

- fetch posts from a remote API
- display loading, error, empty, and success states
- show post details
- allow users to favorite and unfavorite posts
- use Riverpod for clean state management

## Features Implemented

- Posts list screen
- Pull-to-refresh on the posts list
- Post details screen
- Favorite toggling from the list and details screen
- Responsive, clean Material 3 UI
- Widget tests for key screen and favorite interactions

## Architecture Summary

The project uses a small feature-based structure under `lib/features/posts`:

- `data/models`
  Contains the `Post` model.
- `data/services`
  Contains the Dio-powered API service for fetching posts.
- `data/providers`
  Contains Riverpod providers for network access, posts loading, and favorite state.
- `presentation/screens`
  Contains the posts list screen and post details screen.
- `presentation/widgets`
  Contains reusable UI pieces such as the post list item and shared state view.

This keeps responsibilities clear without adding unnecessary abstraction.

## Libraries Used

- `flutter_riverpod`
  State management for async posts loading and favorite state.
- `dio`
  HTTP client used to fetch posts from the API.

## Setup Instructions

1. Ensure Flutter is installed and available on your machine.
2. Clone the repository.
3. Install dependencies:

```bash
fvm flutter pub get
```

If you are not using `fvm`, use:

```bash
flutter pub get
```

## How To Run

Run the app with:

```bash
fvm flutter run
```

Or without `fvm`:

```bash
flutter run
```

Useful verification commands:

```bash
fvm flutter analyze
fvm flutter test
```
