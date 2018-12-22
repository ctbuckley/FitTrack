//
//  SettingsVC.swift
//  FitTrack
//
//  Created by Connor Buckley on 12/3/18.
//  Copyright © 2018 Connor Buckley. All rights reserved.
//

import UIKit
import Firebase
import HealthKit

class SettingsVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource   {
    
    //outlets
    
    private let model = dataModel.sharedInstance
    
    //log out just calls helper
    @IBAction func logOutButton(_ sender: Any) {
         Helper.helper.logOut()
    }
    
    
    //outlets
    @IBOutlet weak var currentWeightSettingTF: UILabel!
    @IBOutlet weak var targetWeightSettingTF: UILabel!
    @IBOutlet weak var currentWeightTF: UITextField!
    @IBOutlet weak var targetWeightTF: UITextField!
    
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var currentWeightVal: UILabel!
    @IBOutlet weak var targetWeightVal: UILabel!
    
    //update settings means a new weight entry
    
    @IBAction func updateSettingsButton(_ sender: Any) {
        
        //update settings in DB
        //add data point to model/data persistence/database
        
        //update textFields on this page to display updated settings
        
        //add a new data entry
        //get numWeights
        // let i = numWeights + 1
        //add currentWeighti -> data value
        
        //read new weight entry
        
        let weight = Double(currentWeightTF.text!)
        let target = Double(targetWeightTF.text!)
        
        //update UI
        
        self.currentWeightVal.text = String(weight!)
        self.targetWeightVal.text = String(target!)
        
        //send data to HealthKit health app
        
        let healthKitStore:HKHealthStore = HKHealthStore()
        
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass) {
            let date = Date()
            let quantity = HKQuantity(unit: HKUnit.pound(), doubleValue: weight!)
            let sample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
            healthKitStore.save(sample, withCompletion: { (success, error) in
                print("Saved")
            })
        }
        
        //convert to double
        
        let targetWeight = Double(targetWeightTF.text!)
        
        
        //update in model
        model.currentWeight = weight!
        model.targetWeight = targetWeight!
        model.numbers.append(weight!)
        
        
        //set up database access
        let ref = Database.database().reference()
        //ref.child("users/\(uID ?? "userID")/numWeights")
        
        let userID = Auth.auth().currentUser?.uid
        
        //update the database
        //observe data
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let numEntries = value?["numWeights"] as? String ?? ""

            //convert numEntries and increment it by 1 to signify adding a new entry
            var numPP = Int(numEntries)!
            numPP += 1
            
            //add a new entry
            ref.child("users/\(userID ?? "userID")/numWeights").setValue("\(numPP)")
            
            numPP -= 1
            let numPPStr = String(numPP)
            
            ref.child("users/\(userID ?? "userID")/currentWeight" + numPPStr).setValue(self.currentWeightTF.text!)
            ref.child("users/\(userID ?? "userID")/targetWeight").setValue("\(self.model.targetWeight)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    //set up picker view data source
    
    //currentweight
    let weight1 = ["50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "300"]
    
    //targetweight
    let weight2 = ["50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "219", "220", "221", "222", "223", "224", "225", "226", "227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255", "256", "257", "258", "259", "260", "261", "262", "263", "264", "265", "266", "267", "268", "269", "270", "271", "272", "273", "274", "275", "276", "277", "278", "279", "280", "281", "282", "283", "284", "285", "286", "287", "288", "289", "290", "291", "292", "293", "294", "295", "296", "297", "298", "299", "300"]
    
    
    //picker functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var countrows : Int = weight1.count
        
        if pickerView == pickerView2 {
            
            countrows = self.weight2.count
        }
        
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //Picker for Current Weight
        if pickerView == pickerView1 {
            let titleRow = weight1[row]
            return titleRow
        }
            
        //Picker for Target Weight
        else if pickerView == pickerView2{
            let titleRow = weight2[row]
            return titleRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Picker for Current Weight
        if pickerView == pickerView1 {
            self.currentWeightTF.text = self.weight1[row]
            self.pickerView1.isHidden = true
        }
           
        //Picker for Target Weight
        else if pickerView == pickerView2{
            self.targetWeightTF.text = self.weight2[row]
            self.pickerView2.isHidden = true
            
        }
        
        // check if form is filled (bool)
        let formFilled =  currentWeightTF.text != nil && currentWeightTF.text != "" && targetWeightTF.text != nil && targetWeightTF.text != ""
        
        // enable sign up if form is filled
        enableUpdateSettings(enabled: formFilled)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        //make sure we only show the picker for current weight
        if (textField == self.currentWeightTF){
            self.pickerView1.isHidden = false
            self.pickerView2.isHidden = true
        }
            
        //make sure we only show the picker for target weight
        else if (textField == self.targetWeightTF){
           
            self.pickerView2.isHidden = false
            self.pickerView1.isHidden = true
            
        }
        
        //we don't want to show either picker
        else {
            self.pickerView2.isHidden = true
            self.pickerView1.isHidden = true
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //don't display keyboard for fields we use picker on
        if (textField == self.currentWeightTF){
            self.currentWeightTF.resignFirstResponder()
            self.targetWeightTF.resignFirstResponder()
        }
            
        //don't display keyboard for fields we use picker on
        else if (textField == self.targetWeightTF){
            self.currentWeightTF.resignFirstResponder()
            self.targetWeightTF.resignFirstResponder()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // disable sign up button by default
        enableUpdateSettings(enabled: false)
        
        // declare delegates
        currentWeightTF.delegate = self
        targetWeightTF.delegate = self
        
        // observe text fields to enable sign up button when appropriate
        currentWeightTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        targetWeightTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        //set picker views to middle row
        pickerView1.selectRow(weight1.count/2, inComponent: 0, animated: false)
        pickerView2.selectRow(weight1.count/2, inComponent: 0, animated: false)
        
        
        
        //initialize textfields
        currentWeightVal.text = model.getCurrentWeight()
        targetWeightVal.text = model.getTargetWeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // resign first responder for all text fields
        currentWeightTF.resignFirstResponder()
        targetWeightTF.resignFirstResponder()
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        
        //resign first responde for all text fields
        self.currentWeightTF.resignFirstResponder()
        self.targetWeightTF.resignFirstResponder()
        
        //hide all picker views
        self.pickerView1.isHidden = true
        self.pickerView2.isHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // enable the sign up button if none of the text fields are empty
    @objc func textFieldChanged(_ target:UITextField) {
        
        // check if form is filled (bool)
        let formFilled = currentWeightTF.text != nil && currentWeightTF.text != "" && targetWeightTF.text != nil && targetWeightTF.text != ""
        
        // enable setting update if form is filled
        enableUpdateSettings(enabled: formFilled)
    }
    
    // move to other text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField
        switch textField {
        case currentWeightTF:
            currentWeightTF.resignFirstResponder()
            break
        case targetWeightTF:
            targetWeightTF.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    // enable or disable the sign up button
    func enableUpdateSettings(enabled:Bool) {
        
        // if enabled
        if enabled {
            // if sign up button is enabled
            // set alpha too 100% and set bool isEnabled to true
            settingsButton.alpha = 1.0
            settingsButton.isEnabled = true
        } else {
            // else if sign up button is disabled
            // reduce alpha and set bool isEnabled to false
            settingsButton.alpha = 0.5
            settingsButton.isEnabled = false
        }
        
    }
    
    
    
    
    
}
