//
//  SignInController.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/7/7.
//
import Foundation
import ObjectMapper

class SignInController : ObservableObject {
    @Published var fail:Bool = false
    @Published var success:Bool = false
    @Published var e_fail:Bool = false
    @Published var e_success:Bool = false
    @Published var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var msg:String = ""

    func register(username: String, password: String, email: String, vaildCode: String){
        // encoded password
        UserService.register(username: username, password: password, email: email, vaildCode: vaildCode){ (success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                if(resp?.success)!{
                    self.success = true
                    self.msg = (resp?.msg)!
                    print("register success!")
                }
                else{
                    self.fail = true
                    self.msg = (resp?.msg)!
                    print("register failed")
                }
            }else{
                if error != nil{
                    print(error as Any)
                }else{
                    
                }
            }
        }
    }
    
    func sendMail(email: String){
        UserService.sendMail(email: email){ (success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                if(resp?.success)!{
                    self.e_success = true
                    self.msg = (resp?.msg)!
                    print("email success!")
                }
                else{
                    self.e_fail = true
                    self.msg = (resp?.msg)!
                    print("email failed")
                }
            }else{
                if error != nil{
                    print(error as Any)
                }else{
                    
                }
            }
        }
    }
    
    func verifyCode(email: String, vaildCode:String){
        UserService.verifyCode(email: email, vaildCode: vaildCode){(success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                print(resp?.msg as Any)
            }else{
                if error != nil{
                    print(error as Any)
                }else{
                    
                }
            }
        }
    }
    
    func resetPasswd(username: String, password: String, email: String, vaildCode: String){
        // encoded password
        UserService.resetPasswd(username: username, password: password, email: email, vaildCode: vaildCode){ (success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                if(resp?.success)!{
                    self.success = true
                    self.msg = (resp?.msg)!
                    print("reset success!")}
                else{
                    self.fail = true
                    self.msg = (resp?.msg)!
                    print("reset failed")
                }
            }else{
                if error != nil{
                    print(error as Any)
                }else{
                    
                }
            }
        }
    }
}
