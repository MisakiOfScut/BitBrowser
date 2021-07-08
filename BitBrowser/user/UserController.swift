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
    @Published var is_login:Bool = false
    @Published var name:String = "尚未登录"
    @Published var user_id = ""
    static var userController = UserController()
    
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
                    print(error as Any)
                }else{
                    //login failed
                }
            }
        }
    }
    
    func login(username: String, password: String){
        // encoded password
        let bookmarkController = BookmarkController.bookmarkController
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
                    bookmarkController.getMarkList()
                }
                else{
                    self.fail = true
                    self.msg = (resp?.msg)!
                    print("login failed")
                }
            }else{
                if error != nil{
                    print(error as Any)
                }else{
                    //login failed
                }
            }
        }
    }
    
    
}

struct userAuth:Decodable,Encodable {
  var userId:String = ""
  var userName:String = ""
}
