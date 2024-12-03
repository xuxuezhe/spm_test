//
//  CoughListRealm.swift
//  sumirang
//
//  Created by 허학철 on 9/4/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import Foundation
import RealmSwift

final class CoughListRealm: Object {
  let items = List<CoughRealm>()
}

public final class CoughRealm: Object {
  @objc dynamic public var time : String = ""
}
