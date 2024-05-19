import Flutter
import UIKit
import EnrollFramework

public class EnrollPlugin: NSObject, FlutterPlugin, EnrollCallBack {
    public func onSuccess() {
        if let result = result {
            result(String("success"))
        }
    }
    
    public func onError(message: String) {
        if let result = result {
            result(FlutterError(code: "0", message: message, details: nil))
        }
    }
    
    var result: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "enroll_plugin", binaryMessenger: registrar.messenger())
    let instance = EnrollPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      self.result = result
    switch call.method {
    case "startEnroll":
            if let json = call.arguments as? String{
                launchEnroll(json: json)
            }
        
        self.onSuccess()
        break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    
    func launchEnroll(json: String){
        do {
            
            var tenatId: String = ""
            var tenantSecret: String = ""
            var enrollEnvironment: EnrollFramework.EnrollEnviroment = .staging
            var localizationCode: EnrollFramework.LocalizationEnum = .en
            
            if let data = json.data(using: .utf8){
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                if let dict = jsonObject as? [String: Any] {
                    tenatId = dict["tenantId"] as? String ?? ""
                    tenantSecret = dict["tenantSecret"] as? String ?? ""
                    var localizationName = dict["localizationCode"] as? String ?? ""
                    var environmentName = dict["enrollEnvironment"] as? String ?? ""
                    localizationCode = localizationName == "ar" ? .ar : .en
                    enrollEnvironment = environmentName == "staging" ? .staging : .production
                    
                }
            }
            
            UIApplication.shared.delegate?.window??.rootViewController?.present(try Enroll.initViewController(enrollInitModel: EnrollInitModel(tenantId: tenatId, tenantSecret: tenantSecret, enrollEnviroment: enrollEnvironment, localizationCode: localizationCode, enrollCallBack: self), presenterVC: (UIApplication.shared.delegate?.window??.rootViewController!)!), animated: true)
        }catch{
            if let result = result {
                result(FlutterMethodNotImplemented)
            }
            
        }
        
    }
}
