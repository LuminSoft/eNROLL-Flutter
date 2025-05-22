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