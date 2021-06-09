//
//  HistoryView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/8.
//

import SwiftUI

struct HistoryView: View {
    var history:HistoryRecord = HistoryRecord(inputRecordList:[Record(recordDate: .distantPast, url: .init(fileURLWithPath: "www.baidu.com"), webName: "百度一下，你就知道"),Record(recordDate: .distantFuture, url: .init(fileURLWithPath: "www.google.com"), webName: "谷歌")])
    
    var body: some View {
            ScrollView{
                ForEach(0..<history.recordList.count){item in
                    SingleRecordView(record: history.recordList[item],dateDate: history.dateString_date(id: item),dateTime: history.dateString_time(id: item))
                        .overlay(
                        RoundedRectangle(cornerRadius: 0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .stroke(Color.gray,lineWidth: 1)
                        )
                }
            }
    }
}


struct SingleRecordView:View{
    
    var record:Record
    var dateDate:String
    var dateTime:String
    
        var body: some View{
            HStack{
                VStack(alignment: .leading, spacing: 6.0)
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


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
