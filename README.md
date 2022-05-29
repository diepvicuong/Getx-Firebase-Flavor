# APP NAME

## Flutter

- Flutter version: 2.10.5
- Dart version: 2.16.2

## Build

```sh
flutter clean && flutter pub get
cd ios && pod install && cd ..
```

## [For Development][android] Config Google Sign-In

```sh
1. Add SHA-1 & SHA-256 fingerprint into Firebase Console
2. How to create SHA-1 & SHA-256 fingerprint?
   Reference: https://developers.google.com/android/guides/client-auth
```

## Run Flutter with environment variables

```sh
flutter run \
--flavor dev \
--dart-define=APP_NAME=dev-app \
--dart-define=APP_SUFFIX=.dev \
--dart-define=APP_ENV=dev \
--dart-define=FACEBOOK_APP_ID=<FACEBOOK_APP_ID> \
--dart-define=FACEBOOK_CLIENT_TOKEN=<FACEBOOK_CLIENT_TOKEN> \
--dart-define=TWITTER_HOST=<TWITTER_HOST> \
--dart-define=TWITTER_API_KEY=<TWITTER_API_KEY> \
--dart-define=TWITTER_API_SECRET=<TWITTER_API_SECRET> \
--dart-define=TWITTER_SCHEME=<TWITTER_SCHEME> \
--dart-define=GOOGLE_APP_ID=<GOOGLE_APP_ID>
```

Visual Studio Code Configuration defined in `.vscode/launch.json`。
