//
//  BookmarkView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

struct BookmarkView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    //初始化书签数据
    @ObservedObject var BookmarkData: Bookmark = Bookmark(data: [Mark(title: "百度", webUrl: "http://www.baidu.com"),Mark(title: "搜狐", webUrl: "http://www.souhu.com"),Mark(title: "b站", webUrl: "http://www.bilibili.com")])
    
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
            
            
            //书签展示
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(self.BookmarkData.markList) {item in
                        SingleBookmarkView(index: item.id)
                            .environmentObject(self.BookmarkData)
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
