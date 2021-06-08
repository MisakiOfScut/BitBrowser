//
//  UserPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/8.
//

import Foundation

class UserPresenter {
    
    func login(username: String, password: String){
        // encoded password
        
        UserService.login(username: username, password: password){ (success: Bool, resp: GeneralResp?, error: Error?) in
            if success{
                //login success
            }else{
                if error != nil{
                    //login error
                    print(error)
                }else{
                    //login failed
                }
            }
        }
    }
    
    func register(username: String, password: String){
        // encoded password
        
        UserService.register(username: username, password: password){ (success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                
            }else{
                if error != nil{
                    
                }else{
                    
                }
            }
        }
    }
}
