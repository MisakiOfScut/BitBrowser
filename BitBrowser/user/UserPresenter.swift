//
//  UserPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/8.
//

import Foundation

class UserPresenter : ObservableObject {
    
    @Published var login_success:Bool = false
    @Published var login_failed:Bool = false
    var msg:String = ""
    
    
    func login(username: String, password: String){
        // encoded password
        
        UserService.login(username: username, password: password){ (success: Bool, resp: GeneralResp?, error: Error?) in
            if success{
                //login success
                if (resp?.success)!{
                self.login_success = true
                    self.msg = (resp?.msg)!
                    print("login success")}
                else{
                    self.login_failed = true
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
