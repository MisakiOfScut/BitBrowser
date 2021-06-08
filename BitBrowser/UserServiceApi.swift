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
    case register(username: String, password: String)
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
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .login,
             .register:
            return .post
        }
    }
    
    //设置请求参数（body中的key-value对）
    var parameters : [String:Any]? {
        switch self {
        case .register(let username, let password):
            return [
                "username": username,
                "password" : password
            ]
        case .login(let username, let password):
            return [
                "username": username,
                "password" : password
            ]
        //default: return nil
        }
    }
    //请求参数编码
    var parametersEncoding : Moya.ParameterEncoding{
        switch self {
        case .login,
             .register:
            return JSONEncoding.default //POST
        default:
            return URLEncoding.default//GET
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
