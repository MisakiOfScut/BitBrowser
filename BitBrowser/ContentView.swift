 //
//  ContentView.swift
//  BitBrowser
//
//  Created by ws on 2021/6/2.
//

import SwiftUI

 /// 一个单例
// var data = DataClass()
// class DataClass : ObservableObject{
//     @Published var isFavorite : Bool = false
//     func toggle(){
//        isFavorite = !isFavorite
//        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "isFavorite_change"), object: self, userInfo: ["isFavorite":isFavorite])
//     }
// }
 class Isfav: ObservableObject {
    @Published var isfav: Bool
//    @EnvironmentObject var bookmarkController : BookmarkController
    init() {
        self.isfav = false
    }
    func toggle() {
        self.isfav.toggle()
    }
    func getisfav() -> Bool{
        return self.isfav
    }
    func setisfav(val: Bool) {
        self.isfav = val
    }
    func setisfav(url: String){
        self.isfav = BookmarkController.bookmarkController.getIsRemove(url: url)
    }
 }
 var isfav = Isfav()
 
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
//    @State var isFavorite = false
//    let pub = NotificationCenter.default.publisher(for: Notification.Name.init(rawValue: "isFavorite_change"))
    
//    static var web:Web = Web(url: "https://www.baidu.com")
    var url: String
//    @ObservedObject var web: Web = Web(url: "http://www.bilibili.com")
    @State var showModal = false;
//    static var web: Web = Web()
    let web: Web
    init(url: String) {
        self.url = url
        web = Web(url: url)
    }
//    @State var isFavorite: Bool = false
//    @ObservedObject var bookmarkController : BookmarkController = BookmarkController()
//    @ObservedObject var isfav: Isfav = Isfav()
    
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    VStack(spacing: 0) {
                        SearchView()
                        self.web.webview
                            .frame(minHeight: 0, maxHeight: .infinity)
                    }
//                    .edgesIgnoringSafeArea(.top)
                    InfoModalView()
                        .offset(x: 0, y: showModal ? geometry.size.height - 224 : geometry.size.height)
                        .animation(.linear)
                    BottomTabView(showModal: self.$showModal)
//                        .zIndex(1)
                }.navigationBarHidden(true)
            }
            .edgesIgnoringSafeArea(.all)
//            .environmentObject(self.bookmarkController)
            .environmentObject(self.web)
//            .environmentObject(self.isfav)
            .onAppear(perform: {
//                self.bookmarkController.getMarkList()
                print("contentview content的高度")
                print(UIScreen.main.nativeBounds.height)
                print(UIScreen.main.bounds.height)
                print(geometry.size.height)
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(url: "https://www.baidu.com")
//        ContentView()
    }
}
