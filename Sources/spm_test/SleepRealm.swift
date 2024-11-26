//
//  SleepRealm.swift
//  sumirang
//
//  Created by rocateer on 10/11/23.
//  Copyright © 2023 rocateer. All rights reserved.
//

import UIKit
import RealmSwift

final class SleepListRealm: Object {
  let items = List<SleepRealm>()
}

final class SleepRealm: Object {
  @objc dynamic var index : Int = 0
  @objc dynamic var time : String = ""
  @objc dynamic var capacitance : Int = 0 // 측정한 Capacitance 값 전송 (최대 8자리 정수 값, 10진수 기준)
  @objc dynamic var acc_x : Double = 0.0 // 측정한 가속도 값 (X축 / Y축 / Z축 순서로 각 1byte raw data)
  @objc dynamic var acc_y : Double = 0.0
  @objc dynamic var acc_z : Double = 0.0
  
  
  

}


