plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.nwash_project"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"// Ensure this is set to the required NDK version

    compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}

kotlinOptions {
    jvmTarget = JavaVersion.VERSION_11.toString()
}

    defaultConfig {
        // Specify your unique Application ID
        applicationId = "com.example.nwash_project"
        
        // Update the following values to match your application needs.
        minSdk = 24 // Update to at least 24 as required by some plugins
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Add your own signing config for the release build.
            signingConfig = signingConfigs.getByName("debug") // Use debug signing for now
        }
    }
}

flutter {
    source = "../.." // Path to the Flutter module
}