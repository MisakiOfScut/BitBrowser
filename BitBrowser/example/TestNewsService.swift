//
//  TestNewsService.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//
import RxSwift
import ObjectMapper

class TestNewsService {
    static let bag = DisposeBag()
    static func getNews(){
        TestApiProvider.rx.request(TestApiService.getNews).subscribe{ event in
            switch event{
            case let .success(response):
                if response.statusCode == 200{
                    var json : Any?
                    do{
                        json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    }catch let error as NSError{
                        print(error)
                    }
                    
                    let data = Mapper<TestNews>().map(JSONObject: json)
                    print(data ?? "null")
                    
                    //callback(true, data)
                }else{
                    print("false",response.statusCode, response.description)
                }
            
            case let .error(error):
                print(error)
            }
        }
        .disposed(by: bag)
    }
}
