# Firebase Flavor + SNS Authentication

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
--dart-define=GOOGLE_APP_ID=<GOOGLE_APP_ID> \
--dart-define=FACEBOOK_APP_ID=<FACEBOOK_APP_ID> \
--dart-define=FACEBOOK_CLIENT_TOKEN=<FACEBOOK_CLIENT_TOKEN> \
--dart-define=TWITTER_API_KEY=<TWITTER_API_KEY> \
--dart-define=TWITTER_API_SECRET=<TWITTER_API_SECRET> \
--dart-define=TWITTER_HOST=<TWITTER_HOST> \
--dart-define=TWITTER_SCHEME=<TWITTER_SCHEME>
```

Visual Studio Code Configuration defined in `.vscode/launch.json`。

### How to get GOOGLE_APP_ID?
   1. Open file **GoogleService-Info.plist**
   2. Get the string value of _REVERSED_CLIENT_ID key_.
![Screen Shot 2022-05-31 at 20 09 17](https://user-images.githubusercontent.com/40752908/171181174-42568ad1-f406-4b59-a523-7e5b3dac42a4.png) 


### How to get FACEBOOK_APP_ID & FACEBOOK_CLIENT_TOKEN?
1. Create Facebook developer account
2. Create your app info, follow these steps via this tutorial: https://facebook.meedu.app/docs/4.x.x/android_
3. Retrieve **FACEBOOK_APP_ID & FACEBOOK_CLIENT_TOKEN** to setup into Firebase like the image below
![144253037-f1750fbd-62ac-42fb-88a6-2f7ed8113f3e](https://user-images.githubusercontent.com/40752908/170867916-d6bf66e6-844a-40fb-b1e1-e0f9fb348179.png)

### How to get TWITTER_API_KEY & TWITTER_API_SECRET?
1. Create twitter developer account?
2. Create a new app
3. Retrieve **TWITTER_API_KEY & TWITTER_API_SECRET**

- Example:
![image](https://user-images.githubusercontent.com/40752908/171184863-a6067abd-7058-4082-850a-0ad52373be31.png)

### How to get TWITTER_HOST?
1. Open Firebase Authentication console
2. Enable Twitter Provider
3. Get **xxxx.firebaseapp.com** from the _Callback Url_

- Example:
![Screen Shot 2022-05-29 at 19 29 38](https://user-images.githubusercontent.com/40752908/170868463-4f18c14c-943c-40e0-b7ad-bdcdcb79d0cf.png)


### How to get TWITTER_SCHEME?
![image](https://user-images.githubusercontent.com/40752908/170868795-7a882704-3089-498b-ab93-6ec438489487.png)
```sh
TWITTER_SCHEME=app_name
```

### Important notes for TWITTER
- Remember to add these line into twitter portal

1. **[firebase-project-id]://**
2. **https://[firebase-project-id].firebaseapp.com/__auth/handler**

Reference: https://pub.dev/packages/twitter_login#twitter-configuration

### Sign in with apple configuration
- Reference: https://pub.dev/packages/sign_in_with_apple

