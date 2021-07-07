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
    @State var signInView_show = false
    @State var resetView_show = false
    @State var showingAlert:Bool = false
    @State var showingSuccess:Bool = false
    
    //@ObservedObject var userController = UserController()
    @EnvironmentObject var userController:UserController
    @EnvironmentObject var signInController:SignInController
    let dispatchQueue = DispatchQueue(label:"serial")
    let semaphore = DispatchSemaphore(value: 0)
    
    
    @Environment(\.presentationMode) private var presentationMode
    //自定义跳转函数
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
                Image(systemName: "person.circle")
                    .resizable()
                    .frame( width:100,height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .scaleEffect(1.5)
                    .padding(40)
                    .foregroundColor(Color("Color_Login"))
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("  ")
                    TextField("请输入你的账号", text: self.$account)
                }
                .frame(width:250,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("  ")
                    SecureField("请输入你的密码", text: self.$password)
                }
                .frame(width:250,height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .stroke(Color.gray,lineWidth: 2)
                )
                .padding()
                .alert(isPresented: $userController.fail, content: {
                    Alert(title: Text("登陆失败"), message: Text(userController.msg), dismissButton: .default(Text("好的")))
                })
                Button(action: {
                    self.userController.login(username: account, password: password)
                }){
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:nil){
                        Text("登录")
                            .foregroundColor(.black)
                    }
                    .alert(isPresented: $userController.success, content: {
                        Alert(title: Text("系统提示"), message: Text(userController.msg), dismissButton: .default(Text("好的")) {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    })
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
                    Button(action:{
                        signInView_show.toggle()
                    }){
                        Text("立即注册")
                    }
                    .fullScreenCover(isPresented: $signInView_show, content: {
                        SignInView()
                            .environmentObject(self.signInController)
                    })
                }
                .padding(.bottom)
                
                HStack{
                    Text("忘记密码？    ")
                        .padding(.trailing)
                    Button(action:{
                        resetView_show.toggle()
                    }){
                        Text("找回密码")
                    }
                    .fullScreenCover(isPresented: $resetView_show, content: {
                        ResetView()
                            .environmentObject(self.signInController)
                    })
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
