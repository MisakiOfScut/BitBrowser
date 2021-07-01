//
//  ResetView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/7/1.
//

import Foundation
import SwiftUI

struct ResetView: View {
    @State var account:String = ""
    @State var password:String = ""
    @State var password_check:String = ""
    @State var email:String=""
    @State var verify:String=""
    
    @State var showingAlert:Bool = false
    @State var showingSuccess:Bool = false
    @ObservedObject var userController = UserController()
    let dispatchQueue = DispatchQueue(label:"serial")
    let semaphore = DispatchSemaphore(value: 0)
    
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    func goToHome() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView(url: "https://www.baidu.com"))
            window.makeKeyAndVisible()
        }
    }
    
    
    
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
                    RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入你的密码", text: self.$password)
                }
                .alert(isPresented: $userController.success, content: {
                    Alert(title: Text("注册成功"), message: Text(userController.msg), dismissButton: .default(Text("好的")) {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                })
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
                .alert(isPresented: $userController.fail, content: {
                    Alert(title: Text("注册失败"), message: Text(userController.msg), dismissButton: .default(Text("好的")) {})
                })
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
                            userController.sendMail(email: email)
                        }){
                            Text("发送验证码")
                        }
                    }
                }
                .alert(isPresented: $userController.e_fail, content: {
                    Alert(title: Text("发送失败"), message: Text(userController.msg), dismissButton: .default(Text("好的")) {})
                })
                .padding(.bottom)
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    TextField("  请输入验证码", text: self.$verify)
                }
                .alert(isPresented: $userController.e_success, content: {
                    Alert(title: Text("系统提示"), message: Text(userController.msg), dismissButton: .default(Text("好的")) {})
                })
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                Button(action: {
                    userController.resetPasswd(username: account, password: password, email: email, vaildCode: verify)
                }){
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:nil){
                        Text("重置")
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
    
    struct ResetView_Previews: PreviewProvider {
        static var previews: some View {
            ResetView()
        }
    }
