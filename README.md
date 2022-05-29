# APP NAME

## Flutter

- Flutter version: 2.10.5
- Dart version: 2.16.2

## Build

```sh
flutter clean && flutter pub get
cd ios && pod install && cd ..
```

## [For Development][Android] Config Google Sign-In

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


### FACEBOOK_APP_ID & FACEBOOK_CLIENT_TOKEN
- Reference: https://facebook.meedu.app/docs/4.x.x/android
![144253037-f1750fbd-62ac-42fb-88a6-2f7ed8113f3e](https://user-images.githubusercontent.com/40752908/170867916-d6bf66e6-844a-40fb-b1e1-e0f9fb348179.png)


## TWITTER
- Reference: https://pub.dev/packages/twitter_login
### TWITTER_HOST
![Screen Shot 2022-05-29 at 19 29 38](https://user-images.githubusercontent.com/40752908/170868463-4f18c14c-943c-40e0-b7ad-bdcdcb79d0cf.png)


### TWITTER_SCHEME
![image](https://user-images.githubusercontent.com/40752908/170868795-7a882704-3089-498b-ab93-6ec438489487.png)
```sh
TWITTER_SCHEME=app_name
```


### TWITTER_API_KEY & TWITTER_API_SECRET
![image](https://user-images.githubusercontent.com/40752908/170869063-edfdc75f-1ac5-4ad8-afdc-bb9c28b29192.png)


### GOOGLE_APP_ID
```sh
REVERSED_CLIENT_ID value in GoogleService-Info.plist
```

![Screen Shot 2022-05-29 at 19 46 09](https://user-images.githubusercontent.com/40752908/170869281-0bc1ee66-cfe3-433c-81c1-529beb277457.png)




