//
//  AES128Helper.swift
//  sumirang
//
//  Created by 허학철 on 2/28/24.
//  Copyright © 2024 rocateer. All rights reserved.
//

import Foundation
import CryptoSwift

public struct AES128Helper {
    private init() {}
    static let shared = AES128Helper()
    private static let SECRET_KEY : Array<UInt8> = Array([0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c])
    private static let IV : Array<UInt8> = Array([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f])
    private static let PREFIX : Array<UInt8> = Array([0xfe, 0x9b, 0x80, 0x03])
    private static var isExcrype : Bool = false
    public static var isAESDevice = ""
    
    func encryptAES128(inputData: Array<UInt8>) -> Array<UInt8> {
          do {
              if(AES128Helper.isExcrype) {
                  let aes = try AES(key: AES128Helper.SECRET_KEY, blockMode: CBC(iv: AES128Helper.IV), padding: .noPadding)

                  var tempArray = Array(repeating: UInt8(0), count: 16)
                  let _ = inputData.enumerated().map { (index , data) in
                      tempArray[index] = data
                  }
                  
                  let encryptedBytes = try aes.encrypt(tempArray)
                  return encryptedBytes
              }else {
                  return inputData
              }
              
          }catch{
              
          }
          return []
      }
    
     func decryptAES128(inputData: Data) -> Data? {
        do {
            let isExcrype = Data(inputData.bytes.prefix(4)).toHexString() != Data(AES128Helper.PREFIX).toHexString()
            AES128Helper.isExcrype = isExcrype
//            log.debug("decryptAES128 -> Data(inputData.bytes.prefix(4)).toHexString(): \(Data(inputData.bytes.prefix(4)).toHexString())")
//            log.debug("decryptAES128 -> Data(AES128Helper.PREFIX).toHexString(): \(Data(AES128Helper.PREFIX).toHexString())")
            if (isExcrype) {
                AES128Helper.isAESDevice = "YES"
                let aes = try AES(key: AES128Helper.SECRET_KEY, blockMode: CBC(iv: AES128Helper.IV), padding: .noPadding)
                let encryptedBytes = try aes.decrypt(inputData.bytes)
                return Data(encryptedBytes)
            }else{
                AES128Helper.isAESDevice = "NO"
                return Data(inputData)
            }
            
        }catch{
//            log.error(error)
        }
        return nil
    }
}
