//
//  BookMarkService.swift
//  BitBrowser
//
//  Created by ws on 2021/6/21.
//

import Moya
import ObjectMapper

class BookmarkService {
    static func getFavourtites(callBack: @escaping(Bool, Bookmark?, Error?)->Void){
        var usr_id:String = ""
        if let dataStored = UserDefaults.standard.object(forKey: "user_Auth") as? Data {
            let data = try! decoder.decode(userAuth.self, from: dataStored)
            usr_id = data.userId
        } //后续从本地存储中获取
        UserApiProvider.request(.getFavourites(usr_id: usr_id)){ result in
            switch result{
            case let .success(response):
                let data = Mapper<Bookmark>().map(JSONObject: response.json)
                callBack(true, data, nil)
            case let .failure(error):
                print(error)
                callBack(false, nil, error)
            }
        }
    }
}
