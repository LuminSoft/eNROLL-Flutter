import Flutter
import UIKit
import EnrollFramework

public class EnrollPlugin: NSObject, FlutterPlugin, EnrollCallBack {
    public func onInitializeRequest(requestId: String) {
    }
    
    
    //MARK: - Enroll Callbacks
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
    
    //MARK: - Properties
    var result: FlutterResult?
    
    
    //MARK: - Registering
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
    
    //MARK: - Launching Enroll
    func launchEnroll(json: String){
        do {
            
            var tenatId: String = ""
            var tenantSecret: String = ""
            var enrollEnvironment: EnrollFramework.EnrollEnviroment = .staging
            var localizationCode: EnrollFramework.LocalizationEnum = .en
            var enrollColors: EnrollColors?
            var skip: Bool?
            var mode: EnrollMode?
            var applicantId: String?
            var levelOfTrust: String?
            
            if let data = json.data(using: .utf8){
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                if let dict = jsonObject as? [String: Any] {
                    tenatId = dict["tenantId"] as? String ?? ""
                    tenantSecret = dict["tenantSecret"] as? String ?? ""
                    if let colors = dict["colors"] as? [String: Any]{
                        enrollColors = generateDynamicColors(colors: colors)
                    }
                    if let enrollMode = dict["enrollMode"] as? String{
                        if let value = getEnrollMode(mode: enrollMode) {
                            mode = value
                        }
                    }
                    if let skipTutorial = dict["skipTutorial"] as? Bool{
                        skip = skipTutorial
                    }
                    if let levelOfTrustSring =  dict["levelOfTrust"] as? String {
                        levelOfTrust = levelOfTrustSring
                    }
                    if let appId =  dict["applicationId"] as? String {
                        applicantId = appId
                    }
                    var localizationName = dict["localizationCode"] as? String ?? ""
                    var environmentName = dict["enrollEnvironment"] as? String ?? ""
                    if localizationName == "ar" {
                        localizationCode = .ar
                        UIView.appearance().semanticContentAttribute = .forceRightToLeft
                        UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
                        UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
                        UITextField.appearance().semanticContentAttribute = .forceRightToLeft
                        UITextField.appearance().textAlignment = .right
                        UITextView.appearance().semanticContentAttribute = .forceRightToLeft
                        UITableView.appearance().semanticContentAttribute = .forceRightToLeft
                    }else {
                        localizationCode = .en
                        UIView.appearance().semanticContentAttribute = .forceLeftToRight
                        UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
                        UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
                        UITextField.appearance().semanticContentAttribute = .forceLeftToRight
                        UITextView.appearance().semanticContentAttribute = .forceLeftToRight
                        UITextField.appearance().textAlignment = .left
                        UITableView.appearance().semanticContentAttribute = .forceLeftToRight
                    }
                    enrollEnvironment = environmentName == "staging" ? .staging : .production
                    
                    
                }
            }
            
            UIApplication.shared.delegate?.window??.rootViewController?.present(try Enroll.initViewController(enrollInitModel: EnrollInitModel(tenantId: tenatId, tenantSecret: tenantSecret, enrollEnviroment: enrollEnvironment, localizationCode: localizationCode, enrollCallBack: self, enrollMode: mode ?? .onboarding, skipTutorial: skip ?? false, enrollColors: enrollColors, levelOffTrustId: levelOfTrust, applicantId: applicantId), presenterVC: (UIApplication.shared.delegate?.window??.rootViewController!)!), animated: true)
        }catch{
            if let result = result {
                result(FlutterMethodNotImplemented)
            }
            
        }
        
    }
    
    //MARK: - Helpers
    
    func getEnrollMode(mode: String) -> EnrollMode?{
        switch mode.lowercased() {
        case  "onboarding":
            return .onboarding
        case  "update":
            return .update
        case  "auth":
            return .authentication
        default:
            return nil
        }
    }
    
    func generateDynamicColors(colors: [String: Any]?) -> EnrollColors{
        var primaryColor: UIColor?
        var appBackgroundColor: UIColor?
        var appBlack: UIColor?
        var secondary: UIColor?
        var appWhite: UIColor?
        var errorColor: UIColor?
        var textColor: UIColor?
        var successColor: UIColor?
        var warningColor: UIColor?
        
        
        if let primary = colors?["primary"] as? [String: Any]{
            if let red = primary["r"] as? Int, let green = primary["g"] as? Int, let blue = primary["b"] as? Int{
                primaryColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
            }
        }
        
        if let backgroundColor = colors?["appBackgroundColor"] as? [String: Any] {
            if let red = backgroundColor["r"] as? Int, let green = backgroundColor["g"] as? Int, let blue = backgroundColor["b"] as? Int, let alpha = backgroundColor["opacity"] as? Double {
                appBackgroundColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        if let black = colors?["appBlack"] as? [String: Any] {
            if let red = black["r"] as? Int, let green = black["g"] as? Int, let blue = black["b"] as? Int, let alpha = black["opacity"] as? Double {
                appBlack = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        if let secondaryColor = colors?["secondary"] as? [String: Any] {
            if let red = secondaryColor["r"] as? Int, let green = secondaryColor["g"] as? Int, let blue = secondaryColor["b"] as? Int, let alpha = secondaryColor["opacity"] as? Double {
                secondary = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        
        if let white = colors?["appWhite"] as? [String: Any] {
            if let red = white["r"] as? Int, let green = white["g"] as? Int, let blue = white["b"] as? Int, let alpha = white["opacity"] as? Double {
                appWhite = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        
        if let error = colors?["errorColor"] as? [String: Any] {
            if let red = error["r"] as? Int, let green = error["g"] as? Int, let blue = error["b"] as? Int, let alpha = error["opacity"] as? Double {
                errorColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        if let text = colors?["textColor"] as? [String: Any] {
            if let red = text["r"] as? Int, let green = text["g"] as? Int, let blue = text["b"] as? Int, let alpha = text["opacity"] as? Double {
                textColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        if let success = colors?["successColor"] as? [String: Any] {
            if let red = success["r"] as? Int, let green = success["g"] as? Int, let blue = success["b"] as? Int, let alpha = success["opacity"] as? Double {
                successColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        if let warning = colors?["warningColor"] as? [String: Any] {
            if let red = warning["r"] as? Int, let green = warning["g"] as? Int, let blue = warning["b"] as? Int, let alpha = warning["opacity"] as? Double {
                warningColor = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
            }
        }
        
        return EnrollColors(primary: primaryColor, secondary: secondary, appBackgroundColor: appBackgroundColor, textColor: textColor, errorColor: errorColor, successColor: successColor, warningColor: warningColor, appWhite: appWhite, appBlack: appBlack)
    }
}
