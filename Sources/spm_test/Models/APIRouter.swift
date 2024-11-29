//
//  APIRouter.swift
//  sumirang
//
//  Created by rocket on 11/06/2019.
//  Copyright © 2019 rocateer. All rights reserved.
//

import Alamofire
import ObjectMapper
//import SwiftyJSON
import Result
//import NVActivityIndicatorView
import Defaults
import Foundation

#if DEBUG
let baseURL = "https://svc1.soomirang.kr/"
#else
let baseURL = "https://svc1.soomirang.kr/"
#endif

typealias JSONDict = [String: AnyObject]
typealias APIParams = [String: AnyObject]?

enum APIResult<T, Error> {
  case success(T)
  case fail(NSError)
  case unexpect(NSError)
}

enum APIURL: String {
  /// 인증
  case register = "api/register" // 회원가입
  case login = "api/login" // 로그인
  case sns = "api/sns" // SNS 회원가입,로그인
  case me = "api/me" // 사용자 프로필 정보 확인
  case logout = "api/logout" // 로그아웃
  case leave = "api/leave" // 회원탈퇴
    case joinagree = "api/joinagree" // 약관동의
    case fcmupdate = "api/fcmupdate" // FCM key 업데이트
  
  // 수면데이터
  case sleepdata_create = "api/sleepdata/createV4" // 수면 데이터 측정 시작
//    case sleepdata_createv2 = "api/sleepdata/createv2" // 수면 데이터 측정 시작
//    case sleepdata_createplus = "api/sleepdata/createplus" // 수면 데이터 측정 시작
  case sleepdata_upload = "api/sleepdata/upload" // 수면 데이터 파일 업로드
    case sleepdata_uploadplus = "api/sleepdata/uploadplus" // 수면 데이터 파일 업로드
    case sleepdata_uploadv2 = "api/sleepdata/uploadv2" // 수면 데이터 파일 업로드
    case sleepdata_uploadv3 = "api/sleepdata/uploadv3" // 수면 데이터 파일 업로드
  case sleepdata_result = "api/sleepdata/result" // 수면 데이터 결과
  case snoredata_result = "api/snoredata/result" // 코골이 데이터 결과
  case sleepdata_delete = "api/sleepdata/delete" // 수면 데이터 삭제
    
    case sleepdata_chksensor = "api/sleepdata/chksensorV3" // 센서 등록 제한
    case sleepdata_chkversion = "api/sleepdata/chkversionV2" // 센서 버전
    case sleepdata_regversion = "api/sleepdata/regversionV2" // 센서 버전 등록
  
  case sleepdata_week = "api/sleepdata/week" // 수면 데이터 분 보기
  case sleepdata_detail = "api/sleepdata/detail" // 수면 데이터 날짜별 상세 목록
    case sleepdata_year = "api/sleepdata/yearsV2" // 수면 데이터 년도별 목록
    case sleepdata_year_detail = "api/sleepdata/yearsdetailV2" // 측정 데이터 상세
    
    case inquerys = "api/sleepdata/viewappqa" // 문의 리스트
    case inquery_add = "api/sleepdata/regappqa" // 문의하기
    
    case faqs = "api/sleepdata/viewappfaq" // FAQ 리스트
    
    case scoremsg = "api/sleepdata/scoremsg" // 점수 메시지 조회
    
    case rentalcompany = "api/rentalcompany" // 임대(렌탈) 업체 조회
    case updateruser = "api/updateruser" // 임대(렌탈) 유저 정보 등록
    
    case connectlink = "api/sleepdata/connectlinkv2" // 수면 상세
    
  /// CS
  case notice = "api/notice/list" // 공지시항 리스트
  case notice_detail = "api/notice/detail" // 공지사항 상세
  case faq = "api/faq/list" // faq
  case qa = "api/qa/list" // 1:1문의 리스트
  case qa_detail = "api/qa/detail" // 1:1문의 상세
  case qa_create = "api/qa/create" // 1:1문의 등록
  case qa_delete = "api/qa/delete" // 1:1문의 삭제
  
  
  
  /// 파일 업로드
  case imageupload = "api/imageupload" // 이미지 업로드
  case imageMultiUpload = "api/imageMultiUpload" // 이미지 다중 업로드
  
}


class APIRouter {
  // Singleton
  static let shared = APIRouter()
//  var activityData: ActivityData = ActivityData()
  
  private init() {
//    self.activityData = ActivityData(size: CGSize(width: 50, height: 50), message: "", messageFont: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: nil, displayTimeThreshold: 1, minimumDisplayTime: 300, backgroundColor: UIColor.clear, textColor: UIColor.black)
  }
  
  
  /// Simple API
  /// - Parameters:
  ///   - path: API URL
  ///   - method: HTTP Method
  ///   - parameters: parameter
  ///   - success: 성공
  ///   - fail: 실패
  func api(path: APIURL, method: HTTPMethod = .post, parameters: [String: Any]?, success: @escaping(_ data: [String: Any])-> Void) {
    
    var headers: HTTPHeaders = []
    if let access_token = Defaults[.access_token], access_token != "", path != .login {
      headers = [
        "Authorization" : "Bearer \(access_token)",
      ]
    }
    
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
    AF.request( baseURL + path.rawValue, method:method, parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
//      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if APIResponse.shared.isSuccessStatus(response: response) {
        success(response.result.value as! [String : Any])
      }
    })
  }
    
    func api_temp(path: APIURL, method: HTTPMethod = .post, parameters: [String: Any]?, success: @escaping(_ data: [String: Any])-> Void) {
      
      var headers: HTTPHeaders = []
      if let access_token = Defaults[.access_token], access_token != "", path != .login {
        headers = [
          "Authorization" : "Bearer \(access_token)",
        ]
      }
      
//      NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
      AF.request( baseURL + path.rawValue, method:method, parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        
        if APIResponse.shared.isSuccessStatus(response: response) {
          success(response.result.value as! [String : Any])
        }
      })
    }
    
  func csv_api(path: APIURL, parameters: [String: Any]?, file: Data, bytes: [UInt8]?, fileName: String, success: @escaping(_ data: [String: Any])-> Void, fail: @escaping (_ error: Error?)-> Void) {
//    let headers: HTTPHeaders = [
//      "Content-type": "multipart/form-data"
//    ]
      
      var headers: HTTPHeaders = []
      if let access_token = Defaults[.access_token], access_token != "", path != .login {
        headers = [
          "Authorization" : "Bearer \(access_token)",
          "Content-type": "multipart/form-data"
        ]
      }
      
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
//    log.debug(parameters ?? [])
    AF.upload(multipartFormData: { (multipartFormData) in
      multipartFormData.append(file, withName: "file", fileName: fileName, mimeType: "text/csv")
      if let parameters = parameters {
        for (key, value) in parameters {
          multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
        }
      }
      
    }, to: baseURL + path.rawValue, method: .post, headers: headers, requestModifier: {$0.timeoutInterval = 60 * 5}).responseJSON(completionHandler: { response in
//      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      if APIResponse.shared.isSuccessStatus(response: response) {
        success(response.result.value as! [String : Any])
      } else {
        fail(response.result.error)
      }
    })
    
  }
  
  
  /// Multipart Form
  /// - Parameters:
  ///   - path: API URL
  ///   - method: HTTP Method
  ///   - userFile: File
  ///   - success: 성공
  ///   - fail: 실패
  func api(path: APIURL, method: HTTPMethod = .post, file : Data, success: @escaping(_ data: [String: Any])-> Void) {
//    let headers: HTTPHeaders = [
//      "Content-type": "multipart/form-data"
//    ]
      
      var headers: HTTPHeaders = []
      if let access_token = Defaults[.access_token], access_token != "", path != .login {
        headers = [
          "Authorization" : "Bearer \(access_token)",
          "Content-type": "multipart/form-data"
        ]
      }
      
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
    AF.upload(multipartFormData: { (multipartFormData) in
      multipartFormData.append(file, withName: "image", fileName: "rocateer.png", mimeType: "image/jpeg")
    }, to: baseURL + path.rawValue, method: .post, headers: headers).responseJSON(completionHandler: { response in
//      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      if APIResponse.shared.isSuccessStatus(response: response) {
        success(response.result.value as! [String : Any])
      }
    })
  }
  
  /// Multipart Form
  /// - Parameters:
  ///   - path: API URL
  ///   - method: HTTP Method
  ///   - userFile: File
  ///   - success: 성공
  ///   - fail: 실패
  func multiApi(path: APIURL, method: HTTPMethod = .post, fileList: [Data], success: @escaping(_ data: [String: Any])-> Void) {
//    let headers: HTTPHeaders = [
//      "Content-type": "multipart/form-data"
//    ]
      
      var headers: HTTPHeaders = []
      if let access_token = Defaults[.access_token], access_token != "", path != .login {
        headers = [
          "Authorization" : "Bearer \(access_token)",
          "Content-type": "multipart/form-data"
        ]
      }
      
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData, nil)
    AF.upload(multipartFormData: { (multipartFormData) in
      for value in fileList {
        multipartFormData.append(value, withName: "image[]", fileName: "rocateer.png", mimeType: "image/jpeg")
      }
    }, to: baseURL + path.rawValue, method: .post, headers: headers).responseJSON(completionHandler: { response in
//      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      if APIResponse.shared.isSuccessStatus(response: response) {
        success(response.result.value as! [String : Any])
      }
    })
  }
  
}


