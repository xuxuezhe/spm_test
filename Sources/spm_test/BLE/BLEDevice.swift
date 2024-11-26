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
   public var peripheral: CBPeripheral?
//  var device: CBPeripheral?
    public var write: CBCharacteristic?
    public var read: CBCharacteristic?
    public var battery: Int?
    public var mode: String?
  
    public var READ_CHAR = CBUUID(string: "3a95e1b8-d1a2-4876-8335-02108039b3a2")
    public var WRITE_CHAR = CBUUID(string: "3a95e1b9-d1a2-4876-8335-02108039b3a2")

 
}
