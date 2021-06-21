//
//  BookmarkView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

//获取存储数据
func initBookmarkData() -> [Mark] {
    var output: [Mark] = []
    if let dataStored = UserDefaults.standard.object(forKey: "markList") as? Data {
        let data = try! decoder.decode([Mark].self, from: dataStored)
        for item in data {
            if !item.isRemove {
                output.append(Mark(title: item.title, webUrl: item.webUrl, isRemove: item.isRemove, id: item.id))
            }
        }
    }
    return output
}

struct BookmarkView: View {
    
    @State var searchContent: String = ""
    @Environment(\.presentationMode) private var presentationMode
    //初始化书签数据
    //@ObservedObject var BookmarkData: Bookmark = Bookmark(data: [Mark(title: "百度", webUrl: "http://www.baidu.com"),Mark(title: "搜狐", webUrl: "http://www.souhu.com"),Mark(title: "b站", webUrl: "http://www.bilibili.com")])
    @ObservedObject var bookMarkPresenter = BookMarkPresenter()
    @ObservedObject var BookmarkData: Bookmark = Bookmark(data: initBookmarkData())
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
//                        if !item.isRemove {
                            //书签跳转
                            Button(action:{
//                                self.web.webview.load(item.webUrl)
                                self.goToPage(url: item.webUrl)
                            }){
                                SingleBookmarkView(index: item.id)
                                    .environmentObject(self.bookMarkPresenter)
                            }
//                        }
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear(perform: {
            bookMarkPresenter.getMarkList()
        })
    }
}

//单个书签
struct SingleBookmarkView: View {
//    @State var isRemove: Bool = false
//    var title: String = "百度"
//    var webUrl: String = "http://baidu.com"
    
    @EnvironmentObject var bookMarkPresenter:BookMarkPresenter
    var index: Int
    
    var body: some View {
        HStack {
            Image(self.bookMarkPresenter.marklist[index].isRemove ? "like": "like_fill")
                .padding(.leading)
                .onTapGesture {
                    self.bookMarkPresenter.remove(id: self.index)
                }
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
        .shadow(radius: 4, x: 0, y: 4)
    }
}
struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
