//
//  LoginView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/9.
//
import SwiftUI

//页面数据：账号和密码
struct LoginView: View {
    @State var account:String = ""
    @State var password:String = ""
    
    @Environment(\.presentationMode) private var presentationMode
    let userPresenter = UserPresenter()
    
    
    var body: some View {
        VStack {
            HStack {
                Image("arrowLeft")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.leading)
                Spacer()
            }
            VStack(alignment: .center, spacing: nil){
                Image(systemName: "person.circle")
                    .resizable()
                    .frame( width:100,height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .scaleEffect(1.5)
                    .padding(40)
                    .foregroundColor(Color("Color_Login"))
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入你的账号", text: self.$account)
                }
                .frame(width:250,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入你的密码", text: self.$password)
                }
                .frame(width:250,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                Button(action: {
                    userPresenter.login(username: account, password: password)
                }){
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:nil){
                        Text("登录")
                            .foregroundColor(.black)
                    }
                    .frame(width:150, height:40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .stroke(Color("Color_Login"),lineWidth: 3)
                    )
                }
                .padding(.bottom)
                HStack{
                    Text("还没有注册？")
                        .padding(.trailing)
                    Button(action:{}){
                        Text("立即注册")
                    }
                }
                .padding(.bottom)
                HStack{
                    Text("忘记密码？    ")
                        .padding(.trailing)
                    Button(action:{}){
                        Text("找回密码")
                    }
                }
                Spacer()
            }
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
