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
    @State var invalidPassword:Bool = false
    @State var showingAlert:Bool = false
    @State var showingSuccess:Bool = false
    @EnvironmentObject var signInController:SignInController
    
    let dispatchQueue = DispatchQueue(label:"serial")
    let semaphore = DispatchSemaphore(value: 0)
    
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    func goToHome() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView(url: "https://www.baidu.com"))
            window.makeKeyAndVisible()
        }
    }
    
    func inputRegister(){
        if(self.password_check != self.password){
            invalidPassword = true
            return
        }
        else{
            signInController.register(username: self.account, password: self.password, email: self.email, vaildCode: self.verify)
            return
        }
    }
    
    func inputEmail(){
        if(signInController.timeRemaining <= 0){
            signInController.timeRemaining = 60
            signInController.sendMail(email: self.email)
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
                    Text("  ")
                    TextField("请输入你的账号", text: self.$account)
                }
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding(.bottom)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("  ")
                    SecureField("请输入你的密码", text: self.$password)
                }
                .alert(isPresented: $signInController.success, content: {
                    Alert(title: Text("注册成功"), message: Text(signInController.msg), dismissButton: .default(Text("好的")) {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                })
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding(.bottom)

                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("  ")
                    SecureField("请再次输入你的密码", text: self.$password_check)
                }
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .alert(isPresented: $signInController.fail, content: {
                    Alert(title: Text("注册失败"), message: Text(signInController.msg), dismissButton: .default(Text("好的")) {})
                })
                .padding(.bottom)
                
                HStack{
                    HStack{
                        Text("  ")
                        TextField("请输入你的邮箱账号", text: self.$email)
                    }
                    .frame(width:250,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .stroke(Color.gray,lineWidth: 2)
                    )
                    
                    VStack(alignment: .trailing, spacing: 8){
                        Button(action: {
                            inputEmail()
                        }){
                            Text(signInController.timeRemaining > 0 ? "等待\(signInController.timeRemaining)":"发送验证码")
                        }
                    }
                }
                .alert(isPresented: $signInController.e_fail, content: {
                    Alert(title: Text("发送失败"), message: Text(signInController.msg), dismissButton: .default(Text("好的")) {})
                })
                .padding(.bottom)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("  ")
                    TextField("请输入验证码", text: self.$verify)
                }
                .alert(isPresented: $signInController.e_success, content: {
                    Alert(title: Text("系统提示"), message: Text(signInController.msg), dismissButton: .default(Text("好的")) {})
                })
                .frame(width:340,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                
                Button(action: {
                    inputRegister()
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
                .alert(isPresented: $invalidPassword, content: {
                    Alert(title: Text("系统提示"), message: Text("两次输入密码不匹配"), dismissButton: .default(Text("好的")) {})
                })
            
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
