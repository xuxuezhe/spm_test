//
//  BLEDevice.swift
//  sumirang
//
//  Created by rocateer on 10/10/23.
//  Copyright © 2023 rocateer. All rights reserved.
//

import Foundation
import CoreBluetooth

public class BLEDevice {
    public init(){}
  public static let shared = BLEDevice()
  
//  var manager: CBCentralManager?
    var peripheral: CBPeripheral?
//  var device: CBPeripheral?
  var write: CBCharacteristic?
  var read: CBCharacteristic?
  var battery: Int?
  var mode: String?
  
  var READ_CHAR = CBUUID(string: "3a95e1b8-d1a2-4876-8335-02108039b3a2")
  var WRITE_CHAR = CBUUID(string: "3a95e1b9-d1a2-4876-8335-02108039b3a2")

 
}
