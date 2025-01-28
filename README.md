
# eNROLL


Our in-house developed eNROLL platform serves as a technological compliance solution. A solution that is now familiarized across the globe in countries with big populations where falsification of identity, signatures and phishing is very common.

The software utilizes a set of AI powered technologies, like the OCR (Optical Character Recognition), to cut back on the risks of human-based errors and time needed for identification


![App Screenshot](https://firebasestorage.googleapis.com/v0/b/excel-hr-app.appspot.com/o/Screenshot%202024-09-02%20at%2011.03.04%E2%80%AFAM.png?alt=media&token=37acf293-9e0e-456c-8b7a-3b97c512d911)

![App Screenshot](https://firebasestorage.googleapis.com/v0/b/excel-hr-app.appspot.com/o/Screenshot%202024-09-02%20at%2011.03.28%E2%80%AFAM.png?alt=media&token=1d5aafeb-ffe3-4faa-aa72-37b28f1810a9)

![App Screenshot](https://firebasestorage.googleapis.com/v0/b/excel-hr-app.appspot.com/o/Screenshot%202024-09-02%20at%2011.03.39%E2%80%AFAM.png?alt=media&token=76489515-b21b-403f-a338-0f9889486b4b)



## REQUIREMENTS

- Minimum Flutter version 3.3.4
- Android minSdkVersion 24
- Kotlin Version 1.9.0


## 2. INSTALLATION

1-  Run this command with Flutter:


```bash
 $ flutter pub add enroll_plugin
```

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```bash
 dependencies:
   enroll_plugin: ^latest_version
```

- You can find the latest version here https://pub.dev/packages/enroll_plugin/versions



### 2.1. Android

- Add these lines in Build.gradle file:

```bash
maven { url 'https://jitpack.io' }
maven { url = uri("https://maven.innovatrics.com/releases") }
```

- Upgrade minSdkVersion to 24 in app/build.gradle.
- Add the following lines to settings.gradle file:


```bash
buildscript {
    repositories {
        mavenCentral()
        maven {
            url = uri("https://storage.googleapis.com/r8-releases/raw")
        }
    }
    dependencies {
        classpath("com.android.tools:r8:8.2.24")
    }
}
```

### 2.2. iOS

- add the following to your project info.plist file

```bash
	<key>NSCameraUsageDescription</key>
	<string>"Your Message to the users"</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>"Your Message to the users"</string>
	<key>NSAppTransportSecurity</key>
      <dict>
          <key>NSAllowsArbitraryLoads</key>
          <true/>
      </dict>
```

- Add these two sources to the iOS project Podfile

```bash
source 'https://github.com/innovatrics/innovatrics-podspecs'
source 'https://github.com/CocoaPods/Specs.git'
```






### 2.3. Add a license file to your project:

- For Android

![App Screenshot](https://firebasestorage.googleapis.com/v0/b/excel-hr-app.appspot.com/o/lic_android.png?alt=media&token=9a6556c1-cea1-4fce-b073-0dba76bedf8f)


- For iOS

![App Screenshot](https://firebasestorage.googleapis.com/v0/b/excel-hr-app.appspot.com/o/lic_ios.webp?alt=media&token=c4bcf3d8-d9d2-4c99-9a62-97349ff30fac)



ℹ️ Make sure your iOS project has a reference for the license file or instead:
- open ios project
- drag and drop the license file to the root folder of the project as described above
- make sure copy items if needed check box is checked
- then done

### 2.4. Run Command line:

```bash
flutter pub get
```


## 3. IMPORT

```bash
import 'package:enroll_plugin/enroll_plugin.dart';
```

## 4. USAGE

- Create a widget and just return EnrollPlugin widget in the build function as:


```bash
 return EnrollPlugin(
        mainScreenContext: context,
        tenantId: 'TENANT_ID',
        tenantSecret: 'TENANT_SECRET',
        enrollMode: EnrollMode.auth,
        enrollEnvironment: EnrollEnvironment.staging,
        localizationCode: EnrollLocalizations.en,
        onSuccess: (applicantId) {
          // Delay the state change until after the build completes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            debugPrint("success: $applicantId");
          });
        },
        onError: (error) {
          // Delay the state change until after the build completes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            debugPrint("Error: ${error.toString()}");
          });
        },
        onGettingRequestId: (requestId) {
          // Delay the state change until after the build completes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            debugPrint("requestId:: $requestId");
          });
        },
        applicationId: 'APPLICATION_ID',
        skipTutorial: false,
        levelOfTrust: 'LEVEL_OF_TRUST_TOKEN',
        googleApiKey: 'GOOGLE_API_KEY',
        correlationId: 'correlationId',
      );
```

## 5. VALUES DESCRIPTION




| Keys.               | Values                                                                                                                                                             |
|:--------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `tenantId`          | **Required**. Write your organization tenant id                                                                                                                    |
| `tenantSecret`      | **Required**. Write your organization tenant secret.                                                                                                               |
| `enrollMode`        | **Required**. Mode of the SDK.                                                                                                                                     |
| `environment`       | **Required**. Select the EnrollEnvironment: EnrollEnvironment.STAGING  for staging and EnrollEnvironment.PRODUCTION for production.                                |
| `enrollCallback`    | **Required**. Callback function to receive success and error response.                                                                                             |
| `localizationCode`  | **Required**. Select your language code LocalizationCode.EN for English, and LocalizationCode.AR for Arabic. The default value is English.                         |
| `googleApiKey`      | **Optional**. Google Api Key to view the user current location on the map.                                                                                         |
| `applicantId`       | **Optional**. Write your Application id.                                                                                                                           |
| `levelOfTrustToken` | **Optional**. Write your Organization level of trust.                                                                                                              |
| `skipTutorial`      | **Optional**. Choose to ignore the tutorial or not.                                                                                                                |
| `appColors`         | **Optional**. Collection of the app colors that you could override like (primary - secondary - backGround - successColor - warningColor - errorColor - textColor). |
| `correlationId`     | **Optional**. Correlation ID to connect your User ID with our Request ID.                                                                                          |




