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
                NavigationLink(destination: ContentView()) {
                    Text("Hello, world!").padding()
                }
            }
        }.onAppear {
            tp.fetchData()
        }.onDisappear {
            print("ContentView disappeared!")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
