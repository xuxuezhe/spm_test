//
//  BluetoothManager.swift
//  sumirang
//
//  Created by 허학철 on 4/22/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import CoreBluetooth
//import Defaults
//import StringStylizer


public class BluetoothManager: NSObject {
    static let SERVICE_UUID = CBUUID(string: "3A95E1B9-D1A2-4876-8335-02108039B3A2")
    
//    var is_connected = false
//    
//    let queue = OperationQueue()
//    
//    var viewControllerType = ViewControllerType.Breath
////    var breathViewController: BreathViewController?
////    var snoringViewController: SnoringViewController?
////    var connectDeviceViewController: ConnectDeviceViewController?
//    
//    static let shared = BluetoothManager()
//    
//    var centralManager: CBCentralManager!
//    
//    func parseManufacturerData(_ data: Data) ->String {
//        // 데이터 길이가 2 이상이어야 회사 ID를 포함합니다.
//        guard data.count >= 2 else {
//            print("Manufacturer Data가 너무 짧습니다.")
//            return ""
//        }
//
//        let companyId = data.subdata(in: 0..<2)
//        let companyIdValue = UInt16(companyId[0]) | (UInt16(companyId[1]) << 8)
//
//        if companyIdValue == 0x0059 {
//            print("Nordic Semiconductor ASA 장치입니다.")
//            let customData = data.subdata(in: 2..<data.count)
//            // customData에 대한 추가 분석 수행
//            print("Custom Data: \(customData as NSData)")
//            
//            let hexString = data.map { String(format: "%02x", $0) }.joined()
//            print("Hex String: \(hexString)")
//            
//            let resultString = hexString.suffix(12).uppercased()
////            log.debug(resultString)
//            var mac_address = ""
//            
//            // 문자열을 두 글자씩 순회
//            for (index, char) in resultString.enumerated() {
//                // 현재 인덱스가 짝수일 때 (두 자리마다 ":"를 추가)
//                if index % 2 == 0 && index != 0 {
//                    mac_address.append(":")
//                }
//                mac_address.append(char)
//            }
//            
////            log.debug(mac_address)
//            
//            return mac_address
//        } else {
//            print("다른 제조업체의 장치입니다.")
//            return ""
//        }
//    }
//
//    override init() {
//        super.init()
////        centralManager = CBCentralManager(delegate: self, queue: nil)
//        
//        queue.maxConcurrentOperationCount = 10
//    }
//    
//    func startScan(){
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//    }
//    
//    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
//      var msg = ""
//      switch central.state {
//      case .poweredOff:
//        msg = "블루투스가 꺼져있습니다."
//      case .poweredOn:
////        log.debug("스캔 시작!")
//          centralManager.scanForPeripherals(withServices: [SERVICE_UUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : false])
//      case .unsupported:
//        msg = "지원되지 않습니다."
//      default:
//        msg = "알 수 없는 에러가 발생했습니다."
//      }
//      
//      if msg != "" {
////        log.debug(msg)
////        Tools.shared.showToast(message: msg)
//      }
//      
//    }
//    
//    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
////      log.debug("발견 블루투스 : \(peripheral)")
//        
//        if viewControllerType == .ConnectDevice{
//            let name = peripheral.name ?? ""
//
//            guard name.uppercased().hasPrefix("AA") || name.uppercased().hasPrefix("AB") || name.uppercased().hasPrefix("AC") || name.uppercased().hasPrefix("AP") || name.uppercased().hasPrefix("BR") || name.uppercased().hasPrefix("BS") else{ return }
//            
//            let localName = "\(advertisementData["kCBAdvDataLocalName"] ?? "")"
//            
//            var mac_address = ""
//            if let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data {
//                // Manufacturer Data를 처리
//                print("Manufacturer Data: \(manufacturerData)")
//                
//                let manufacturerId = manufacturerData.subdata(in: 0..<2)
//                let customData = manufacturerData.subdata(in: 2..<manufacturerData.count)
//                
//                mac_address = parseManufacturerData(manufacturerData)
//            }
//            
////            self.connectDeviceViewController!.deviceList.append((peripheral: peripheral, localName: localName, macAddress: mac_address))
////            self.connectDeviceViewController!.deviceTableView.reloadData()
////    
////            self.connectDeviceViewController!.animationView.stop()
////            self.connectDeviceViewController!.lottieView.isHidden = true
//            
//            
////            if Defaults[.device_address] == peripheral.identifier.uuidString {
////              log.debug("블루투스 찾기 성공!")
////                log.debug("RSSI: \(RSSI)")
//                
////                Tools.shared.firestoreWriteData(data: ["ConnectVC", "didDiscover", "블루투스 찾기 성공!"]) //, "RSSI: \(RSSI)"])
//                
////                Defaults[.device_name] = localName
////                Defaults[.device_address] = peripheral.identifier.uuidString
//            
//            
//                BLEDevice.shared.peripheral = peripheral
//                self.centralManager.stopScan()
//                self.centralManager.connect(peripheral, options: nil)
////            }
//        }
////        else if viewControllerType == .Breath{
////            Tools.shared.firestoreWriteData(data: ["BreathVC", "didDiscover", "발견 블루투스"])
////
////            log.debug("발견 블루투스 : \(peripheral)")
////            if Defaults[.device_address] == peripheral.identifier.uuidString {
////                log.debug("블루투스 찾기 성공!")
//////                log.debug("RSSI: \(RSSI)")
////                
////                Tools.shared.firestoreWriteData(data: ["BreathVC", "didDiscover", "블루투스 찾기 성공!"]) //, "RSSI: \(RSSI)"])
////                
////                self.breathViewController?.bleImageView.image = UIImage(named: "connect_ing")
////                self.breathViewController?.bleStatusLabel.text = NSLocalizedString("Connecting", comment: "")
////                
////                let name = "\(Defaults[.name] ?? "")".stylize().color(.white).attr
////                let info = NSLocalizedString("PressStart", comment: "").stylize().color(UIColor(named: "FFFFFF")!).attr
////                  let breath = NSLocalizedString("RespirationMessage", comment: "").stylize().color(.white).font(UIFont.nanumsquareneo(size: 24, family: .Bold)).attr
////                  let info2 = NSLocalizedString("Measurement", comment: "").stylize().color(UIColor(named: "FFFFFF")!).attr
////                self.breathViewController?.noDataLabel.attributedText = name + info + breath + info2
////                self.breathViewController?.startButton.setImage(UIImage(named: "btn_start"), for: .normal)
////                
////                BLEDevice.shared.peripheral = peripheral
////                self.centralManager.stopScan()
////                
////                self.centralManager.connect(peripheral, options: nil)
////            }
////        }
////        else if viewControllerType == .Snoring{
////            Tools.shared.firestoreWriteData(data: ["SnoreVC", "didDiscover", "발견 블루투스"])
////             
////              
////            if Defaults[.device_address] == peripheral.identifier.uuidString {
////              log.debug("블루투스 찾기 성공!")
//////                log.debug("RSSI: \(RSSI)")
////                
////                Tools.shared.firestoreWriteData(data: ["SnoreVC", "didDiscover", "블루투스 찾기 성공!"])//, "RSSI: \(RSSI)"])
////                
////                self.snoringViewController?.bleImageView.image = UIImage(named: "connect_ing")
////                self.snoringViewController?.bleStatusLabel.text = "연결중"
////                
////                let name = "\(Defaults[.name] ?? "")".stylize().color(.white).attr
////                  let info = NSLocalizedString("PressStart", comment: "").stylize().color(UIColor(named: "FFFFFF")!).attr
////                    let breath = NSLocalizedString("SnoringMessage", comment: "").stylize().color(.white).font(UIFont.nanumsquareneo(size: 24, family: .Bold)).attr
////                    let info2 = NSLocalizedString("Measurement2", comment: "").stylize().color(UIColor(named: "FFFFFF")!).attr
////                self.snoringViewController?.noDataLabel.attributedText = name + info + breath + info2
////                self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_start"), for: .normal)
////                
////                BLEDevice.shared.peripheral = peripheral
////                self.centralManager.stopScan()
////
////                self.centralManager.connect(BLEDevice.shared.peripheral!, options: nil)
////            }
////        }
//    }
//    
//    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        self.is_connected = true
//        
////      log.debug("연결 성공")
//      BLEDevice.shared.peripheral = peripheral
////      peripheral.delegate = self
//      peripheral.discoverServices(nil)
//
////        peripheral.readRSSI()
//        
////        if viewControllerType == .Breath{
////            Tools.shared.firestoreWriteData(data: ["BreathVC", "didConnect", "연결 성공"])
////        }
////        else if viewControllerType == .Snoring{
////            Tools.shared.firestoreWriteData(data: ["SnoreVC", "didConnect", "연결 성공"])
////        }
//    }
//    
//    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        self.is_connected = false
//        
////      log.error("연결 끊김")
//    
//        if let error = error {
////            log.error("\(error.localizedDescription)")
////            Tools.shared.showToast(message: NSLocalizedString("SensorUnstable", comment: ""))
//            
////            Tools.shared.firestoreWriteData(data: ["didDisconnectPeripheral", "\(error.localizedDescription)"])
//            
////            if viewControllerType == .Breath{
////                Tools.shared.firestoreWriteData(data: ["BreathVC", "didDisconnectPeripheral", "연결 끊김"])
////                
////                BLEDevice.shared.peripheral = nil
////                
////                self.breathViewController?.batteryImageView.image = UIImage(named: "ic_battery")
////                self.breathViewController?.batteryView.isHidden = true
////                self.breathViewController?.bleImageView.image = UIImage(named: "not_connect")
////                self.breathViewController?.bleStatusLabel.text = "연결끊김"
////                
////                let name = "\(Defaults[.name] ?? "")님".stylize().color(.white).attr
////                let info = "\n숨이랑 기기와 연결이\n필요합니다.".stylize().color(UIColor(named: "FFFFFF")!).attr
////                let info2 = "\n연결버튼을 눌러 기기와\n연결해 주세요.".stylize().color(UIColor(named: "FFFFFF")!).attr
////                self.breathViewController?.noDataLabel.attributedText = name + info + info2
////                self.breathViewController?.startButton.setImage(UIImage(named: "btn_connect"), for: .normal)
////                
////                self.snoringViewController?.batteryImageView.image = UIImage(named: "ic_battery")
////                self.snoringViewController?.batteryView.isHidden = true
////                self.snoringViewController?.bleImageView.image = UIImage(named: "not_connect")
////                self.snoringViewController?.bleStatusLabel.text = "연결끊김"
////                
////                self.snoringViewController?.noDataLabel.attributedText = name + info + info2
////                if self.snoringViewController?.snoringStatus == .Measuring || self.snoringViewController?.snoringStatus == .Analyze{
////                    self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_end"), for: .normal)
////                }
////                else{
////                    if BLEDevice.shared.peripheral == nil {
////                        self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_connect"), for: .normal)
////                    }
////                    else{
////                        self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_start"), for: .normal)
////                    }
////                }
////            }
////            else if viewControllerType == .Snoring{
////                Tools.shared.firestoreWriteData(data: ["SnoreVC", "didDisconnectPeripheral", "연결 끊김"])
////                
////                BLEDevice.shared.peripheral = nil
////                
////                self.breathViewController?.batteryImageView.image = UIImage(named: "ic_battery")
////                self.breathViewController?.batteryView.isHidden = true
////                self.breathViewController?.bleImageView.image = UIImage(named: "not_connect")
////                self.breathViewController?.bleStatusLabel.text = "연결끊김"
////                
////                let name = "\(Defaults[.name] ?? "")님".stylize().color(.white).attr
////                let info = "\n숨이랑 기기와 연결이\n필요합니다.".stylize().color(UIColor(named: "FFFFFF")!).attr
////                let info2 = "\n연결버튼을 눌러 기기와\n연결해 주세요.".stylize().color(UIColor(named: "FFFFFF")!).attr
////                self.breathViewController?.noDataLabel.attributedText = name + info + info2
////                self.breathViewController?.startButton.setImage(UIImage(named: "btn_connect"), for: .normal)
////                
////                self.snoringViewController?.batteryImageView.image = UIImage(named: "ic_battery")
////                self.snoringViewController?.batteryView.isHidden = true
////                self.snoringViewController?.bleImageView.image = UIImage(named: "not_connect")
////                self.snoringViewController?.bleStatusLabel.text = "연결끊김"
////                
////                self.snoringViewController?.noDataLabel.attributedText = name + info + info2
////                if self.snoringViewController?.snoringStatus == .Measuring || self.snoringViewController?.snoringStatus == .Analyze{
////                    self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_end"), for: .normal)
////                }
////                else{
////                    if BLEDevice.shared.peripheral == nil {
////                        self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_connect"), for: .normal)
////                    }
////                    else{
////                        self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_start"), for: .normal)
////                    }
////                }
////            }
////            else if viewControllerType == .ConnectDevice{
////                Tools.shared.firestoreWriteData(data: ["ConnectVC", "didDisconnectPeripheral", "연결 끊김"])
////                
////                BLEDevice.shared.peripheral = nil
////                
////                self.breathViewController?.batteryImageView.image = UIImage(named: "ic_battery")
////                self.breathViewController?.batteryView.isHidden = true
////                self.breathViewController?.bleImageView.image = UIImage(named: "not_connect")
////                self.breathViewController?.bleStatusLabel.text = "연결끊김"
////                
////                let name = "\(Defaults[.name] ?? "")님".stylize().color(.white).attr
////                let info = "\n숨이랑 기기와 연결이\n필요합니다.".stylize().color(UIColor(named: "FFFFFF")!).attr
////                let info2 = "\n연결버튼을 눌러 기기와\n연결해 주세요.".stylize().color(UIColor(named: "FFFFFF")!).attr
////                self.breathViewController?.noDataLabel.attributedText = name + info + info2
////                self.breathViewController?.startButton.setImage(UIImage(named: "btn_connect"), for: .normal)
////                
////                self.snoringViewController?.batteryImageView.image = UIImage(named: "ic_battery")
////                self.snoringViewController?.batteryView.isHidden = true
////                self.snoringViewController?.bleImageView.image = UIImage(named: "not_connect")
////                self.snoringViewController?.bleStatusLabel.text = "연결끊김"
////                
////                self.snoringViewController?.noDataLabel.attributedText = name + info + info2
////                if self.snoringViewController?.snoringStatus == .Measuring || self.snoringViewController?.snoringStatus == .Analyze{
////                    self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_end"), for: .normal)
////                }
////                else{
////                    if BLEDevice.shared.peripheral == nil {
////                        self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_connect"), for: .normal)
////                    }
////                    else{
////                        self.snoringViewController?.bottomButton.setImage(UIImage(named: "btn_start"), for: .normal)
////                    }
////                }
////            }
//             
//              central.connect(peripheral, options: nil)
//        }
//    }
}

extension BluetoothManager: CBPeripheralDelegate {
  public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//    print("Services:\(String(describing: peripheral.services)) and error\(String(describing: error))")
    if let services = peripheral.services {
      for service in services {
        peripheral.discoverCharacteristics(nil, for: service)
      }
    }
  }
  
  public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//    log.debug("didDiscoverCharacteristics --  peripheral:\(peripheral) and service:\(service)")
    
    for characteristic in service.characteristics! {
      if characteristic.uuid.uuidString == BLEDevice.shared.WRITE_CHAR.uuidString {
        BLEDevice.shared.write = characteristic
      }
      
      if characteristic.uuid.uuidString == BLEDevice.shared.READ_CHAR.uuidString {
        BLEDevice.shared.read = characteristic
      }
    }
    
      BLEDevice.shared.peripheral?.delegate = self
      BLEDevice.shared.peripheral?.setNotifyValue(true, for: BLEDevice.shared.read!)
      
      
//      if Defaults[.is_forcefully_stop_breath] == "Y"{
//        //강제종료후 stop 커멘드
//        let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xF3, 0x01, 0x00]
//        BLECommand_temp.shared.write(byteArray: byteArray)
//          
//          Defaults[.is_forcefully_stop_breath] = "N"
//      }
//      
//      if Defaults[.is_forcefully_stop_snore] == "Y"{
//        //강제종료후 stop 커멘드
//        let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xFE, 0x01, 0x00]
//        BLECommand_temp.shared.write(byteArray: byteArray)
//          
//          Defaults[.is_forcefully_stop_snore] = "N"
//      }
      
      let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xE1, 0x00]
      BLECommand.shared.write(byteArray: byteArray)
      
//      if viewControllerType == .Breath{
          
//          self.breathViewController!.connectCount += 1;
          
//          if self.breathViewController!.connectCount % 2 == 1{// 두번 호출 방지
//              guard BLEDevice.shared.mode == "Breath" else { return }
//              
//              BLECommand.shared.isGetedMemoryData = false
//              // 재연결 메모리 데이터 전송 요청
//              let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xF5, 0x00]
//              BLECommand.shared.write(byteArray: byteArray)
//            
//              Tools.shared.firestoreWriteData(data: ["BreathVC", "Characteristics", "메모리 데이터 요청"])
//          }
//      }
//      else if viewControllerType == .Snoring{
//          
//          self.snoringViewController!.connectCount += 1;
//
//          if self.snoringViewController!.connectCount % 2 == 1{// 두번 호출 방지
//              guard BLEDevice.shared.mode == "Snoring" else { return }
//              
//              BLECommand.shared.isGetedMemoryData = false
//              // 재연결 메모리 데이터 전송 요청
//              let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xF5, 0x00]
//              BLECommand.shared.write(byteArray: byteArray)
//              
//              Tools.shared.firestoreWriteData(data: ["SnoreVC", "Characteristics", "메모리 데이터 요청"])
//          }
//      }
  }

   public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        
//        queue.addOperation {
            do {
              try BLECommand.shared.read(data: characteristic.value ?? Data())
            } catch {
//              log.error(error)
            }
//        }
        
    }
    
    // 블루투스 기기의 신호 강도를 요청하는 peripheral.readRSSI()가 호출하는 함수입니다.
//    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
//        // 신호 강도와 관련된 코드를 작성합니다.(필요하다면 작성해주세요.)
//        log.debug("didReadRSSI: \(RSSI)")
//        Tools.shared.firestoreWriteData(data: ["didReadRSSI", "\(RSSI)"])
//    }
}
