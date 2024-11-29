//
//  MemberModel.swift
//  sumirang
//
//  Created by rocket on 10/06/2019.
//  Copyright © 2019 rocateer. All rights reserved.
//

import Foundation
import ObjectMapper

class MemberModel: BaseModel {
  // 이메일
  var email: String?
  // 비밀번호
  var password: String?
  // 비밀번호 확인
  var password_confirmation: String?
  // 이름
  var name: String?
  // 연락처
  var phone: String?
  // 생년월일
  var birth: String?
  // 팔로워 수
  var follower_count: Int?
  // 팔로잉 수
  var following_count: Int?
  // 성별 - 0 : 남자, 1: 여자
  var gender: String?
  /// 회원 가입 유형 K: kakao , N : 네이버, G : 구글 , A : 애플
  var sns_type: String?
  /// 서버 데이터 저장 동의 - 0:동의 안함, 1:동의
  var is_server_data: Int?
  /// 앱 개선에 데이터 활용 동의 - 0:동의 안함, 1:동의
  var is_app_data: Int?
  /// 탈퇴사유
  var leave_reason: String?
    // 측정 데이터 구분을 위한 값 – C: B2C앱, B:B2B앱
    var app_kind: String?
    /// 회원일 경우 -> member : Y, 아닐경우 -> member: N
    var member: String?
    var comp_code: String? //병원 코드
  var result: MemberModel?
  var user: MemberModel?
  
  override func mapping(map: Map) {
    super.mapping(map: map)
    self.email <- map["email"]
    self.password <- map["password"]
    self.password_confirmation <- map["password_confirmation"]
    self.name <- map["name"]
    self.phone <- map["phone"]
    self.birth <- map["birth"]
    self.follower_count <- map["follower_count"]
    self.following_count <- map["following_count"]
    self.gender <- map["gender"]
    self.sns_type <- map["sns_type"]
    self.is_server_data <- map["is_server_data"]
    self.is_app_data <- map["is_app_data"]
    self.leave_reason <- map["leave_reason"]
      self.member <- map["member"]
      self.app_kind <- map["app_kind"]
      self.comp_code <- map["comp_code"]
    
    self.user <- map["user"]
    self.result <- map["result"]
  }
}
