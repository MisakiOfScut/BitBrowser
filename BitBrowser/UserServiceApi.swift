//
//  UserServiceApi.swift
//  BitBrowser
//
//  Created by ws on 2021/6/7.
//

import Foundation
import Moya

let UserApiProvider = MoyaProvider<UserApiService>()

enum UserApiService{
    case login(username: String, password: String)
    case register(username: String, password: String, email: String, vaildCode: String)
    case sendMail(email: String)
    case verifyCode(email:String, validCode: String)
    case getFavourites(usr_id: String)
}

struct UserApiConstant{
    static let userBaseURL = "https://qcptpq.fn.thelarkcloud.com"
}

extension UserApiService: TargetType{
    var baseURL: URL {
        return URL(string: UserApiConstant.userBaseURL)!
    }
    
    var path: String {
        switch self{
        case .login:
            return "/login"
        case .register:
            return "/register"
        case .sendMail:
            return "/emailService"
        case .verifyCode:
            return "/verifyCode"
        case .getFavourites:
            return "/getFavourites"
        }
        
    }
    
    var method: Moya.Method {
        switch self{
        default:
            return .post
        }
    }
    
    //设置请求参数（body中的key-value对）
    var parameters : [String:Any]? {
        switch self {
        case .register(let username, let password, let email, let validCode):
            return [
                "username": username,
                "password" : password,
                "email" : email,
                "validCode" : validCode
            ]
            
        case .login(let username, let password):
            return [
                "username": username,
                "password" : password
            ]
            
        case .sendMail(let email):
            return ["email" : email]
            
        case .verifyCode(let email, let validCode):
            return [
                "eamil": email,
                "validCode": validCode
            ]
        case .getFavourites(let usr_id):
            return [
                "usr_id": usr_id
            ]
        //default: return nil
        }
    }
    //请求参数编码
    var parametersEncoding : Moya.ParameterEncoding{
        switch self {
            //return URLEncoding.default//GET
        default:
            return JSONEncoding.default //POST
        }
    }
    
    var task: Task {
        if let reqParameters = parameters{
            //A requests body set with encoded parameters.
            return .requestParameters(parameters: reqParameters, encoding: parametersEncoding)
        }
        return .requestPlain //A request with no additional data.
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
