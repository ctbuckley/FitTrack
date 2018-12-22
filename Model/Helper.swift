
//
//  Helper.swift
//  FirebaseAuthenticationUI
//
//  Created by Connor Buckley on 11/12/18.
//  Copyright © 2018 Frederik Kofoed. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Helper {
    static let helper = Helper()
    
    // switch to success initial VC
    func switchToSuccessVC() {
        // create main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiate success view
        let successVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        
        // get app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // set successVC as root view
        appDelegate.window?.rootViewController = successVC
        
        
       
    }
    
    // log out function
    func logOut() {
        // sign out w/ firebase
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
        
        // switch to log in view
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiate success view
        let LogInVC = storyboard.instantiateViewController(withIdentifier: "LogInVC")
        
        // get app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // set LogInVC as root view
        appDelegate.window?.rootViewController = LogInVC
    }
    
    
}
