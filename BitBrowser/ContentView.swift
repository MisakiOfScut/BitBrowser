 //
//  ContentView.swift
//  BitBrowser
//
//  Created by ws on 2021/6/2.
//

import SwiftUI

let tp = TestPresenter()
 
 class Web: ObservableObject {
//    @Published var webview = WebView(web: nil, req: URLRequest(url: URL(string: "https://www.baidu.com")!))
    @Published var webview: WebView
    
    init() {
        self.webview = WebView(web: nil, req: URLRequest(url: URL(string: "https://www.baidu.com")!))
    }
    init(url: String) {
        self.webview = WebView(web: nil, req: URLRequest(url: URL(string: url)!))
    }
 }

struct ContentView: View {
    var url: String
//    @ObservedObject var web: Web = Web(url: "http://www.bilibili.com")
    @State var showModal = false;
    let web: Web
//    @Binding var web: Web
    init(url: String) {
        self.url = url
        web = Web(url: url)
    }
    
//    @ObservedObject var BookmarkData: Bookmark = Bookmark(data: [Mark(title: "百度一下，你就知道", webUrl: "https://www.baidu.com"),Mark(title: "搜狐新闻", webUrl: "https://www.sohu.com"),Mark(title: "哔哩哔哩，干杯🍻", webUrl: "https://www.bilibili.com")])
    @ObservedObject var bookMarkPresenter : BookMarkPresenter = BookMarkPresenter()
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    VStack(spacing: 0) {
                        SearchView().environmentObject(self.bookMarkPresenter)
                        web.webview.frame(minHeight: 0, maxHeight: .infinity)
                    }
//                    .edgesIgnoringSafeArea(.top)
                    InfoModalView()
                        .offset(x: 0, y: showModal ? geometry.size.height - 236 : geometry.size.height)
                        .animation(.spring())
                    BottomTabView(showModal: self.$showModal)
//                        .zIndex(1)
                }.navigationBarHidden(true)
            }
            .edgesIgnoringSafeArea(.top)
            .environmentObject(web)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(url: "https://www.baidu.com")
    }
}
