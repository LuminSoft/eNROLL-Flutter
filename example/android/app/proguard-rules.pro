##############################################
# Flutter & Dart
##############################################

# Keep all Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

##############################################
# Kotlin
##############################################

# Keep Kotlin metadata (required for Kotlin reflection)
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**

##############################################
# Jetpack Compose
##############################################

# Keep Compose runtime, UI, and foundation
-keep class androidx.compose.runtime.** { *; }
-keep class androidx.compose.ui.** { *; }
-keep class androidx.compose.foundation.** { *; }

# Preserve Composable methods
-keepclassmembers class ** {
    @androidx.compose.runtime.Composable <methods>;
}

# Preserve Compose resource loading
-keep class androidx.compose.ui.res.** { *; }
-keep class androidx.compose.ui.res.PainterResources_androidKt { *; }

# Preserve vector drawables and resources
-keep class androidx.vectordrawable.graphics.drawable.** { *; }
-dontwarn androidx.vectordrawable.graphics.drawable.**

# Preserve app-specific resources
-keep class com.luminsoft.enroll_sdk.R { *; }

##############################################
# AndroidX and Lifecycle
##############################################

-keep class androidx.lifecycle.** { *; }
-keep class androidx.appcompat.** { *; }
-keep class androidx.fragment.app.** { *; }

##############################################
# Prevent over-optimization
##############################################

-dontoptimize
-dontobfuscate

-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE

# Keep vector drawables
-keepclassmembers class ** {
    public static <fields>;
}
-keep class androidx.compose.ui.res.** { *; }

# ✅ Keep all drawables in the R class
-keepclassmembers class **.R$drawable {
    public static <fields>;
}