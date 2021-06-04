//
//  Response.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//

import Moya

extension Response{
    var json: Any?{
        do{
            let json = try JSONSerialization.jsonObject(with: self.data, options: [])
            return json
        }catch let error as NSError{
            print(error)// Log
        }
        return nil
    }
    
    var success: Bool{
        return self.statusCode==200
    }
    
    var unauthenticated: Bool{
        return self.statusCode==401
    }
}
