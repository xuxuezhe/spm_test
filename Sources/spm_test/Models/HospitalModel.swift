//
//  HospitalModel.swift
//  sumirang
//
//  Created by 허학철 on 5/27/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import Foundation
import ObjectMapper

class HospitalModel: BaseModel {
    var msg: String?
  var title: String?
  var link: String?
    var img: String?
  
  /// 결과
    var result: HospitalModel?
    var data: [HospitalModel]?
  
  
  override func mapping(map: Map) {
    super.mapping(map: map)
      self.msg <- map["msg"]
    self.title <- map["title"]
    self.link <- map["link"]
      self.img <- map["img"]
      
      self.result <- map["result"]
      self.data <- map["data"]
  }
}
