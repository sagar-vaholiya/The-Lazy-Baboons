//
//  SubmitComplainController.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 20/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Gloss

class SubmitComplaintController: UIViewController {
    
    @IBOutlet weak var txtRName: UITextField!
    @IBOutlet weak var txtRNumber: UITextField!
    @IBOutlet weak var txtCName: UITextField!
    @IBOutlet weak var txtCNumber: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtLat: UITextField!
    @IBOutlet weak var txtLong: UITextField!
    @IBOutlet weak var txtAsset: UITextField!
    @IBOutlet weak var twDesc: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var model = SubmitCompModel()
    
    var inputViews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Submit complaint"
        
        self.setUp()
    }
    
    func setUp() {
        
        //Set global values
        
        if let obj = defaults.getCustomObject(key: "userObject") as? JSON {
            
            let userObj = ClsLogin(json: obj)
            self.txtAsset.text = userObj?.data.asset
            
        }
        
        guard let dic = defaults.getCustomObject(key: "savedLocation") as? [String : String] else {
            assertionFailure("Could not get location.")
            return
        }
        
        self.txtLat.text = dic["lat"]
        self.txtLong.text = dic["long"]
        
        
        inputViews = [txtRName,txtRNumber,txtCName,txtCNumber,txtTitle,twDesc,txtAsset,txtLat,txtLong,btnSubmit]
        
        self.twDesc.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 8, right: 16)
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.applyShadowToView(views: inputViews)
        
    }
    
    func validateInputs(completionHandler: @escaping (Bool) -> ()) {
        
        var isValidated = true
        
        if self.txtRName.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtRName)
            isValidated = false
        }
        else if self.txtRNumber.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtRNumber)
            isValidated = false
        }
        else if self.txtCName.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtCName)
            isValidated = false
        }
        else if self.txtCNumber.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtCNumber)
            isValidated = false
        }
        else if self.txtTitle.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtTitle)
            isValidated = false
        }
        else if self.txtAsset.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtAsset)
            isValidated = false
        }
        else if self.txtLat.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtLat)
            isValidated = false
        }
        else if self.txtLong.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.txtLong)
            isValidated = false
        }
        else if self.twDesc.text?.count == 0 {
            
            showErrorAndMakeResponder(textField: self.twDesc)
            isValidated = false
        }
        
        completionHandler(isValidated)
    }
    
    func showErrorAndMakeResponder(textField : UIView) {
        
        textField.becomeFirstResponder()
        UIView.animate(withDuration: 1.0, animations: {
            textField.backgroundColor = UIColor(red:0.97, green:0.56, blue:0.52, alpha:1.0)
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, animations: {
                textField.backgroundColor = UIColor.white
            })
        }
        
        
    }

    @IBAction func submitNewComplaint(_ sender: UIButton) {
        
        self.validateInputs { (isValidated) in
            
            if !isValidated {
                
                return
            }
            else {
                
                
                let submitCompRequest = SubmitComplaintRequest(rname: self.txtRName.text!, rnum: self.txtRNumber.text!, cname: self.txtCName.text!, cnum: self.txtCNumber.text!, lat: self.txtLat.text!, long: self.txtLong.text!, asset: self.txtAsset.text!, title: self.txtTitle.text!, desc: self.twDesc.text)
                
                self.model.callSubmitComplaint(requestObj: submitCompRequest, completionHandler: { (success, message) in
                    
                    if success {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        
                        self.showAlertViewWith(title: kAlertTitle, message: message!)
                    }
                })
                
            }
        }
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SubmitComplaintController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       return true
    }
}
