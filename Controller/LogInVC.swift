//
//  ViewController.swift
//  FitTrack
//
//  Created by Connor Buckley on 11/20/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController, UITextFieldDelegate {

    
    //declaring outlets for textfields

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var loginErrorMessage: UILabel!
    
    // view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // disable log in button by default
        enableLogInButton(enabled: false)
        
        // declare delegates
        emailTF.delegate = self
        passwordTF.delegate = self
        
        // observe text fields to enable log in button when appropriate
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        // initialize content of error message as an empty string
        loginErrorMessage.text = ""
        
    }
    
    //view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check if user is logged in
        Auth.auth().addStateDidChangeListener({ (auth: Auth, user: User? ) in
            // if authenticated
            if user != nil {
                print("user successfully logged in")
                Helper.helper.switchToSuccessVC()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // before existing, resign first responder for all text fields
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        // on background tap, dismiss keyboard
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
    }
    
    @IBAction func loginWithPasswordTapped(_ sender: Any) {
        // sign in func
        handleSignIn()
        
        // dismiss keyboard
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // enable the log in button if none of the text fields are empty
    @objc func textFieldChanged(_ target:UITextField) {
        
        // check if form is filled (bool)
        let formFilled = emailTF.text != nil && emailTF.text != "" && passwordTF.text != nil && passwordTF.text != ""
        
        // enable sign up if form is filled
        enableLogInButton(enabled: formFilled)
    }
    
    // move to other text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        switch textField {
        // if return email text field, go to email text field
        case emailTF:
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
            break
        // if return password text field, go call handle sign up function
        case passwordTF:
            passwordTF.resignFirstResponder()
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    
    // enable or disable the sign up button
    func enableLogInButton(enabled:Bool) {
        
        // if enabled
        if enabled {
            // if sign up button is enabled
            // set alpha too 100% and set bool isEnabled to true
            logInButton.alpha = 1.0
            logInButton.isEnabled = true
        } else {
            // else if sign up button is disabled
            // reduce alpha and set bool isEnabled to false
            logInButton.alpha = 0.5
            logInButton.isEnabled = false
        }
    }
    
    // handle sign up
    @objc func handleSignIn() {
        print("Log In Tapped!")
        
        // get text from TF
        
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        // log in w/ email pass
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            // if log in not successful
            if error != nil {
                print(error!.localizedDescription)
                self.loginErrorMessage.text = error!.localizedDescription
                return
            } else {
                Helper.helper.switchToSuccessVC()
            }
        }
        
    }


}

