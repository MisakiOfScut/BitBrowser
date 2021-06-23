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
        let usr_id = "60bc7ff1b5bf6b007839269c" //后续从本地存储中获取
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
