//
//  AuthManager.swift
//  Eduka
//
//  Created by Celestial on 14/01/25.
//

import Foundation

final class AuthManager{
    
    static let shared = AuthManager()
    
    private init(){}
    
    var login:Bool = false
    var logOut:Bool = true
    
    var isSignIn:Bool{
        return login
    }
    
    var isLogOut:Bool{
        return logOut
    }
    
}
