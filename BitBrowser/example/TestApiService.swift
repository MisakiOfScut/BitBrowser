//
//  TestApiService.swift
//  BitBrowser
//
//  Created by ws on 2021/6/3.
//

import Foundation
import Moya

let TestApiProvider = MoyaProvider<TestApiService>()
struct TestApiConstant{
    static let baseURL = "https://www.fastmock.site"
}


enum TestApiService {
    case getNews
    case whatever//use default
}

extension TestApiService : TargetType{
    //请求基本路径
    var baseURL: URL {
        return URL(string: TestApiConstant.baseURL)!
    }
    //请求路径
    var path: String {
        switch self {
        case .getNews:
            return "/mock/695caa6c3051ac0123a077cb52a9d85d/api/news"
        //case .getUser(let username): return "/users/\(username)"
        default:
            return ""
        }
    }
    //请求属于GET OR POST
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        default:
            return .get
        }
    }
    //设置请求参数（body中的key-value对）
    var parameters : [String:Any]? {
        switch self {
            case .getNews:
                return nil
        default:
            return nil
        }
    }
    //请求参数编码
    var parametersEncoding : Moya.ParameterEncoding{
        switch self {
        case .getNews:
            return URLEncoding.default //GET
            //return JSONEncoding.default //POST
        default:
            return URLEncoding.default
        }
    }
    //设置request body
    var task: Task {
        if let reqParameters = parameters{
            //A requests body set with encoded parameters.
            return .requestParameters(parameters: reqParameters, encoding: parametersEncoding)
        }
        return .requestPlain //A request with no additional data.
    }
    //设置请求头
    var headers: [String : String]? {
        switch self {
            case .getNews:
                return [
                    "Accept" : "application/json, */*",
                    "Content-Type": "application/json"
                ]
        default:
            return nil
        }
    }
    //测试用
    var sampleData: Data {
        switch self {
        case .getNews:
            return
        """
        {
            "list": [
              {
                "title": "良心跑哪兒去了？任涛剛支援大批物資，周伟就翻臉抹黑",
                "source": "人民資訊",
                "time": "2006-05-27 05:55:09",
                "comments": "412評論",
                "contents": "正文：观但革层北毛干千切切取备及合验族选。想近体物万算四素回江民后公。公万几比状二来平下度地少清越把始。",
                "images": [
                  "https://th.bing.com/th/id/R5b1e644f98a8ff671d0dc2667984b965?rik=0qchgsAFHDYM2Q&amp;riu=http%3a%2f%2fwww.leitingw.com%2fuploads%2fallimg%2f200529%2f1321105A1-0.jpg&amp;ehk=KbhTD157OIjNyBCKXsQMzJ%2bjykdgGT26hJ%2f%2bCVbfP1I%3d&amp;risl=&amp;pid=ImgRaw",
                  "https://e0.ifengimg.com/12/2019/0114/669C50F456E855C16719528893463EEFC4588B1B_size638_w1024_h671.jpeg",
                  "https://himg2.huanqiucdn.cn/attachment2010/2014/0514/20140514064027157.jpg"
                ]
              }
          }
        """.data(using: String.Encoding.utf8)!
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
}
