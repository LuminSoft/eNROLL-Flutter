package com.example.enroll_plugin
//import android.graphics.Color
import androidx.compose.ui.graphics.Color
import org.json.JSONObject

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

  fun convertJsonToEnrollColors(json: JSONObject): EnrollColors {
    return EnrollColors(
      primary = json.optJSONObject("primary")?.let { parseDynamicColor(it) },
      secondary = json.optJSONObject("secondary")?.let { parseDynamicColor(it) },
      appBackgroundColor = json.optJSONObject("appBackgroundColor")?.let { parseDynamicColor(it) },
      textColor = json.optJSONObject("textColor")?.let { parseDynamicColor(it) },
      errorColor = json.optJSONObject("errorColor")?.let { parseDynamicColor(it) },
      successColor = json.optJSONObject("successColor")?.let { parseDynamicColor(it) },
      warningColor = json.optJSONObject("warningColor")?.let { parseDynamicColor(it) },
      appWhite = json.optJSONObject("appWhite")?.let { parseDynamicColor(it) },
      appBlack = json.optJSONObject("appBlack")?.let { parseDynamicColor(it) }
    )
  }

  fun parseDynamicColor(json: JSONObject): DynamicColor {
    return DynamicColor(
      r = json.optInt("r", 0).takeIf { json.has("r") },
      g = json.optInt("g", 0).takeIf { json.has("g") },
      b = json.optInt("b", 0).takeIf { json.has("b") },
      opacity = json.optDouble("opacity", 1.0).takeIf { json.has("opacity") }
    )
  }

  fun convertDynamicColorToColor(dynamicColor: DynamicColor?): Color {
    return dynamicColor?.let {
      Color(
        alpha = (it.opacity ?: 1.0).toFloat(),
        red = (it.r ?: 0) / 255f,
        green = (it.g ?: 0) / 255f,
        blue = (it.b ?: 0) / 255f
      )
    } ?: Color(0xFFFFFFFF) // Default white color if dynamicColor is null
  }

fun convertEnrollColorsToAppColors(enrollColors: EnrollColors): AppColors {
  return AppColors(
    primary = convertDynamicColorToColor(enrollColors.primary),
    secondary = convertDynamicColorToColor(enrollColors.secondary),
    backGround = convertDynamicColorToColor(enrollColors.appBackgroundColor),
    textColor = convertDynamicColorToColor(enrollColors.textColor),
    errorColor = convertDynamicColorToColor(enrollColors.errorColor),
    successColor = convertDynamicColorToColor(enrollColors.successColor),
    warningColor = convertDynamicColorToColor(enrollColors.warningColor),
    white = convertDynamicColorToColor(enrollColors.appWhite),
    black = convertDynamicColorToColor(enrollColors.appBlack)
  )
}

  fun processEnrollColorsJson(jsonString: String): AppColors {
    val jsonObject = JSONObject(jsonString)
    val enrollColors = convertJsonToEnrollColors(jsonObject)
    return convertEnrollColorsToAppColors(enrollColors)
  }

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
      val enrollColors = jsonObject.get("colors").toString()
      val appColors = processEnrollColorsJson(enrollColors)

      Log.d("EnrollPlugin", "tenantId is $tenantId")
      Log.d("EnrollPlugin", "tenantSecret is $tenantSecret")
      Log.d("EnrollPlugin", "applicationId is $applicationId")
      Log.d("EnrollPlugin", "levelOfTrust is $levelOfTrust")
      Log.d("EnrollPlugin", "skipTutorial is $skipTutorial")
      Log.d("EnrollPlugin", "googleApiKey is $googleApiKey")
      Log.d("EnrollPlugin", "enrollEnvironment is $enrollEnvironment")
      Log.d("EnrollPlugin", "enrollMode is $enrollMode")
      Log.d("EnrollPlugin", "localizationCode is $localizationCode")
      Log.d("EnrollPlugin", "appColors is $appColors")

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
        appColors = appColors
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

data class EnrollColors(
  val primary: DynamicColor?,
  val secondary: DynamicColor?,
  val appBackgroundColor: DynamicColor?,
  val textColor: DynamicColor?,
  val errorColor: DynamicColor?,
  val successColor: DynamicColor?,
  val warningColor: DynamicColor?,
  val appWhite: DynamicColor?,
  val appBlack: DynamicColor?
)

data class DynamicColor(
  val r: Int?,
  val g: Int?,
  val b: Int?,
  val opacity: Double?
)
