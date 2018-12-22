//
//  SignUpVC.swift
//  FitTrack
//
//  Created by Connor Buckley on 12/3/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import HealthKit

class SignUpVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //outlets
    
    @IBOutlet weak var fullNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var pickerView1: UIPickerView!
    
    @IBOutlet weak var pickerView2: UIPickerView!
    
    @IBOutlet weak var weightTB: UITextField!
    
    @IBOutlet weak var targetWeightTB: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var outLabel: String = ""

    //set up picker view data source
    
    //current weight
    let weight1 = ["50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "300"]
    
    //target weight
    let weight2 = ["50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "300"]
    
    
    //picker view methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //picker view number of rows
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var countrows : Int = weight1.count
        
        if pickerView == pickerView2 {
            
            countrows = self.weight2.count
        }
        
        return countrows
    }
    
    //picker view title for each row
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            
            let titleRow = weight1[row]
            
            return titleRow
            
        }
            
        else if pickerView == pickerView2{
            let titleRow = weight2[row]
            
            return titleRow
        }
        
        return ""
    }
    
    //picker view selected a row
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //after we select a row, hide the picker and update the field appropriately
        
        if pickerView == pickerView1 {
            self.weightTB.text = self.weight1[row]
            self.pickerView1.isHidden = true
        }
            
        else if pickerView == pickerView2{
            self.targetWeightTB.text = self.weight2[row]
            self.pickerView2.isHidden = true
            
        }
        
        // check if form is filled (bool)
        let formFilled = fullNameTF.text != nil && fullNameTF.text != "" && emailTF.text != nil && emailTF.text != "" && passwordTF.text != nil && passwordTF.text != "" && weightTB.text != nil && weightTB.text != "" && targetWeightTB.text != nil && targetWeightTB.text != ""
        
        // enable sign up if form is filled
        enableSignUpButton(enabled: formFilled)
    }
    
    
    //hide picker views and keyboard if necessary depending on which text field
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        //hide keyboards, show pickerView1
        if (textField == self.weightTB){
           
            self.fullNameTF.resignFirstResponder()
            self.emailTF.resignFirstResponder()
            self.passwordTF.resignFirstResponder()
            
            self.pickerView1.isHidden = false
            self.pickerView2.isHidden = true
           
           
        }
        //hide keyboards, show pickerview2
        else if (textField == self.targetWeightTB){
            
            self.fullNameTF.resignFirstResponder()
            self.emailTF.resignFirstResponder()
            self.passwordTF.resignFirstResponder()
            
            self.pickerView2.isHidden = false
            self.pickerView1.isHidden = true
            
        }
        
        //hide pickerviews
        else {
            self.pickerView2.isHidden = true
            self.pickerView1.isHidden = true
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //this was implemented to handle a bug I was getting with a keyboard not dismissing
        
        if (textField == self.weightTB){
            
            self.weightTB.resignFirstResponder()
            self.fullNameTF.resignFirstResponder()
            self.emailTF.resignFirstResponder()
            self.passwordTF.resignFirstResponder()
            self.targetWeightTB.resignFirstResponder()
        }
        else if (textField == self.targetWeightTB){
            
            self.weightTB.resignFirstResponder()
            self.fullNameTF.resignFirstResponder()
            self.emailTF.resignFirstResponder()
            self.passwordTF.resignFirstResponder()
            self.targetWeightTB.resignFirstResponder()
        }
        
        
    }
    
    //view did load setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // disable sign up button by default
        enableSignUpButton(enabled: false)
        
        // declare delegates
        fullNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        weightTB.delegate = self
        targetWeightTB.delegate = self
        
        // observe text fields to enable sign up button when appropriate
        fullNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        weightTB.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        targetWeightTB.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        //initialize error msg
        self.errorMessageLabel.text = ""
        
        //set picker view default to middle row
        pickerView1.selectRow(weight1.count/2, inComponent: 0, animated: false)
        pickerView2.selectRow(weight1.count/2, inComponent: 0, animated: false)
        
        //try to access health kit to get user's weight
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            let healthStore = HKHealthStore()
            
            //authorization details
            func authorizeHealthKit(completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
                let bodyMassType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
                
                //if not available on this device, return
                if !HKHealthStore.isHealthDataAvailable() {
                    return
                }
                
                //we're only interested in weight data -> bodyMassType
                let readDataTypes: Set<HKSampleType> = [bodyMassType]
                let shareDataTypes: Set<HKSampleType> = [bodyMassType]
                
                //request authorization from user
                healthStore.requestAuthorization(toShare: shareDataTypes, read: readDataTypes) { (success, error) in
                    completion(success, error)
                }
                
            }
            
            //returns the weight entry in Kilos or nil if no data
            func bodyMassKg(completion: @escaping ((_ bodyMass: Double?, _ date: Date?) -> Void)) {
                
                //weight -> bodyMass
                let bodyMassType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
                
                //query for weight value from HealthKit
                let query = HKSampleQuery(sampleType: bodyMassType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
                    if let result = results?.first as? HKQuantitySample {
                        let bodyMassKg = result.quantity.doubleValue(for: HKUnit.pound())
                        //convert to pretty output -> trim .0
                        func forTrailingZero(temp: Double) -> String {
                            let tempVar = String(format: "%g", temp)
                            return tempVar
                        }
                        //update label
                        self.outLabel = forTrailingZero(temp: bodyMassKg)
                        completion(bodyMassKg, result.endDate)
                        return
                    }
                    
                    //no data
                    completion(nil, nil)
                }
                healthStore.execute(query)
            }
            
            //helper function
            authorizeHealthKit { (success, error) in
                if success {
                    //get weight
                    bodyMassKg(completion: { (bodyMass, bodyMassDate) in
                        if bodyMass != nil {
                            
                            //update label
                            DispatchQueue.main.async {
                                if (self.outLabel != "") {
                                    self.weightTB.text = self.outLabel
                                }
                            }
                            
                            print("Success")
                        }
                    })
                    
                }
            }
        }
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // resign first responder for all text fields
        fullNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        weightTB.resignFirstResponder()
        targetWeightTB.resignFirstResponder()
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        
        //resign keyboards
        self.fullNameTF.resignFirstResponder()
        self.emailTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
        self.weightTB.resignFirstResponder()
        self.targetWeightTB.resignFirstResponder()
        
        //hide pickers
        self.pickerView1.isHidden = true
        self.pickerView2.isHidden = true
    }
    
    @IBAction func cancelTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpTouch(_ sender: Any) {
        handleSignUp()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // enable the sign up button if none of the text fields are empty
    @objc func textFieldChanged(_ target:UITextField) {
        
        // check if form is filled (bool)
        let formFilled = fullNameTF.text != nil && fullNameTF.text != "" && emailTF.text != nil && emailTF.text != "" && passwordTF.text != nil && passwordTF.text != "" && weightTB.text != nil && weightTB.text != "" && targetWeightTB.text != nil && targetWeightTB.text != ""
        
        // enable sign up if form is filled
        enableSignUpButton(enabled: formFilled)
    }
    
    // move to other text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        switch textField {
        // if return fullName text field, go to email text field
        case fullNameTF:
            fullNameTF.resignFirstResponder()
            emailTF.becomeFirstResponder()
            break
        // if return email text field, go to password text field
        case emailTF:
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
            break
        // if return password text field, go call handle sign up function
        case passwordTF:
            passwordTF.resignFirstResponder()
            weightTB.becomeFirstResponder()
            break
        case weightTB:
            weightTB.resignFirstResponder()
            break
        case targetWeightTB:
            targetWeightTB.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    // enable or disable the sign up button
    func enableSignUpButton(enabled:Bool) {
        
        // if enabled
        if enabled {
            // if sign up button is enabled
            // set alpha too 100% and set bool isEnabled to true
            signUpButton.alpha = 1.0
            signUpButton.isEnabled = true
        } else {
            // else if sign up button is disabled
            // reduce alpha and set bool isEnabled to false
            signUpButton.alpha = 0.5
            signUpButton.isEnabled = false
        }
        
    }
    
    // declare handle sign up function
    @objc func handleSignUp() {
        
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        // create user in Firebase
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            // if error = nil and user != nil
            if error == nil && user != nil {
                
                self.fullNameTF.resignFirstResponder()
                self.emailTF.resignFirstResponder()
                self.passwordTF.resignFirstResponder()
                
                self.weightTB.resignFirstResponder()
                self.targetWeightTB.resignFirstResponder()
                
                //add them as a new user and add their target weight and current weight
                
                //Here we also want to add a row for that user in our DB
                
                //set up database access/reference
                let uID = Auth.auth().currentUser?.uid
            
                let ref = Database.database().reference()
                
                //add a row for that user with following default values 
                
                ref.child("users/\(uID ?? "userID")/full_name").setValue(self.fullNameTF.text)
                ref.child("users/\(uID ?? "userID")/email").setValue(self.emailTF.text)
                
                ref.child("users/\(uID ?? "userID")/numWeights").setValue("1")
                ref.child("users/\(uID ?? "userID")/currentWeight0").setValue(self.weightTB.text)
                
                ref.child("users/\(uID ?? "userID")/targetWeight").setValue(self.targetWeightTB.text)
                ref.child("users/\(uID ?? "userID")/chestProgress").setValue("0")
                ref.child("users/\(uID ?? "userID")/legsProgress").setValue("0")
                ref.child("users/\(uID ?? "userID")/backProgress").setValue("0")
                ref.child("users/\(uID ?? "userID")/armsProgress").setValue("0")
                ref.child("users/\(uID ?? "userID")/cardioProgress").setValue("0")
    
                // switch to success view
                Helper.helper.switchToSuccessVC()
            } else {
                //print error to console
                print("Error: \(error!.localizedDescription)")
                
                //display error
                self.errorMessageLabel.text = error!.localizedDescription
            }
        }
        
        
    
    }
}
