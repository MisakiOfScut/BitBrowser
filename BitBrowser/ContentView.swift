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
    @State var showModal = false;
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    web.webview.frame(minHeight: 0, maxHeight: .infinity)
                    InfoModalView()
                        .offset(x: 0, y: showModal ? geometry.size.height - 236 : 1000)
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
        ContentView()
    }
}
