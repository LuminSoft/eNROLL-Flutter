package com.example.enroll_plugin

import android.util.Log
import android.content.Context
import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.google.gson.Gson
import com.google.gson.JsonObject
import com.luminsoft.enroll_sdk.core.models.*
import com.luminsoft.enroll_sdk.sdk.eNROLL
import com.luminsoft.enroll_sdk.ui_components.theme.AppColors

/** EnrollPlugin */
class EnrollPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "enroll_plugin")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "startEnroll" -> {
        handleStartEnroll(call, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  /*
  fun convertEnrollColorsToAppColors(enrollColors: EnrollColors): AppColors {
    return AppColors(
//      primary = enrollColors.primary?.let { convertDynamicColorToColor(it) } ?: AppColors().primary,
//      secondary = enrollColors.secondary?.let { convertDynamicColorToColor(it) } ?: AppColors().secondary,
//      backGround = enrollColors.appBackgroundColor?.let { convertDynamicColorToColor(it) } ?: AppColors().backGround,
//      textColor = enrollColors.textColor?.let { convertDynamicColorToColor(it) } ?: AppColors().textColor,
//      errorColor = enrollColors.errorColor?.let { convertDynamicColorToColor(it) } ?: AppColors().errorColor,
//      successColor = enrollColors.successColor?.let { convertDynamicColorToColor(it) } ?: AppColors().successColor,
//      warningColor = enrollColors.warningColor?.let { convertDynamicColorToColor(it) } ?: AppColors().warningColor,
//      white = enrollColors.appWhite?.let { convertDynamicColorToColor(it) } ?: AppColors().white,
//      black = enrollColors.appBlack?.let { convertDynamicColorToColor(it) } ?: AppColors().black
    )
  }

  fun convertDynamicColorToColor(dynamicColor: DynamicColor): Color {
    return Color.argb(
      (dynamicColor.opacity ?: 1.0) * 255.0,
      dynamicColor.r ?: 0,
      dynamicColor.g ?: 0,
      dynamicColor.b ?: 0
    )
  }*/

  private fun handleStartEnroll(call: MethodCall, result: MethodChannel.Result) {
    if (activity == null) {
      Log.e("EnrollPlugin", "Activity is null, cannot start enrollment")
      result.error("ACTIVITY_ERROR", "Activity is not available", null)
      return
    }

    val json = call.arguments<String>()

    try {
      val gson = Gson()
      val jsonObject = gson.fromJson(json, JsonObject::class.java)
      val tenantId = jsonObject.get("tenantId")?.asString ?: ""
      val applicationId = jsonObject.get("applicationId")?.asString ?: ""
      val levelOfTrust = jsonObject.get("levelOfTrust")?.asString ?: ""
      val skipTutorial = jsonObject.get("skipTutorial")?.asBoolean ?: false
      val googleApiKey = jsonObject.get("googleApiKey")?.asString ?: ""
      val tenantSecret = jsonObject.get("tenantSecret")?.asString ?: ""
      val enrollMode = if (jsonObject.get("enrollMode")?.asString == "ONBOARDING") {
        EnrollMode.ONBOARDING
      } else {
        EnrollMode.AUTH
      }

      val enrollEnvironment = if (jsonObject.get("enrollEnvironment")?.asString == "production") {
        EnrollEnvironment.PRODUCTION
      } else {
        EnrollEnvironment.STAGING
      }
      val localizationCode = if (jsonObject.get("localizationCode")?.asString == "ar") {
        LocalizationCode.AR
      } else {
        LocalizationCode.EN
      }
      val enrollColors = null  // Handle this appropriately if used

      Log.d("EnrollPlugin", "tenantId is $tenantId")
      Log.d("EnrollPlugin", "tenantSecret is $tenantSecret")
      Log.d("EnrollPlugin", "applicationId is $applicationId")
      Log.d("EnrollPlugin", "levelOfTrust is $levelOfTrust")
      Log.d("EnrollPlugin", "skipTutorial is $skipTutorial")
      Log.d("EnrollPlugin", "googleApiKey is $googleApiKey")
      Log.d("EnrollPlugin", "enrollEnvironment is $enrollEnvironment")
      Log.d("EnrollPlugin", "enrollMode is $enrollMode")
      Log.d("EnrollPlugin", "localizationCode is $localizationCode")
      Log.d("EnrollPlugin", "enrollColors is $enrollColors")

      eNROLL.init(
        tenantId,
        tenantSecret,
        applicationId,
        levelOfTrust,
        enrollMode,
        enrollEnvironment,
        localizationCode = localizationCode,
        object : EnrollCallback {
          override fun success(enrollSuccessModel: EnrollSuccessModel) {
            Log.d("EnrollPlugin", "eNROLL Message: ${enrollSuccessModel.enrollMessage}")
            result.success("Enrollment started successfully")
          }

          override fun error(enrollFailedModel: EnrollFailedModel) {
            Log.e("EnrollPlugin", "eNROLL Error: ${enrollFailedModel.failureMessage}")
            result.error("ENROLL_ERROR", enrollFailedModel.failureMessage, null)
          }

          override fun getRequestId(requestId: String) {
            Log.d("EnrollPlugin", "requestId: $requestId")
            result.success(requestId)

          }
        },
        googleApiKey = googleApiKey,
        skipTutorial = skipTutorial,
        appColors = AppColors()
      )

      eNROLL.launch(activity!!)
    } catch (e: Exception) {
      Log.e("EnrollPlugin", "Error in handleStartEnroll: ${e.message}", e)
      result.error("ENROLLMENT_ERROR", "An error occurred: ${e.message}", null)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }
}
