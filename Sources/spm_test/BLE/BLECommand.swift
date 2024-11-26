//
//  BLEREAD.swift
//  sumirang
//
//  Created by rocateer on 10/11/23.
//  Copyright © 2023 rocateer. All rights reserved.
//

import Foundation
import CoreBluetooth
import RealmSwift
//import NVActivityIndicatorView
//import Defaults


enum BLECommandException: Error {
  case CHECKSUM_EXCEPTION
}

public protocol BLECommandDelegate {
  func onMessage() // 데이터 정상 수신
  
  func onValueResult(index: Double, value: Double) // 데이터 결과
}

protocol FirmwareVersionDelegate {
    func onValueResult(value: String) // 데이터 결과
}


public class BLECommand {
  public static let shared = BLECommand()
  
  var commandDelegate: BLECommandDelegate?
    var firmwareVersionDelegate :FirmwareVersionDelegate?
    var firmwareVersion: String = ""
    var isGetedMemoryData = true
    
  /// 체크썸 계산
  /// - Parameter data: 검사
  /// - Returns: 결과
  func checkSumCal(data : [UInt8]) -> UInt8 {
    var sum1 : UInt16 = 0
    for i in 0..<data.count {
      sum1 += UInt16(data[i])
    }
    let sum2 = ((sum1 >> 8) & 0xFF) + (sum1 & 0xFF)
    let sum3 = ((sum2 >> 8) & 0xFF) + (sum2 & 0xFF)
    let checksum = UInt8(~UInt8(sum3)) // 결과: 170
    return checksum
  }
  
  
  /// 메세지 전달 (앱 -> 기기)
  /// - Parameter byteArray: 데이터
  public func write(byteArray: [UInt8]) {
    var byteArray = byteArray
    let checkSum = BLECommand.shared.checkSumCal(data: byteArray)
    byteArray.append(checkSum)
    let data = Data(byteArray) // 메세지 수신 응답 메세지
      
      //0xxx
//      var temp = ""
//      for uint8 in byteArray{
//          temp = temp + ", 0x\(String(format: "%02x", uint8))"
//      }
//      print("-------------->" + temp)
      
      BLEDevice.shared.peripheral?.writeValue(Data(AES128Helper.shared.encryptAES128(inputData: byteArray)), for: BLEDevice.shared.write!, type: CBCharacteristicWriteType.withoutResponse)
//    BLEDevice.shared.device?.writeValue(data, for: BLEDevice.shared.write!, type: CBCharacteristicWriteType.withoutResponse)
  }
  
  /// 데이터 파싱 (기기 -> 앱)
  /// - Parameter data: 데이터
  public func read(data : Data) throws {
//    let value = Array<UInt8>(data)
      let value = Array<UInt8>(AES128Helper.shared.decryptAES128(inputData: data)!)
      
    let hexString = data.map { String(format: "%02X. ", $0) }.joined()
    
    var byteArray = value
    let checkSum = byteArray.removeLast()
      
      //0xxx
//      var temp = ""
//      for uint8 in value{
//          temp = temp + ", 0x\(String(format: "%02x", uint8))"
//      }
//      print(temp + "<--------------")
      
    // 1. 체크썸 확인
    guard checkSum == self.checkSumCal(data: byteArray) else {
//        log.error("BLECommandException.CHECKSUM_EXCEPTION")
      throw BLECommandException.CHECKSUM_EXCEPTION
    }
    
    // 2. Prefix 체크
    let cmd = value[4]
//    log.debug("recvData : \(hexString) cmd \(String(format: "%02X", cmd))")

    if cmd == 0xFA { // 배터리
      let battery = value[6]
      BLEDevice.shared.battery = Int(battery)
        
//        DispatchQueue.main.async{
//            self.breathViewController?.setBattery()
//            self.snoringViewController?.setBattery()
//        }
    }
      else if cmd == 0xc3, value[6] == 0x01{ //, breathViewController?.breathCMDStatus == BreathCMDStatus.Start{ // 호흡뷰 기기에서 START ACK 받았을때
//          log.debug("호흡 측정시작")
//          breathViewController?.sleepdataCreate()
      }
//      else if cmd == 0xcE, value[6] == 0x13, snoringViewController?.snoringCMDStatus == SnoringCMDStatus.Start{ // 코골이 기기에서 START ACK 받았을때
//          log.debug("코골이 측정시작")
//          snoringViewController?.sleepdataCreate()
//      }
    else if cmd == 0xFD{ //PWR_OFF_NOTIFY
        let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xCD, 0x00]
        write(byteArray: byteArray)
        
//        DispatchQueue.main.async{
//            if self.breathViewController?.breathStatus == .Within_5Minutes || self.breathViewController?.breathStatus == .After_5minutes {
//                Tools.shared.showToast(message: NSLocalizedString("SensorUnstable2", comment: ""))
//                
//                BLEDevice.shared.mode = nil
//                
//                guard self.breathViewController!.time > Constants.shared.measuring_min_time else {
//                 
//                    self.breathViewController?.connectCount = 0
//                    self.breathViewController?.sleepdataDelete(nil)
//                  return
//                }
//                self.breathViewController?.connectCount = 0
//                self.breathViewController?.stopRecord()
//                
//                Tools.shared.firestoreWriteData(data: ["PWR_OFF_NOTIFY"])
//            }
//            if self.snoringViewController?.snoringStatus == .Measuring{
//                Tools.shared.showToast(message: NSLocalizedString("SensorUnstable2", comment: ""))
//                
//                BLEDevice.shared.mode = nil
//                
//                guard self.snoringViewController!.time > Constants.shared.measuring_min_time else {
//                    
//                    self.snoringViewController?.connectCount = 0
//                    self.snoringViewController?.sleepdataDelete(nil)
//                   
//                    return
//                }
//                
//                self.snoringViewController?.connectCount = 0
//                self.snoringViewController?.stopRecord()
//                
//                Tools.shared.firestoreWriteData(data: ["PWR_OFF_NOTIFY"])
//            }
//        }
    }
      else if cmd == 0xD1{ // Firmware Version
//          log.info("Firmware Version: \(value[6]).\(value[7]).\(value[8])")
          let firmwareVersion = "\(value[6]).\(value[7]).\(value[8])"
          self.firmwareVersion = firmwareVersion
          firmwareVersionDelegate?.onValueResult(value: firmwareVersion)
      }
    else if cmd == 0xF2 { // 측정
        self.saveData(dataArray: value, isMemoryData: false)
        self.commandDelegate?.onMessage()
    }
      else if cmd == 0xFF { // POST_STATUS_NOTIFY (0xFF, S/B -> App) 코골이 진동회수 + 1
//          if snoringViewController!.alarmSwitch.isOn{
//              snoringViewController!.runMotorCount += 1
//          }
          let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xCF, 0x00]
          write(byteArray: byteArray)
      }
//      else if cmd == 0xc3, value[6] == 0x00, breathViewController?.breathCMDStatus == BreathCMDStatus.Stop{ // 호흡뷰 기기에서 STOP ACK 받았을때
//          if breathViewController?.breathStatus == .None || breathViewController?.breathStatus == .Result || breathViewController?.breathStatus == .GetData{
//              return
//          }
          
//          breathViewController!.timer_stop_command?.invalidate()
//          breathViewController!.timer_stop_command = nil
//          
//          Tools.shared.firestoreWriteData(data: ["BLECommand", "호흡 STOP ACK 받음"])
//          
//          if breathViewController!.time <= Constants.shared.measuring_min_time{
//
//              BLEDevice.shared.mode = nil
//              breathViewController?.breathCMDStatus = BreathCMDStatus.None
//              
//              breathViewController!.id = nil
//              
//              DispatchQueue.main.async {
//                  self.breathViewController!.sleepdataResult(isShowAlert: false, isFromPush: false)
//              }
//              
//              return
//          }
//          
//          DispatchQueue.main.async{
//              self.breathViewController!.breathStatus = .Analyze
//              self.breathViewController!.setStatus()
//              self.breathViewController!.lottieView.removeSubviews()
//              
//              self.breathViewController?.breathCMDStatus = BreathCMDStatus.None
//              
//              self.breathViewController?.createCSV()
//              
//              BLEDevice.shared.mode = nil
//          }
//      }
//      else if cmd == 0xcE, value[6] == 0x13, snoringViewController?.snoringCMDStatus == SnoringCMDStatus.Stop{ // 코골이 기기에서 STOP ACK 받았을때
//          if snoringViewController?.snoringStatus == .None || snoringViewController?.snoringStatus == .Result || snoringViewController?.snoringStatus == .GetData{
//              return
//          }
//          
//          snoringViewController!.timer_stop_command?.invalidate()
//          snoringViewController!.timer_stop_command = nil
//          
//          Tools.shared.firestoreWriteData(data: ["BLECommand", "코골이 STOP ACK 받음"])
//          
//          if snoringViewController!.time <= Constants.shared.measuring_min_time{
//
//              BLEDevice.shared.mode = nil
//              snoringViewController?.snoringCMDStatus = SnoringCMDStatus.None
//              
//              snoringViewController!.id = nil
//              
//              DispatchQueue.main.async {
//                  self.snoringViewController!.snoredataResult(isShowAlert: false, isFromPush: false)
//              }
//              
//              return
//          }
//          
//          DispatchQueue.main.async {
//              self.snoringViewController!.snoringStatus = .Analyze
//              self.snoringViewController!.setStatus()
//              self.snoringViewController!.lottieView.removeSubviews()
//              
//              self.snoringViewController?.snoringCMDStatus = SnoringCMDStatus.None
//              
//              self.snoringViewController?.createCSV()
//              
//              BLEDevice.shared.mode = nil
//          }
//      }
      else if cmd == 0xF7 { // 메모리 데이터 받음
//          if BluetoothManager.shared.viewControllerType == .Breath{
//              if breathViewController?.breathStatus == .None || breathViewController?.breathStatus == .Result {
//                  DispatchQueue.main.async{
//                      self.breathViewController!.timer_get_data?.invalidate()
//                      self.breathViewController!.timer_get_data = nil
//                      
//                      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//                      
//                      self.breathViewController!.lottieView2.removeSubviews()
//                      self.breathViewController!.breathStatus = .GetData
//                      self.breathViewController!.setStatus()
//                  }
//              }
//          }
//          else if BluetoothManager.shared.viewControllerType == .Snoring{
//              if snoringViewController?.snoringStatus == .None || snoringViewController?.snoringStatus == .Result {
//                  DispatchQueue.main.async{
//                      self.snoringViewController!.timer_get_data?.invalidate()
//                      self.snoringViewController!.timer_get_data = nil
//                      
//                      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//                      
//                      self.snoringViewController!.lottieView2.removeSubviews()
//                      self.snoringViewController!.snoringStatus = .GetData
//                      self.snoringViewController!.setStatus()
//                  }
//              }
//          }
//          
//          self.isGetedMemoryData = true
          
          self.saveData(dataArray: value, isMemoryData: true)
      }
      else if cmd == 0xc5{ // 기기->앱 메모리 데이터 전송완료
          let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xc7, 0x01, 0x00]
          write(byteArray: byteArray)
          
          self.isGetedMemoryData = true
          
//          Tools.shared.firestoreWriteData(data: ["BLECommand", "메모리 데이터 전송완료 C5"])
          
//          if BluetoothManager.shared.viewControllerType == .Breath{
//              if breathViewController?.breathStatus == .None || breathViewController?.breathStatus == .Result || breathViewController?.breathStatus == .GetData{
//                  DispatchQueue.main.async{
//                      
//                      self.breathViewController!.lottieView2.removeSubviews()
//                      
//                      self.breathViewController!.breathStatus = .Analyze
//                      self.breathViewController!.setStatus()
//                      
//                      self.breathViewController?.createCSV()
//                      
//                      BLEDevice.shared.mode = nil
//                      
//                      Tools.shared.firestoreWriteData(data: ["데이터복원, 메모리 데이터 전송완료"])
//                      
////                      let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xF3, 0x01, 0x00]
////                      BLECommand_temp.shared.write(byteArray: byteArray)
//                  }
//              }
//          }
//          else if BluetoothManager.shared.viewControllerType == .Snoring{
//              if snoringViewController?.snoringStatus == .None || snoringViewController?.snoringStatus == .Result || snoringViewController?.snoringStatus == .GetData{
//                  DispatchQueue.main.async{
//                      
//                      self.snoringViewController!.lottieView2.removeSubviews()
//                      
//                      self.snoringViewController!.snoringStatus = .Analyze
//                      self.snoringViewController!.setStatus()
//                      
//                      self.snoringViewController?.createCSV()
//                      
//                      BLEDevice.shared.mode = nil
//                      
//                      Tools.shared.firestoreWriteData(data: ["데이터복원, 메모리 데이터 전송완료"])
//                      
////                      let byteArray: [UInt8] = [0xFE, 0x9B, 0x80, 0x03, 0xF3, 0x01, 0x00]
////                      BLECommand_temp.shared.write(byteArray: byteArray)
//                  }
//              }
//          }
      }
  }
  
  
  /// 데이터 저장
  /// [254, 155, 128, 3, 242, 18, 0,  0,  1, 170, 170, 160, 2, 0, 190, 0,  0,  2, 170, 170, 160, 3, 0, 190]
  /// [254, 155, 128, 3] [242] [18],     [0, 13, 21], [170, 170, 160], [3, 0, 190], [0, 13, 22], [170, 170, 160], [3, 0, 190]
  ///   FE.9B.80.03          F2   12.             00.00.09        AA. AA. A0.        02. 00. BF.     00. 00. 0A    . AA. AA. A0      . 04. 00. BE.     59
  /// PREFIX : FE9B8003
  /// CMD : F2
  /// LEN : 12
  /// DATA : INDEX[3]- Capacitance[3] - X, Y, Z[3] - INDEX[3] - Capacitance[3] -  X, Y, Z[3]
  /// CSUM : -
  /// - Parameter byteArray: 데이터
    func saveData(dataArray: [UInt8], isMemoryData: Bool) {
        
        let count = Int(dataArray[5]) / 9
        
        if isMemoryData{
//            Thread.sleep(forTimeInterval: 0.2)
//            log.debug("메모리 데이터 받은 갯수: \(count)")
//            Tools.shared.firestoreWriteData(data: ["메모리 데이터 받은 갯수: \(count)"])
        }
        
        let realm = try! Realm()
        
        for i in 0..<count {
        
        let vindex = self.getUInt32_3(values: dataArray, arrayIndex: 6 + (i * 9))
        let timeStamp = "" //Date().toString(format: "yyyy-MM-dd HH:mm:ss.SSS")
        let capacitance = self.getUInt32_3(values: dataArray, arrayIndex: 9 + (i * 9))

        var x = Double(dataArray[12 + (i * 9)])
        var y = Double(dataArray[13 + (i * 9)])
        var z = Double(dataArray[14 + (i * 9)])
        
        if x > 128{
            x = x - 256
        }
        if y > 128{
            y = y - 256
        }
        if z > 128 {
            z = z - 256
        }
        
       x = Double(String(format: "%.4f", x * 0.0156)) ?? 0.0
       y = Double(String(format: "%.4f", y * 0.0156)) ?? 0.0
       z = Double(String(format: "%.4f", z * 0.0156)) ?? 0.0
        
//      log.debug("vindex \(vindex) capacitance \(capacitance) x \(x) y \(y) z \(z)")
      self.commandDelegate?.onValueResult(index: Double(vindex), value: Double(capacitance))
            
      let sleepRealm = SleepRealm()
      sleepRealm.index = Int(vindex)
        
//        let existingData = realm.objects(SleepRealm.self).filter { $0.index == sleepRealm.index }.first
//        
//        guard existingData == nil else{ return }
        
      sleepRealm.time = timeStamp
        sleepRealm.capacitance = Int(capacitance)
      sleepRealm.acc_x = x
      sleepRealm.acc_y = y
      sleepRealm.acc_z = z
            
        DispatchQueue.main.async {
            try! realm.write({
      //          log.debug("sleepRealm: \(sleepRealm)")
              realm.add(sleepRealm)
            })
        }
 
//            DispatchQueue.main.async {
//                let realm = try! Realm()
//                realm.writeAsync {
//                    // async하게 처리할 create, delete 작업 등
//                    realm.add(sleepRealm)
//                } onComplete: { error in
//            }
      
//            guard error == nil else {
//                // 에러 핸들링
//            }
            // write 작업이 성공적으로 끝났을 때의 작업
//        }
    }
  }
  
  
  
  private func getUInt32_3(values : [UInt8], arrayIndex : Int) -> UInt32 {
    let returnValue =  UInt32(values[arrayIndex]) << 16  |
    UInt32(values[arrayIndex + 1]) << 8   |
    UInt32(values[arrayIndex + 2])
    return returnValue
  }
  
  private func getUInt32(values : [UInt8], arrayIndex : Int) -> UInt32 {
      let returnValue = UInt32(values[arrayIndex]) << 24      |
      UInt32(values[arrayIndex + 1]) << 16  |
      UInt32(values[arrayIndex + 2]) << 8   |
      UInt32(values[arrayIndex + 3])
      return returnValue
  }
  
  /// 로컬 DB 전체 삭제
  func realmDeleteAllClassObjects() {
    do {
      let realm = try Realm()
      
      let objects = realm.objects(SleepRealm.self)
      
      try! realm.write {
        realm.delete(objects)
      }
    } catch let error as NSError {
//      log.error("error - \(error.localizedDescription)")
    }
  }
}
