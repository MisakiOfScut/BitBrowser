//
//  GeneralResp.swift
//  BitBrowser
//
//  Created by ws on 2021/6/7.
//

import Foundation
import ObjectMapper

class GeneralResp: Mappable {
    var success: Bool?
    var msg: String?
    var id: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        msg <- map["msg"]
        id <- map["id"]
    }
}
