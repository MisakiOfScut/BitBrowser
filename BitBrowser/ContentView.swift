 //
//  ContentView.swift
//  BitBrowser
//
//  Created by ws on 2021/6/2.
//

import SwiftUI

 /// 一个单例
 //判断是不是刘海屏
func isiPhoneXScreen() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
}
 func getInfooffset() -> Int {
    if isiPhoneXScreen() {
        return  224 + 34
    } else {
        return  224
    }
 }
 
 
 class Isfav: ObservableObject {
    @Published var isfav: Bool
    init() {
        self.isfav = false
    }
    func getisfav() -> Bool{
        return self.isfav
    }
    func setisfav(val: Bool) {
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "get_isfav"), object: self, userInfo: ["isfav": isfav])
        self.isfav = val
    }
    func setisfav(url: URL){
        self.isfav = BookmarkController.bookmarkController.getIsRemove(url: url)
    }
 }
 var isfav = Isfav()
 
 
 class Web: ObservableObject {
    @Published var webview: WebView
    
    init() {
        self.webview = WebView(web: nil, req: URLRequest(url: URL(string: "https://www.baidu.com")!))
    }
    init(url: String) {
        self.webview = WebView(web: nil, req: URLRequest(url: URL(string: url)!))
    }
 }

struct ContentView: View {
    @State var isfav2 = false
    let pub = NotificationCenter.default.publisher(for: Notification.Name.init(rawValue: "get_isfav"))
    @ObservedObject var userController = UserController()
    @ObservedObject var signInController = SignInController()
    var url: String
    @State var showModal = false;
    let web: Web
    init(url: String) {
        self.url = url
        web = Web(url: url)
    }
    
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    VStack(spacing: 0) {
                        SearchView()
                        self.web.webview
                            .frame(minHeight: 0, maxHeight: .infinity)
                    }
                    .onReceive(signInController.timer, perform: { time in
                        if(self.signInController.timeRemaining > 0){
                            self.signInController.timeRemaining -= 1
                        }
                    })
                    InfoModalView()
                        .offset(x: 0, y: showModal ? geometry.size.height - CGFloat(getInfooffset()) : geometry.size.height)
                        .animation(.linear)
                        .environmentObject(self.userController)
                        .environmentObject(self.signInController)
                    BottomTabView(showModal: self.$showModal)
                        .offset(x: 0, y: isiPhoneXScreen() ? 34 : 0)
                }.navigationBarHidden(true)
            }
            .edgesIgnoringSafeArea(.all)
            .environmentObject(self.web)
            .onAppear(perform: {
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
