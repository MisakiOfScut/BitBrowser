//
//  TestUIView.swift
//  BitBrowser
//
//  Created by Wu Weisong on 2021/6/7.
//

import SwiftUI



struct TestUIView: View {
    @ObservedObject var testPresenter:TestPresenter = TestPresenter()
    
    var body: some View {
        VStack{
            Text(testPresenter.news?.list?[0].title ?? "")
            Text(testPresenter.news?.list?[0].comments ?? "")
        }.onAppear(perform: {
            testPresenter.fetchData()
        })
        
    }
}

struct TestUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestUIView()
    }
}
