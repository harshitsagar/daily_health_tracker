plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.daily_health_tracker"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Enable core library desugaring
        isCoreLibraryDesugaringEnabled = true

        // Upgrade to Java 11 to fix obsolete warnings [citation:6][citation:8]
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        // Match Kotlin JVM target with Java version [citation:8]
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.daily_health_tracker"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Required for desugaring with minSdk < 26
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core library desugaring dependency [citation:5][citation:8]
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
