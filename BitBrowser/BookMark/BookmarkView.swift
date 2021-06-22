//
//  BookmarkView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

struct BookmarkView: View {
    
    @State var searchContent: String = ""
    @Environment(\.presentationMode) private var presentationMode
    //初始化书签数据
    @EnvironmentObject var bookMarkPresenter: BookMarkPresenter
    
    //自定义跳转函数
    func goToPage(url: String) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView(url: url))
            window.makeKeyAndVisible()
        }
//        self.web.webview.load(url)
    }
    
    var body: some View {
        VStack {
            //顶部栏
            ZStack{
                HStack{
                    Image("arrowLeft")
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                Text("书签/收藏")
                    .frame(alignment: .center)
                    .font(.headline)
            }
            .padding()
            
            //搜索框
            HStack {
                TextField("请输入内容", text: self.$searchContent)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                .stroke(Color("Color_Login"),lineWidth: 2))
                Image("search")
            }
            .padding(.horizontal)
            
            //书签展示
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(self.bookMarkPresenter.marklist) {item in
                        if !item.isRemove {
                            //书签跳转
                            Button(action:{
//                                self.web.webview.load(item.webUrl)
                                self.goToPage(url: item.webUrl)
                            }){
                                SingleBookmarkView(index: item.id)
                                    .environmentObject(self.bookMarkPresenter)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
//        .onAppear(perform: {
//            bookMarkPresenter.getMarkList()
//        })
    }
}

//单个书签
struct SingleBookmarkView: View {
//    @State var isRemove: Bool = false
//    var title: String = "百度"
//    var webUrl: String = "http://baidu.com"
    
    @EnvironmentObject var bookMarkPresenter:BookMarkPresenter
    var index: Int
    @State var removed: Bool = false
    
    var body: some View {
        HStack {
//            Image(self.bookMarkPresenter.marklist[index].isRemove ? "like": "like_fill")
            Image("like_fill")
                .padding(.leading)
                .onTapGesture {
                    self.removed = !self.removed
//                    self.bookMarkPresenter.remove(id: self.index)
                }
                .alert(isPresented: $removed, content: {
                    Alert(title: Text("确定取消收藏吗？"),  primaryButton: .default(Text("确定")){
                        self.bookMarkPresenter.remove(id: self.index)
                      },
                      secondaryButton: .destructive(Text("取消")))
                })
            VStack(alignment: .leading, spacing: 6.0) {
                Text(self.bookMarkPresenter.marklist[index].title)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text(self.bookMarkPresenter.marklist[index].webUrl)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
            Spacer()
        }
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1, x: 0, y: 0)
    }
}
struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
