//
//  SensorModel.swift
//  sumirang
//
//  Created by 허학철 on 5/3/24.
//  Copyright © 2024 rocateer. All rights reserved.
//


import Foundation
import ObjectMapper

class SensorModel: BaseModel {
  var number: String?
  var version: String?
    var ver: String?
    var url: String?
    var language: String?
    var desc: String? //해당 버전 업데이트 내용
    var sensor_ver: String? //해당 센서의 버전
    var app_kind: String?
    var mac: String?
  
  /// 결과
  var result: SensorModel?
  
  
  override func mapping(map: Map) {
    super.mapping(map: map)
    self.number <- map["number"]
    self.version <- map["version"]
      self.ver <- map["ver"]
      self.url <- map["url"]
      self.language <- map["language"]
      self.desc <- map["desc"]
      self.sensor_ver <- map["sensor_ver"]
      self.app_kind <- map["app_kind"]
      self.mac <- map["mac"]
    
    self.result <- map["result"]
  }
}
