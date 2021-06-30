//
//  HistoryView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

//页面需要的数据形式：在HistoryRecord.swift文件夹中


struct HistoryView: View {
    @ObservedObject var history:HistoryRecord = HistoryRecord()
    var temp:String = ""
    var is_printed:Bool=true
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        VStack {
            HStack {
                Image("arrowLeft")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.leading)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("清除历史记录")

                })
            }
            ScrollView{
                ForEach(0..<history.recordList.count){item in
                    if history.recordList[item].isRemoved == false
                    {if item == 0 || history.dateString_date(id: item) != history.dateString_date(id: item-1) {
                        SingleRecordView_Ahead(record: history.recordList[item],dateDate: history.dateString_date(id: item),dateTime: history.dateString_time(id: item))
                            .overlay(
                                RoundedRectangle(cornerRadius: 0, style: .continuous)
                                    .stroke(Color.gray,lineWidth: 1)
                            )
                        HStack{
                            SingleRecordView(record: history.recordList[item],dateDate: history.dateString_date(id: item),dateTime: history.dateString_time(id: item))
                                
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "trash")
                            })
                            
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 0, style: .continuous)
                                .stroke(Color.gray,lineWidth: 1)
                        )

                    }
                    else{
                        
                        HStack{
                        SingleRecordView(record: history.recordList[item],dateDate: history.dateString_date(id: item),dateTime: history.dateString_time(id: item))
                            
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "trash")

                        })
                        }
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
}


struct SingleRecordView:View{
    
    var record:Record
    var dateDate:String
    var dateTime:String
    @State var dicide = false
    
        var body: some View{
            HStack{
                VStack(alignment: .leading)
                {
                    Text(record.webName)
                        .font(.headline)
                        .fontWeight(.heavy)
                    Text(record.url.path)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading)
                Spacer()
                VStack{
                    Text(dateDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(dateTime)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .frame(height:50)
            .background(Color.white)
            .shadow(radius: 30,x: 0,y: 10 )
            .cornerRadius(10)
        }
    
}

struct SingleRecordView_Ahead:View{
    
    var record:Record
    var dateDate:String
    var dateTime:String
    @State var decide = false
    
        var body: some View{
            HStack{
                
                Text(dateDate)
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
