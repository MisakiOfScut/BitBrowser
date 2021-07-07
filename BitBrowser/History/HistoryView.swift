//
//  HistoryView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

//页面需要的数据形式：在HistoryRecord.swift文件夹中


struct HistoryView: View {
    @ObservedObject var history:HistoryRecord = HistoryRecord.historyRecord
    var temp:String = ""
    var is_printed:Bool=true
    @State var isclear = false
    @Environment(\.presentationMode) private var presentationMode
    
    func initialData(){
        history.add(data: Record(recordDate: Date(), url: URL.init(string: "www.baidu.com")!, webName: "百度一下？"))
        history.add(data: Record(recordDate: Date(), url: URL.init(string: "www.baidu.com")!, webName: "百度下？"))
        
    }
    

    
    var body: some View {
        
        VStack {
            HStack {
                Image("arrowLeft")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.leading)
                    .alert(isPresented: $isclear, content: {
                        Alert(title: Text("系统提示"), message: Text("确定要删除所有记录吗"), primaryButton: .default(Text("确定")){
                            history.clear()
                        },
                        secondaryButton: .destructive(Text("取消")))
                    })
                Spacer()
                Text("历史记录")
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action:{
                    self.isclear.toggle()
                }){
                    Image(systemName: "trash")
                }
                .padding(.trailing)
            }
            ScrollView{
                ForEach(0..<history.recordList.count){item in
                    if history.recordList[item].isRemoved == false
                    {

                            SingleRecordView(index:item)
                                .environmentObject(self.history)

                        .overlay(
                            RoundedRectangle(cornerRadius: 0, style: .continuous)
                                .stroke(Color.gray,lineWidth: 1)
                        )

                    
                    }
                
                }
            }
        }
    }
}


struct SingleRecordView:View{
    @EnvironmentObject var history:HistoryRecord
    var index:Int = 0
    
    @State var dicide = false
    
    //自定义跳转函数
    func goToPage(url: String) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView(url: url))
            window.makeKeyAndVisible()
        }
//        self.web.webview.load(url)
    }
    
        var body: some View{
            if index == 0 || history.dateString_date(id: index) != history.dateString_date(id: index-1) {
                SingleRecordView_Ahead(index:index)
                    .environmentObject(self.history)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .stroke(Color.gray,lineWidth: 1)
                    )
            }
            
            Button(action: {
                self.goToPage(url:self.history.recordList[index].url.absoluteString)
            }){
                Group{
                    HStack{
                        VStack(alignment: .leading)
                        {
                            Text(history.recordList[index].webName)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            Text(history.recordList[index].url.absoluteString)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading)
                        Spacer()
                        VStack{
                            Text(history.dateString_date(id: index))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(history.dateString_time(id: index))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                }
            }
            
            
                
                Button(action: {
                    dicide.toggle()
                }, label: {
                    Image(systemName: "trash")
                })
            }
            .alert(isPresented: $dicide, content: {
                Alert(title: Text("系统提示"), message: Text("确定要删除该记录吗"), primaryButton: .default(Text("确定")){
                    history.remove(id: self.index)
                },
                secondaryButton: .destructive(Text("取消")))
            })
            .frame(height:50)
            .background(Color.white)
            .shadow(radius: 30,x: 0,y: 10 )
            .cornerRadius(10)
        }
    
}

struct SingleRecordView_Ahead:View{
    @EnvironmentObject var history:HistoryRecord
    var index:Int = 0

    @State var decide = false
    
        var body: some View{
            HStack{
                
                Text(history.dateString_date(id: index))
                    .font(.subheadline)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.horizontal)
            .background(Color("Color_HistoryBar"))
            
        }
    
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
