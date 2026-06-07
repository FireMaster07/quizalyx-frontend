import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // WE ADD THIS HERE: Activate Google services
    id("com.google.gms.google-services")
}

// STEP 1: Kotlin code that reads the key.properties file
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.quizalyx.quizalyx"
    compileSdk = flutter. compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.quizalyx.quizalyx"
        minSdk = flutter.minSdkVersion //UPDATED
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner" //ADDED
        multiDexEnabled = true; //ADDED
    }

    // STEP 2: Signing configurations (in Kotlin DSL format)
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?. let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            // STEP 3: We use the release key instead of the debug key
            signingConfig = signingConfigs. getByName("release")

            // Code shrinking settings
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

// Add to the bottom of the file
dependencies {
    // Espresso and AndroidX Test dependencies (in Kotlin DSL form)
    androidTestImplementation("androidx.test:runner:1.5.2")
    androidTestImplementation("androidx.test:rules:1.5.0")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
    // Multidex libraries:
    implementation("androidx.multidex:multidex:2.0.1")
    androidTestImplementation("androidx.multidex:multidex:2.0.1")
}

configurations.all {
    exclude(group = "com.google.protobuf", module = "protobuf-lite")
}