//
//  ContentView.swift
//  BitBrowser
//
//  Created by ws on 2021/6/2.
//

import SwiftUI

let tp = TestPresenter()

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                WebView(url: URL(string: "https://www.baidu.com")!)
                    .frame(minHeight: 0, maxHeight: .infinity)
                BottomTabView()
            }.navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
