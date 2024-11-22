//
//  File.swift
//  
//
//  Created by 허학철 on 11/21/24.
//

import Foundation
import Alamofire
import RealmSwift

public class spm_test1{
    private init(){}
    
    public static func test1(){
        print("test1")
        let realm = try! Realm()
        print(AF.session)
    }
}
