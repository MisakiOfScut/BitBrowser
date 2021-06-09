//
//  InfoModalView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

struct InfoModalView: View {
    @Binding var showModal: Bool
    var body: some View {
        NavigationView {
            VStack {
                Button("关闭") {
                    self.showModal = false
                }
                HStack {
                    Button("登录") {
                        
                    }
                    Button("注册") {
                        
                    }
                }
                HStack {
                    NavigationLink(
                        destination: HistoryView()) {
                        Text("历史记录")
                    }
                    NavigationLink(
                        destination: BookmarkView()) {
                        Text("书签")
                    }
                }.navigationBarHidden(true)
            }
        }
    }
}

struct InfoModalView_Previews: PreviewProvider {
//    @State var show = true
    static var previews: some View {
        Text("hello")
//        InfoModalView()
    }
}
