//
//  FaqModel.swift
//  sumirang
//
//  Created by rocket on 10/06/2019.
//  Copyright © 2019 rocateer. All rights reserved.
//

import Foundation
import ObjectMapper

class FaqModel: BaseModel {
      var sequence: String?
      var question: String?
      var answer: String?
      var created_at: String?
    
      /// 결과
      var result: FaqModel?
    //  var data_array: [FaqModel]?
      var data: [FaqModel]?
      
      
      override func mapping(map: Map) {
        super.mapping(map: map)
    //    self.id <- map["id"]
        self.sequence <- map["sequence"]
        self.question <- map["question"]
        self.answer <- map["answer"]
        self.created_at <- map["created_at"]
        
        self.result <- map["result"]
    //    self.data_array <- map["data_array"]
        self.data <- map["data"]
      }
        
        
        /// API 성공 유무를 판단
        /// - Parameter response:
        /// - Returns: 성공 여부
        func getResultIfSuccess() -> FaqModel? {
          
          if self.success ?? false {
            return self.result
          } else {
//            if let errors = self.errors, errors.count > 0 {
//              AJAlertController.initialization().showAlertWithOkButton(astrTitle: "", aStrMessage: errors[0], alertViewHiddenCheck: false) { position, title in
//              }
//            } else {
//              AJAlertController.initialization().showAlertWithOkButton(astrTitle: "", aStrMessage: self.message ?? "", alertViewHiddenCheck: false) { position, title in
//              }
//            }
            return nil
          }
        }

    }
