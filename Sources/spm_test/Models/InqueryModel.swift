//
//  InqueryModel.swift
//  sumirang
//
//  Created by 허학철 on 3/18/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import Foundation
import ObjectMapper

class InqueryModel: BaseModel {
//  var id: Int?
  var user_id: String?
  var app_kind: String?
  var title: String?
  var content: String?
  var answer: String?
  var created_at: String?
  var updated_at: String?
  var lang: String?
  var ans_content: String?
  var ans_created_at: String?
    var ans_updated_at: String?
  
  /// 결과
  var result: InqueryModel?
//  var data_array: [InqueryModel]?
  var data: [InqueryModel]?
  
  
  override func mapping(map: Map) {
    super.mapping(map: map)
//    self.id <- map["id"]
    self.user_id <- map["user_id"]
    self.app_kind <- map["app_kind"]
    self.title <- map["title"]
    self.content <- map["content"]
    self.answer <- map["answer"]
    self.created_at <- map["created_at"]
    self.updated_at <- map["updated_at"]
    self.lang <- map["lang"]
    self.ans_content <- map["ans_content"]
      self.ans_created_at <- map["ans_created_at"]
      self.ans_updated_at <- map["ans_updated_at"]
    
    self.result <- map["result"]
//    self.data_array <- map["data_array"]
    self.data <- map["data"]
  }
    
    
    /// API 성공 유무를 판단
    /// - Parameter response:
    /// - Returns: 성공 여부
    func getResultIfSuccess() -> InqueryModel? {
      
      if self.success ?? false {
        return self.result
      } else {
//        if let errors = self.errors, errors.count > 0 {
//          AJAlertController.initialization().showAlertWithOkButton(astrTitle: "", aStrMessage: errors[0], alertViewHiddenCheck: false) { position, title in
//          }
//        } else {
//          AJAlertController.initialization().showAlertWithOkButton(astrTitle: "", aStrMessage: self.message ?? "", alertViewHiddenCheck: false) { position, title in
//          }
//        }
        return nil
      }
    }

}
