//
//  UserPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/8.
//

import Foundation
import ObjectMapper

class UserController : ObservableObject {
    
    @Published var fail:Bool = false
    @Published var success:Bool = false
    @Published var e_fail:Bool = false
    @Published var e_success:Bool = false
    @Published var is_login:Bool = false
    @Published var name:String = "尚未登录"
    @Published var timeRemaining = 0
    @Published var user_id = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var msg:String = ""
    
    init() {
        if let dataStored = UserDefaults.standard.object(forKey: "user_Auth") as? Data{
            let data = try! decoder.decode(userAuth.self, from: dataStored)
            self.isAuthValid(id: data.userId, name: data.userName)
        }else{
            user_id = ""
        }
    }
    
    func isAuthValid(id:String, name:String){
        UserService.isAuth(userId: id){ (success: Bool, resp: GeneralResp?, error: Error?) in
            if success{
                if(resp?.success)!{
                    self.is_login = true
                    self.name = name
                    self.user_id = id
                    self.is_login = true
                }else{
                    print("Is Auth failed...")
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
    
    func login(username: String, password: String){
        // encoded password
        
        UserService.login(username: username, password: password){ (success: Bool, resp: GeneralResp?, error: Error?) in
            if success{
                //login success
                if (resp?.success)!{
                self.success = true
                    self.msg = (resp?.msg)!
                    self.name = username
                    self.is_login = true
                    let dataStored = try! encoder.encode(userAuth(userId: (resp?.id)!, userName: username))
                    UserDefaults.standard.set(dataStored, forKey: "user_Auth")
                }
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

struct userAuth:Decodable,Encodable {
  var userId:String = ""
  var userName:String = ""
}
