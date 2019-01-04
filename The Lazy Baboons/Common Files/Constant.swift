//
//  Constant.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 17/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

let device = UIDevice.current
let deviceType = device.userInterfaceIdiom == .phone ? "iPhone" : "iPad"
let deviceOS = device.systemVersion
let deviceModel = device.modelName
let imei = 990000862471854
let defaults = UserDefaults.standard

typealias completion = (Bool,String?) -> ()

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct Version{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
    static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
}


extension UIViewController {
    
    func showInternetErrorAletView() {
        let alert = UIAlertController(title: "Mobile Data is Turned Off", message: "Turn on mobile data or use Wi-Fi to access data.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            
            
            if #available(iOS 10.0, *){
                
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            } else{
                UIApplication.shared.openURL(URL(string:UIApplication.openSettingsURLString)!)
                
                print("\n--- in ios other than 10 ")
            }
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    func showAlertViewWith(title : String,message: String)-> Void{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default)
        {
            (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getTopMostViewController(rootVC : UIViewController) -> UIViewController {
        var topvc = UIApplication.shared.keyWindow?.rootViewController
        
        while ((topvc?.presentedViewController) != nil) {
            topvc = topvc?.presentedViewController
        }
        
        return topvc!
    }
    
    func applyShadowToView(views : [UIView] )
    {
        
        for i in views
        {
            i.layer.cornerRadius = i.frame.size.height/2
            i.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            i.layer.shadowOpacity = 0.3
            
        }
        
    }


    
}

extension UserDefaults {
    
    func saveCustomObject(object : Any,key : String) {
        
        let myData = NSKeyedArchiver.archivedData(withRootObject: object)
        defaults.set(myData, forKey: key)
    }
    
    func getCustomObject(key : String) -> Any {
        
        let recovedData = defaults.object(forKey: key)
        return NSKeyedUnarchiver.unarchiveObject(with: recovedData as! Data)!
    }
}

extension UIApplication {
    
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}

@IBDesignable
extension UITextField {
    
    func setLeftIcon(_ icon: UIImage) {
        
        let padding = 15
        let outerPadding = padding + 10
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+outerPadding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: -1, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

extension UIView {
    
    func applyTransform(withScale scale: CGFloat, anchorPoint: CGPoint) {
        layer.anchorPoint = anchorPoint
        let scale = scale != 0 ? scale : CGFloat.leastNonzeroMagnitude
        let xPadding = 1/scale * (anchorPoint.x - 0.5)*bounds.width
        let yPadding = 1/scale * (anchorPoint.y - 0.5)*bounds.height
        transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: xPadding, y: yPadding)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        border.shadowOffset = CGSize(width: 0.0, height: 2.0)
        border.shadowOpacity = 0.3
        self.layer.addSublayer(border)
    }
    
    func showProgressView() {
        
        let progressView = MBProgressHUD.showAdded(to: self, animated: true)
        progressView.backgroundView.frame = self.bounds
        progressView.backgroundView.backgroundColor = UIColor.clear
        progressView.label.text = "Please Wait"
        progressView.bezelView.backgroundColor = UIColor.clear
        progressView.animationType = .fade
        progressView.isUserInteractionEnabled = false
        
    }
    
    func hideProgressView() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}

extension String {
    
    public func URLEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    public var convert24To12Hours : String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        if let date12 = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date12)
        }
        
        return self
    }
}

extension UIDevice {
    
    var modelName: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
