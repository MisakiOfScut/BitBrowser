//
//  UserPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/8.
//

import Foundation

class UserController : ObservableObject {
    
    @Published var fail:Bool = false
    @Published var success:Bool = false
    
    var msg:String = ""
    
    
    func login(username: String, password: String){
        // encoded password
        
        UserService.login(username: username, password: password){ (success: Bool, resp: GeneralResp?, error: Error?) in
            if success{
                //login success
                if (resp?.success)!{
                self.success = true
                    self.msg = (resp?.msg)!
                    print("login success")}
                else{
                    self.fail = true
                    self.msg = (resp?.msg)!
                    print("login failed")
                }
            }else{
                if error != nil{
                    //login error
                }else{
                    //login failed
                }
            }
        }
    }
    
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
                    print(error)
                }else{
                    
                }
            }
        }
    }
    
    func sendMail(email: String){
        UserService.sendMail(email: email){ (success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                if(resp?.success)!{
                    self.success = true
                    self.msg = (resp?.msg)!
                    print("email success!")
                }
                else{
                    self.fail = true
                    self.msg = (resp?.msg)!
                    print("email failed")
                }
            }else{
                if error != nil{
                    print(error)
                }else{
                    
                }
            }
        }
    }
    
    func verifyCode(email: String, vaildCode:String){
        UserService.verifyCode(email: email, vaildCode: vaildCode){(success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                print(resp?.msg)
            }else{
                if error != nil{
                    print(error)
                }else{
                    
                }
            }
        }
    }
    
}
