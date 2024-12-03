//
//  SnoreRealm.swift
//  sumirang
//
//  Created by 허학철 on 7/9/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import Foundation
import RealmSwift

final class SnoreListRealm: Object {
  let items = List<SnoreRealm>()
}

public final class SnoreRealm: Object {
  @objc dynamic public var time : String = ""

}
