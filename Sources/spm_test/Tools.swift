//
//  Tools.swift
//  자주 사용하는 함수 모음
//
//  Created by rocket on 2021/05/11.
//  Copyright © 2021 rocateer. All rights reserved.
//

import Foundation
//import NotificationBannerSwift
import UIKit
import Defaults
//import FirebaseFirestore

public class Tools {
  static let shared = Tools()
  
  public init() {
  }
  
  
  /// API 성공 유무를 판단
  /// - Parameter response:
  /// - Returns: 성공 여부
  public func isSuccessResponse(response: BaseModel) -> Bool {
    
    if response.success ?? false {
      return true
    } else {
      if let errors = response.errors, errors.count > 0 {
//        self.showToast(message: errors[0])
          print(errors[0])
      } else {
//        self.showToast(message: response.message ?? "")
          print(response.message ?? "")
      }
      return false
    }
  }
  
  /// 숫자 String 에 ",(콤마)" 표시 추가
  /// - Parameter value: 숫자 String
  /// - Returns: 결과 값
  func numberPlaceValue(_ value: String?) -> String {
    guard value != nil else { return "0" }
    let doubleValue = Double(value!) ?? 0.0
    let formatter = NumberFormatter()
    formatter.currencyCode = "KRW"
    formatter.currencySymbol = ""
    formatter.minimumFractionDigits = 0 //(value!.contains(".00")) ? 0 : 2
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currencyAccounting
    return formatter.string(from: NSNumber(value: doubleValue)) ?? "\(doubleValue)"
  }
  
  
  /// 토스트 표시
  /// - Parameter message: 배너 내용
//  func showToast(message: String) {
//    let banner = FloatingNotificationBanner(title: message, subtitle: nil, titleFont: UIFont.systemFont(ofSize: 14), titleColor: .white, titleTextAlign: .left, subtitleFont: nil, subtitleColor: nil, subtitleTextAlign: nil, leftView: nil, rightView: nil, style: .info, colors: .none, iconPosition: .center)
//    banner.backgroundColor = UIColor(named: "333333")!
//    banner.duration = 2
//    banner.animationDuration = 0.3
//    banner.bannerHeight = 70
//
//    banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: nil, edgeInsets: UIEdgeInsets(inset: 10), cornerRadius: 5, shadowColor: .black, shadowOpacity: 0.3, shadowBlurRadius: 5, shadowCornerRadius: 5, shadowOffset: UIOffset(horizontal: 0, vertical: 10), shadowEdgeInsets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
//  }
//  
//  /// 토스트 표시
//  /// - Parameter message: 배너 내용
//  func showToastWithImage(message: String, image: UIImage) {
//    let imageView = UIImageView(x: 0, y: 0, w: 30, h: 30, image: image)
//    imageView.setCornerRadius(radius: 12)
//    let banner = FloatingNotificationBanner(title: message, subtitle: nil, titleFont: UIFont.systemFont(ofSize: 14), titleColor: UIColor(named: "282828")!, titleTextAlign: .left, subtitleFont: nil, subtitleColor: nil, subtitleTextAlign: nil, leftView: imageView, rightView: nil, style: .info, colors: .none, iconPosition: .center)
//    banner.backgroundColor = UIColor(named: "F7F7F7")!
//    banner.duration = 2
//    banner.animationDuration = 0.3
//    banner.bannerHeight = 70
//
//    banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: nil, edgeInsets: UIEdgeInsets(inset: 10), cornerRadius: 20, shadowColor: .black, shadowOpacity: 0.2, shadowBlurRadius: 5, shadowCornerRadius: 3, shadowOffset: UIOffset(horizontal: 0, vertical: 10), shadowEdgeInsets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
//  }
  
  
  /// 전화 걸기
  /// - Parameter tel: 전화번호
  func openPhone(tel: String) {
    if let url = URL(string: "tel://\(tel)"), UIApplication.shared.canOpenURL(url) {
      if #available(iOS 10, *) {
        UIApplication.shared.open(url, options: [:], completionHandler:nil)
      } else {
        UIApplication.shared.openURL(url)
      }
    }
  }
  
  /// 외부 링크 열기
  /// - Parameter url: 링크
  func openBrowser(urlString: String) {
    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  /// 공유하기
  /// - Parameter shareString: 링크
  func openShare(shareString: String, viewController: UIViewController) {
    let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: ["\(shareString)"], applicationActivities: nil)
    viewController.present(activityViewController, animated: true, completion: nil)
  }
  
  /// 클립보드에 복사
  /// - Parameter text: 복사할 문자
  func copyToClipboard(text: String) {
    UIPasteboard.general.string = text
  }
  
  
  /// 이미지 url
  /// - Parameter path: url
  /// - Returns: 이미지 url
  func imageUrl(path: String) -> String {
    return "\(baseURL)storage/image/\(path)"
  }

  
  /// 썸네일 url
  /// - Parameter url: url
  /// - Returns: 썸네일 url
  func thumbnailImageUrl(path: String) -> String {
    return "\(baseURL)storage/thumb/\(path)"
  }



  
  /// 날짜 포맷 변경
  /// - Parameters:
  ///   - beforeDate: 변경하고자 하는 날짜
  ///   - beforeFormat: 변경 전 포맷
  ///   - afterFormat: 변경하고자 하는 포맷
  /// - Returns: 변경된 날짜
//  func changeDateFormat(beforeDate: String, beforeFormat: String, afterFormat: String) -> String {
//    let date = Date(fromString: beforeDate, format: beforeFormat) ?? Date()
//    return date.toString(format: afterFormat)
//  }
  
  
  /// 분을 String 시간으로
  /// - Parameter seconds: 분
  /// - Returns: String
  func intToHourMinute(seconds: Int) -> String {
    // 초와 분을 나눈다.
    let hour = seconds / 60
    let minute = (seconds % 60)
    
    if hour > 0 {
//      return "\(hour) \(minute)"
      return String(format:"%i\(NSLocalizedString("Hour", comment: "")) %i\(NSLocalizedString("Minute", comment: ""))", hour, minute)
    } else {
      return String(format:"%i\(NSLocalizedString("Minute", comment: ""))", minute)
    }
  }
    
    //MARK:캡처,view 의 지정구역 캡처
    static func getCropImage(_ view:UIView,size:CGSize) -> UIImage {
      //false투명배경 true불투명
      UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
      view.layer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      return image
    }
    
    func getRemainingTime(from startDate: Date, to endDate: Date) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: startDate, to: endDate)
        
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        return (days, hours, minutes, seconds)
    }
    
    class func openAppStore(appId: String) {
        let url = "itms-apps://itunes.apple.com/app/" + appId;
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func getDeviceInfo() -> (modelName: String, iosVersion: String) {
        // Get iOS version
        let iosVersion = UIDevice.current.systemVersion

        // Get model name
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }

        let modelName: String
        switch modelCode {
        case "iPhone1,1": modelName = "iPhone"
        case "iPhone1,2": modelName = "iPhone 3G"
        case "iPhone2,1": modelName = "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": modelName = "iPhone 4"
        case "iPhone4,1": modelName = "iPhone 4s"
        case "iPhone5,1", "iPhone5,2": modelName = "iPhone 5"
        case "iPhone5,3", "iPhone5,4": modelName = "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": modelName = "iPhone 5s"
        case "iPhone7,2": modelName = "iPhone 6"
        case "iPhone7,1": modelName = "iPhone 6 Plus"
        case "iPhone8,1": modelName = "iPhone 6s"
        case "iPhone8,2": modelName = "iPhone 6s Plus"
        case "iPhone8,4": modelName = "iPhone SE (1st generation)"
        case "iPhone9,1", "iPhone9,3": modelName = "iPhone 7"
        case "iPhone9,2", "iPhone9,4": modelName = "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": modelName = "iPhone 8"
        case "iPhone10,2", "iPhone10,5": modelName = "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": modelName = "iPhone X"
        case "iPhone11,2": modelName = "iPhone XS"
        case "iPhone11,4", "iPhone11,6": modelName = "iPhone XS Max"
        case "iPhone11,8": modelName = "iPhone XR"
        case "iPhone12,1": modelName = "iPhone 11"
        case "iPhone12,3": modelName = "iPhone 11 Pro"
        case "iPhone12,5": modelName = "iPhone 11 Pro Max"
        case "iPhone12,8": modelName = "iPhone SE (2nd generation)"
        case "iPhone13,1": modelName = "iPhone 12 mini"
        case "iPhone13,2": modelName = "iPhone 12"
        case "iPhone13,3": modelName = "iPhone 12 Pro"
        case "iPhone13,4": modelName = "iPhone 12 Pro Max"
        case "iPhone14,4": modelName = "iPhone 13 mini"
        case "iPhone14,5": modelName = "iPhone 13"
        case "iPhone14,2": modelName = "iPhone 13 Pro"
        case "iPhone14,3": modelName = "iPhone 13 Pro Max"
        case "iPhone14,6": modelName = "iPhone SE (3rd generation)"
        case "iPhone14,7": modelName = "iPhone 14"
        case "iPhone14,8": modelName = "iPhone 14 Plus"
        case "iPhone15,2": modelName = "iPhone 14 Pro"
        case "iPhone15,3": modelName = "iPhone 14 Pro Max"
        // Add more models as needed
        default: modelName = modelCode
        }

        return (modelName, iosVersion)
    }
    
    var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String,
            let build = dictionary["CFBundleVersion"] as? String else {return nil}

//        let versionAndBuild: String = "vserion: \(version), build: \(build)"
//        return versionAndBuild
        
        return version
    }
//    let db = Firestore.firestore()
//    func firestoreWriteData(data:[String]){
//        if let name = Defaults[.name], !name.isEmpty {
//            let date = "\(version ?? "") " + Date().toString(format: "yy-MM-dd")
//            let time = Date().toString(format: "HH:mm:ss")
//            let path = self.db.collection(Constants.shared.fb_collection).document(Defaults[.name]!).collection(date)
//            let doc = path.document("\(time) - \(data)")
//            data.map { value in
//                doc.setData(["\(time)": value])
//            }
//        
//            
////                .updateData(["\(date)": data])
//            
//        }
//    }
}
