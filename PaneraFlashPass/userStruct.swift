//
//  userStruct.swift
//  PaneraFlashPass
//
//  Created by Jacob Woods on 11/5/21.
//

import Foundation

struct User{
    var name: String
    var id: String
    var favs: [String]
    var history:[String]
    var boardPref: String
    var prefrences:[Int] = []
}


struct UserInfo: Codable
{
    struct DataInfo: Codable
    {
        let id: String
        let name: String
    }
    let data: [DataInfo]
}


struct orderInfo:Codable{
    
    let message:String
    
    struct DataInfo:Codable{
        //let itemId:String
        let name:String
        let price:String
    
    }
    let data:[DataInfo]
    
}
