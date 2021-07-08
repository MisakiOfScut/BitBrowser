//
//  BottomTabView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/7.
//

import SwiftUI

struct BottomTabView: View {
    @State var showInfoModal = false
    @Binding var showModal: Bool
    @EnvironmentObject var web: Web
    @State var isPrivate = false
    @State var isPublic = false
    @ObservedObject var history = HistoryRecord.historyRecord
    var body: some View {
        HStack(){
            Image("arrowLeft")
                .onTapGesture {
                    self.web.webview.goBack()
                }
            Spacer()
            Image("arrowRight")
                .onTapGesture {
                    self.web.webview.goForward()
                }
            Spacer()
            Image("home")
                .scaleEffect(CGSize(width: 0.8, height: 0.8))
                .onTapGesture {
                    self.web.webview.load("https://www.baidu.com")
                }
            Spacer()
            
            Image(systemName: history.isvalid ? "eye" : "eye.slash")
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        print("hollo")
                        history.isvalid.toggle()
                }
                
            
            Spacer()
                .alert(isPresented: $isPublic, content: {Alert(title: Text("系统提示"), message: Text("确认退出无痕模式吗"), primaryButton: .default(Text("是的")){
                    history.isvalid = false
                }, secondaryButton: .destructive(Text("取消")))})
            Image("me")
                .scaleEffect(0.8)
                .onTapGesture {
                    self.showModal = !self.showModal
                }
            
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("background1"))
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $isPrivate, content: {Alert(title: Text("系统提示"), message: Text("确认切换无痕模式吗"), primaryButton: .default(Text("是的")){
            history.isvalid = false
        }, secondaryButton: .destructive(Text("取消")))})
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView(showModal: .constant(true))
    }
}
