 //
//  ContentView.swift
//  BitBrowser
//
//  Created by ws on 2021/6/2.
//

import SwiftUI

let tp = TestPresenter()
 
 class Web: ObservableObject {
    @Published var webview = WebView(web: nil, req: URLRequest(url: URL(string: "https://www.baidu.com")!))
 }

struct ContentView: View {
    let web = Web()
    var body: some View {
        NavigationView {
            VStack {
                web.webview.frame(minHeight: 0, maxHeight: .infinity)
                BottomTabView()
            }.navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.top)
        .environmentObject(web)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
