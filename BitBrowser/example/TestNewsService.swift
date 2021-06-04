//
//  TestNewsService.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//
import ObjectMapper

class TestNewsService {
    static func getNews(callback: @escaping(Bool, TestNews?, Error?)->Void){
        TestApiProvider.request(TestApiService.getNews){ result in
            switch result{
            case let .success(response):
                if response.success{
                    let data = Mapper<TestNews>().map(JSONObject: response.json)
                    callback(true, data, nil)
                }else{
                    print(response.statusCode, response.description)
                }
            
            case let .failure(error):
                print(error)
                callback(false, nil, error)
            }
        }
    }
}
