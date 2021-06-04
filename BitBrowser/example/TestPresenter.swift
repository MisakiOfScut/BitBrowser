//
//  TestPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//

import Foundation

class TestPresenter{
    //let view = xxxViewController
    
    func fetchData(){
        TestNewsService.getNews(){ (success: Bool, News:TestNews?, error: Error?) in
            if success{
                if let news = News, !news.list!.isEmpty{
                    print(news)
                }else{
                    print("empty")
                }
            }else if let err = error{
                    print(err)
            }
        }
    }
}
