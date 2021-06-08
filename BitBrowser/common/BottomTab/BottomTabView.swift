//
//  BottomTabView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/7.
//

import SwiftUI

struct BottomTabView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(){
                Image("arrowLeft")
                Spacer()
                Image("arrowRight")
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
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
            .padding()
            .background(Color("background1"))
            
        }
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}
