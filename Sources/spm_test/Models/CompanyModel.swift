//
//  CompanyModel.swift
//  sumirang
//
//  Created by 허학철 on 6/5/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import Foundation
import ObjectMapper

class CompanyModel: BaseModel {
    var name: String?
    var code: String?
  
  /// 결과
    var result: CompanyModel?
    var data: [CompanyModel]?
  
  
  override func mapping(map: Map) {
    super.mapping(map: map)
      self.name <- map["name"]
      self.code <- map["code"]
      
      self.result <- map["result"]
      self.data <- map["data"]
  }
}
