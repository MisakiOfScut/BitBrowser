//
//  InfoModalView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

struct InfoModalView: View {
//    @Binding var showModal: Bool
    @State private var isLogin = true
    @State private var userName = "vivian"
    @State private var showAlert = false
    @State private var showQuit = false
    @State private var isBookmark = false
    @State private var isHistory = false
    @State private var isLoginPage = false
    
//    func changeLoginState(){
//        isLogin = !isLogin
//    }
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 50.0, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 3)
                        Text(isLogin ? userName : "您尚未登录")
                            .padding(.leading, 6.0)
                        Spacer()
//                        NavigationLink(
//                            destination: LoginView()) {
                            Text(isLogin ? "退出登录" : "登录/注册")
                                .foregroundColor(Color("System_Blue"))
                                .onTapGesture {
                                    isLoginPage = true
                                }
                                .fullScreenCover(isPresented: $isLoginPage, content: {
                                    LoginView()
                                })
//                        }
                        .ignoresSafeArea(edges: .top)
                        .navigationBarHidden(true)
                        .disabled(isLogin)
                        .onTapGesture {
                            showQuit = true
                        }
                        .alert(isPresented: $showQuit){
                            Alert(title: Text("确定退出吗"),
                                  primaryButton: .default(Text("确定")){
                                    isLogin = false
                                  },
                                  secondaryButton: .destructive(Text("取消")))
                        }
                    }
                    .padding([.top, .leading, .trailing], 14.0)
                    Divider().padding(.vertical, 10)
                    HStack {
//                        NavigationLink(destination: BookmarkView()){
                            VStack {
                                Image("favorite")
                                    .scaleEffect(CGSize(width: 1, height: 1))
                                Text("书签")
                                    .foregroundColor(Color("System_Blue"))
                            }
                            .onTapGesture {
                                isBookmark = true
                            }
                            .fullScreenCover(isPresented: $isBookmark, content: {
                                BookmarkView()
                            })
//                        }
                        
//                        NavigationLink(destination: HistoryView()){
                            VStack {
                                Image("history")
                                    .scaleEffect(CGSize(width: 1, height: 1))
                                Text("历史记录")
                                    .foregroundColor(Color("System_Blue"))
                            }
                            .onTapGesture {
                                isHistory = true
                            }
                            .fullScreenCover(isPresented: $isHistory, content: {
                                HistoryView()
                            })
//                        }
                        Spacer()
                    }
                    .disabled(!isLogin)
                    .onTapGesture {
                        showAlert = isLogin ? false : true
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("请先登录"),
                              dismissButton: .default(Text("OK")))
                    }
    //                .disabled(!isLogin)
                    .padding([.top, .leading, .bottom], 14.0)
                }
//                .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .frame(height: 180)
                .background(Color("background1"))
                .ignoresSafeArea()
                Spacer()
            }
        }
    }
}

struct InfoModalView_Previews: PreviewProvider {
//    @State var show = true
    static var previews: some View {
//        Text("hello")
//        InfoModalView(showModal: .constant(true))
        InfoModalView()
    }
}
