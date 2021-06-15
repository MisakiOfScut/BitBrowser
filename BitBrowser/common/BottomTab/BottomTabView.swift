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
    var body: some View {
        HStack(){
            Image("arrowLeft")
                .onTapGesture {
                    web.webview.goBack()
                }
            Spacer()
            Image("arrowRight")
                .onTapGesture {
                    web.webview.goForward()
                }
            Spacer()
            Image("home")
                .scaleEffect(CGSize(width: 0.8, height: 0.8))
            Spacer()
            NavigationLink(
                destination: BookmarkView()) {
                Image("favorite")
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
            }
            Spacer()
            Image("me")
                .scaleEffect(0.8)
                .onTapGesture {
//                    self.showInfoModal = true
                    self.showModal = !self.showModal
                }
            //                    .sheet(isPresented: $showInfoModal) {
            //                        InfoModalView(showModal: self.$showInfoModal)
            //                            .offset(y: 125)
            //                        InfoModalView()
            //                    }
            
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
        .padding()
        .background(Color("background1"))
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView(showModal: .constant(true))
    }
}
