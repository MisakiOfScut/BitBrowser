//
//  LoginView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/9.
//
import SwiftUI

//页面数据：账号和密码
struct SignInView: View {
    @State var account:String = ""
    @State var password:String = ""
    @State var password_check:String = ""
    @State var email:String=""
    @State var verify:String=""
    
    @State var showingAlert:Bool = false
    @State var showingSuccess:Bool = false
    @ObservedObject var userPresenter = UserPresenter()
    let dispatchQueue = DispatchQueue(label:"serial")
    let semaphore = DispatchSemaphore(value: 0)
    
    
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
            }
            VStack(alignment: .center, spacing: nil){
                 Spacer()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入你的账号", text: self.$account)
                }
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入你的密码", text: self.$password)
                }
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()

                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    SecureField("  请再次输入你的密码", text: self.$password_check)
                }
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                HStack{
                    VStack(alignment: .leading, spacing: 8){
                        TextField("  请输入你的邮箱账号", text: self.$email)
                    }
                    .frame(width:250,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .stroke(Color.gray,lineWidth: 2)
                    )
                    
                    VStack(alignment: .trailing, spacing: 8){
                        Button(action: {
                            userPresenter.sendMail(email: email)
                        }){
                            Text("发送验证码")
                        }
                    }
                }
                .padding(.bottom)
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入验证码", text: self.$verify)
                }
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                Button(action: {
                    userPresenter.register(username: account, password: password, email: email, vaildCode: verify)
                }){
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:nil){
                        Text("注册")
                            .foregroundColor(.black)
                    }
                    .frame(width:150, height:40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .stroke(Color("Color_Login"),lineWidth: 3)
                    )
                }
                .padding(.bottom)
                .padding(.top)
                
            
                Spacer()
            }
        }
    }
    
}
    
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView()
        }
    }
