//
//  t_UserUIView.swift
//  BitBrowser
//
//  Created by ws on 2021/6/8.
//

import SwiftUI
import Combine

struct t_UserUIView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    let p = UserPresenter()
    
    var body: some View {
        Text("Hello, World!")
        TextField("username", text: $username)
        TextField("password", text: $password)
        Button("login", action: {
            p.login(username: username, password: password)
        })
    }
}

struct t_UserUIView_Previews: PreviewProvider {
    static var previews: some View {
        t_UserUIView()
    }
}
