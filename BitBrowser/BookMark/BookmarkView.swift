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
    @ObservedObject var BookmarkData: Bookmark = Bookmark(data: [Mark(title: "百度一下，你就知道", webUrl: "https://www.baidu.com"),Mark(title: "搜狐新闻", webUrl: "https://www.sohu.com"),Mark(title: "哔哩哔哩，干杯🍻", webUrl: "https://www.bilibili.com")])
//    @EnvironmentObject var web: Web
    
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
                    ForEach(self.BookmarkData.markList) {item in
                        if !item.isRemove {
                            //书签跳转
                            Button(action:{
//                                self.web.webview.load(item.webUrl)
                                self.goToPage(url: item.webUrl)
                            }){
                                SingleBookmarkView(index: item.id)
                                    .environmentObject(self.BookmarkData)
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

//单个书签
struct SingleBookmarkView: View {
//    @State var isRemove: Bool = false
//    var title: String = "百度"
//    var webUrl: String = "http://baidu.com"
    
    @EnvironmentObject var BookmarkData: Bookmark
    var index: Int
    
    var body: some View {
        HStack {
            Image(self.BookmarkData.markList[index].isRemove ? "like": "like_fill")
                .padding(.leading)
                .onTapGesture {
                    self.BookmarkData.remove(id: self.index)
                }
            VStack(alignment: .leading, spacing: 6.0) {
                Text(self.BookmarkData.markList[index].title)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text(self.BookmarkData.markList[index].webUrl)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
            Spacer()
        }
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4, x: 0, y: 4)
    }
}
struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
