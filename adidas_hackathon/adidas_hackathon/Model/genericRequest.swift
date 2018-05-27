//
//  genericRequest.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire
import SwiftyJSON

class WebRequest: NSObject {
    static let sharedInstance:WebRequest=WebRequest()
    
    
    //all Request to API
    func getGenericRequest(url:String,delegate:WebRequestDelegate) {
        if isInternetAvailable(){
            
            let queue = DispatchQueue(label: "aa", qos: .utility, attributes: [.concurrent])
            //puesto a pelo url, body y header TODO
            Alamofire.request(url, method: .get,encoding: JSONEncoding()).responseData(
                queue: queue,
                completionHandler:{
                    response in
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)")
                    }
            })
        }else{
            
            let myAlert = UIAlertController(title: "No tiene internet", message: "Por favor compruebe su conexion", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                exit(0)
            })
            myAlert.addAction(okAction)
            DispatchQueue.main.async {
                UIApplication.topViewController()?.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}

@objc protocol WebRequestDelegate {
    @objc optional func WRDComunication(result:String)
}

//This extension is used to display the alert of the func genericRequest
extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
