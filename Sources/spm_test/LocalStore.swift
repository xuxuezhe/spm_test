//
//  LocalStore.swift
//

import UIKit
import Defaults

public extension Defaults.Keys {
  static let access_token = Key<String?>("access_token")
  static let email = Key<String?>("email")
  static let name = Key<String?>("name")
  static let password = Key<String?>("password")
  static let sns_token = Key<String?>("sns_token")
  static let id = Key<Int?>("id")
  static let member_join_type = Key<String?>("member_join_type")
//  static let member_id = Key<String?>("member_id")
//  static let member_pw = Key<String?>("member_pw")
  static let bannerDay = Key<Date?>("bannerDay")
  static let tutorial = Key<Bool?>("tutorial") // false 면 tutorial열고, true면 열지 않음
  
  static let device_address = Key<String?>("device_address")
  static let device_name = Key<String?>("device_name")
    static let mac_address = Key<String?>("mac_address")
    
    //약관동의
    static let is_consented = Key<Bool?>("is_consented")
    //센서 사용 설명 팝업 여부
    static let is_checked_sensor = Key<String?>("is_checked_sensor")
    // 측정 강제종료 여부 호흡
    static let is_forcefully_stop_breath = Key<String?>("is_forcefully_stop_breath")
    // 측정 강제종료 여부 코골이
    static let is_forcefully_stop_snore = Key<String?>("is_forcefully_stop_snore")
    // 측정 하고 있는 데이터 아이디
    static let data_id = Key<String?>("data_id")
}
