//
//  SleepModel.swift
//  sumirang
//
//  Created by rocateer on 10/6/23.
//  Copyright © 2023 rocateer. All rights reserved.
//


import Foundation
import ObjectMapper

public class SleepModel: BaseModel {
  var user_id: Int?
  // 블루투스 센서 아이디
  var number: String?
  var dirname: String?
  var filename: String?
    // 잠들때까지 걸린 시간
  var asleep_time: Int?
  // 0: 수면, 1: 코골이
  var type: Int?
  // 코골이 시간 (코골이 측정 시 사용, 분 단위로 입력 (2시간 = 120분)
  var snore_time: Int?
    // 호흡상태(3: 나쁨, 2: 중간, 1: 좋음, 0: 측정불가)
  var apnea_state: Int?
    // 이상호흡 총 횟수
  var apnea_count: Int?
  var apnea_10: Int?
  var apnea_30: Int?
  var apnea_60: Int?
    // 바로 누운 자세 시간 (분)
  var straight_position: Int?
  var left_position: Int?
  var right_position: Int?
  var down_position: Int?
  var wake_time: Int?
    // 수면 패턴
  var sleep_pattern: String?
  var started_at: String?
  var ended_at: String?
    var toyear: Int?
    // 총 수면 시간
  var sleep_time: Int?
  var state: Int?
  var calendarDate: Date?
  // 수면 데이터 아이디
  var data_id: Int?
  var minute: Int?
  var day: String?
    var app_kind: String?
    // 깊은잠 시간
    var deep_sleep_time: Int?
    // 뒤척인 횟수
    var move_count: Int?
    // 빠른 호흡 수
    var fast_breath: Int?
    // 느린 호흡 수
    var slow_breath: Int?
    // 불안정 호흡 수
    var unstable_breath: Int?
    // 분당 평균 정상호흡 수
    var avg_normal_breath: Double?
    var avg_normal_breath_ten: String?
    // 정상호흡 시간
    var normal_breath_time: Int?
    // 바로 누운 자세 비율 (%)
    var straight_per: Int?
    // 왼쪽으로 누운 자세 비율 (%)
    var left_per: Int?
    // 오른쪽으로 누운 자세 비율 (%)
    var right_per: Int?
    // 엎드린 자세 비율 (%)
    var down_per: Int?
    // 일어난 시간 비율 (%)
    var wake_per: Int?
    // 렘 수면 시간
    var rem_sleep_time: Int?
    // 얕은 수면 시간
    var light_sleep_time: Int?
    // 깬 시간
    var wake_sleep_time: Int?
    var description: String?
    // 기침 횟수
    var cough_count: Int?
    // 진동 횟수
    var snore_count: Int?
    var breath_score: Int?
    var snore_score: Int?
    // 평균 분당 빠른호흡수
    var avg_fast_breath: Int?
    // 평균 분당 느린호흡수
    var avg_slow_breath: Int?
    // 코골이 측정데이터 부족
    var ios_sensor: String?
    var ment: String?
    var language: String?
    var score: String?
    var time: String?
    var nobreath_idx: String? // 무호흡
    var snoring_idx: String? // 코골이
    var unstable_idx: String? // 호흡불안정
    var supine_idx: String? // 정자세
    var left_idx: String? // 왼쪽
    var right_idx: String? // 오른쪽
    var prone_idx: String? // 엎드린
    var rem_idx: String? // 렘수면
    var light_idx: String? // 얕은수면
    var deep_idx: String? // 깊은수면
    var movement_idx: String? // 움직임
    var wake_idx: String? // 꺰
    var cough_idx: String? // 기침
    var up_idx: String? // 일어남
    var avg_snore_count: Int? // 시간당 코골이
    var icon: String? // 점수 별 아이콘
    var icon_title: String? // 점수 별 타이틀
    var icon_desc: String? // 점수 별 상세문구
    var sleep_now: String? // 잠든 시간
    var wake_now: String? // 깨어난 시간
    var not_measured_time: Int? // 측정 안된 시간
    var mac: String? // 센서 MAC 주소
    
  var result: SleepModel?
  var data: [SleepModel]?
  
  
  public override func mapping(map: Map) {
    super.mapping(map: map)
    self.user_id <- map["user_id"]
    self.number <- map["number"]
    self.dirname <- map["dirname"]
    self.filename <- map["filename"]
    self.asleep_time <- map["asleep_time"]
    self.type <- map["type"]
    self.snore_time <- map["snore_time"]
    self.apnea_state <- map["apnea_state"]
    self.apnea_count <- map["apnea_count"]
    self.apnea_10 <- map["apnea_10"]
    self.apnea_30 <- map["apnea_30"]
    self.apnea_60 <- map["apnea_60"]
    self.straight_position <- map["straight_position"]
    self.left_position <- map["left_position"]
    self.right_position <- map["right_position"]
    self.down_position <- map["down_position"]
    self.wake_time <- map["wake_time"]
    self.sleep_pattern <- map["sleep_pattern"]
    self.started_at <- map["started_at"]
    self.ended_at <- map["ended_at"]
      self.toyear <- map["toyear"]
    self.sleep_time <- map["sleep_time"]
    self.state <- map["state"]
    self.data_id <- map["data_id"]
    self.minute <- map["minute"]
    self.day <- map["day"]
      self.app_kind <- map["app_kind"]
      self.deep_sleep_time <- map["deep_sleep_time"]
      self.move_count <- map["move_count"]
      self.fast_breath <- map["fast_breath"]
      self.slow_breath <- map["slow_breath"]
      self.unstable_breath <- map["unstable_breath"]
      self.avg_normal_breath <- map["avg_normal_breath"]
      self.avg_normal_breath_ten <- map["avg_normal_breath_ten"]
      self.normal_breath_time <- map["normal_breath_time"]
      self.straight_per <- map["straight_per"]
      self.left_per <- map["left_per"]
      self.right_per <- map["right_per"]
      self.down_per <- map["down_per"]
      self.wake_per <- map["wake_per"]
      self.rem_sleep_time <- map["rem_sleep_time"]
      self.light_sleep_time <- map["light_sleep_time"]
      self.description <- map["description"]
      self.cough_count <- map["cough_count"]
      self.snore_count <- map["snore_count"]
      self.breath_score <- map["breath_score"]
      self.snore_score <- map["snore_score"]
      self.avg_fast_breath <- map["avg_fast_breath"]
      self.avg_slow_breath <- map["avg_slow_breath"]
      self.ios_sensor <- map["ios_sensor"]
      self.ment <- map["ment"]
      self.language <- map["language"]
      self.score <- map["score"]
      self.time <- map["time"]
      self.nobreath_idx <- map["nobreath_idx"]
      self.snoring_idx <- map["snoring_idx"]
      self.unstable_idx <- map["unstable_idx"]
      self.supine_idx <- map["supine_idx"]
      self.left_idx <- map["left_idx"]
      self.right_idx <- map["right_idx"]
      self.prone_idx <- map["prone_idx"]
      self.rem_idx <- map["rem_idx"]
      self.light_idx <- map["light_idx"]
      self.deep_idx <- map["deep_idx"]
      self.movement_idx <- map["movement_idx"]
      self.wake_idx <- map["wake_idx"]
      self.cough_idx <- map["cough_idx"]
      self.up_idx <- map["up_idx"]
      self.avg_snore_count <- map["avg_snore_count"]
      self.wake_sleep_time <- map["wake_sleep_time"]
      self.icon <- map["icon"]
      self.icon_title <- map["icon_title"]
      self.icon_desc <- map["icon_desc"]
      self.sleep_now <- map["sleep_now"]
      self.wake_now <- map["wake_now"]
      self.not_measured_time <- map["not_measured_time"]
      self.mac <- map["mac"]
      
    self.result <- map["result"]
    self.data <- map["data"]
  }
  
  /// API 성공 유무를 판단
  /// - Parameter response:
  /// - Returns: 성공 여부
  func getResultIfSuccess() -> SleepModel? {
    
    if self.success ?? false {
      return self.result
    } else {
//      if let errors = self.errors, errors.count > 0 {
//        AJAlertController.initialization().showAlertWithOkButton(astrTitle: "", aStrMessage: errors[0], alertViewHiddenCheck: false) { position, title in
//        }
//      } else {
//        AJAlertController.initialization().showAlertWithOkButton(astrTitle: "", aStrMessage: self.message ?? "", alertViewHiddenCheck: false) { position, title in
//        }
//      }
      return nil
    }
  }

}
