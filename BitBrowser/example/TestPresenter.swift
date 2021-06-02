//
//  TestPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//

import SwiftUI
import Combine

class TestPresenter: ObservableObject{
    @Published var news:TestNews?
    
    func clear(){
        news = nil
    }
    
    func fetchData(){
        TestNewsService.getNews(){ (success: Bool, News:TestNews?, error: Error?) in
            if success{
                if let news = News, !news.list!.isEmpty{
                    print(news)
                    self.news = news
                }else{
                    print("empty")
                }
            }else if let err = error{
                    print(err)
            }
        }
    }
}
