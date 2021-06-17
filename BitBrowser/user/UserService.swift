//
//  UserService.swift
//  BitBrowser
//
//  Created by ws on 2021/6/7.
//

import Foundation
import Moya
import ObjectMapper

class UserService{
    static func login(username: String, password: String, callback: @escaping(Bool, GeneralResp?, Error?)->Void){
        UserApiProvider.request(UserApiService.login(username: username, password: password)){ result in
            switch result{
            case let .success(response):
                let data = Mapper<GeneralResp>().map(JSONObject: response.json)
                print(data?.msg)
                callback(response.success, data, nil)
            case let .failure(error):
                print(error)
                callback(false, nil, error)
            }
        }
    }
    
    static func register(username: String, password: String, email: String, vaildCode: String, callback: @escaping(Bool, GeneralResp?, Error?)->Void){
        UserApiProvider.request(UserApiService.register(username: username, password: password, email: email, vaildCode: vaildCode)){ result in
            switch result{
            case let .success(response):
                //print(response.json)
                let data = Mapper<GeneralResp>().map(JSONObject: response.json)
                //print(data?.msg)
                callback(response.success, data, nil)
            case let .failure(error):
                print(error)
                callback(false, nil, error)
            }
        }
    }
    
    static func sendMail(email: String, callback: @escaping(Bool, GeneralResp?, Error?)->Void){
        UserApiProvider.request(.sendMail(email: email)){ result in
            switch result{
            case let .success(response):
                //print(response.json)
                let data = Mapper<GeneralResp>().map(JSONObject: response.json)
                print(data?.msg)
                callback(response.success, data, nil)
            case let .failure(error):
                print(error)
                callback(false, nil, error)
            }
        }
    }
    
    static func verifyCode(email: String, vaildCode:String, callback: @escaping(Bool, GeneralResp?, Error?)->Void){
        UserApiProvider.request(.verifyCode(email: email, validCode: vaildCode)){ result in
            generalCompletion(result: result, callback: callback)
        }
    }
    
    
    static func generalCompletion(result: Result<Response, MoyaError>, callback: @escaping(Bool, GeneralResp?, Error?)->Void){
        switch result{
        case let .success(response):
            //print(response.json)
            let data = Mapper<GeneralResp>().map(JSONObject: response.json)
            print(data?.msg)
            callback(response.success, data, nil)
        case let .failure(error):
            print(error)
            callback(false, nil, error)
        }
    }
}
