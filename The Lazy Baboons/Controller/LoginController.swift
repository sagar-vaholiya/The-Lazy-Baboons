//
//  ViewController.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 17/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import UIKit
import ReachabilitySwift
import JVFloatLabeledTextField

class LoginController: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    let loginModel = LoginModel()
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginModel.askForLocationIfNeeded()
        
        self.txtUsername.text = "zicom1"
        self.txtPassword.text = "aaaaaa"
        
        print(txtPassword.frame.size.width)
        
        
        self.setUp {
            
            self.animate()
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillLayoutSubviews() {
        
        
    }
    
    func setUp(completion : @escaping () ->()) {
        
        self.txtUsername.setLeftIcon(#imageLiteral(resourceName: "user"))
        self.txtUsername.leftViewMode = .always
        

        self.txtPassword.setLeftIcon(#imageLiteral(resourceName: "lock"))
        self.txtPassword.leftViewMode = .always

        self.applyShadowToView(views: [btnLogin,txtUsername,txtPassword])
        
        completion()
    }
    
    func animate() {
        
        self.txtUsername.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.txtPassword.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.btnLogin.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)

        UIView.animate(withDuration: 2.0, delay: 0.8, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
            self.imgLogo.transform = CGAffineTransform(translationX: 0, y: -(ScreenSize.SCREEN_HEIGHT * 0.2))
        }, completion: { (finished) in
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                
                self.txtUsername.applyTransform(withScale: 1, anchorPoint: CGPoint(x: 0, y: 0.5))
                self.txtUsername.alpha = 1.0
                
            }, completion: { (finished) in
                
                UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                    
                    self.txtPassword.applyTransform(withScale: 1, anchorPoint: CGPoint(x: 1, y: 0.5))
                    self.txtPassword.alpha = 1.0
                    
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 7.0, options: .curveEaseInOut, animations: {
                        
                        self.btnLogin.applyTransform(withScale: 1, anchorPoint: CGPoint(x: 0.5, y: 1.0))
                        self.btnLogin.alpha = 1.0
                        
                    }, completion: nil)
                    
                    
                })
                
                
            })

        })

        
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        
        
        self.loginModel.hasLocation { (hasLocation) in
            
            if hasLocation {
                
                self.loginModel.callLoginAPI(username: self.txtUsername.text!, password: self.txtPassword.text!) { (isAuthorized, message) in
                    
                    if !isAuthorized {
                        
                        self.showAlertViewWith(title: kAlertTitle, message: message!)
                    }
                    else {
                        
                        //Redirect to next screen
                        self.performSegue(withIdentifier: "goToList", sender: self)
                    }
                }
                
            }
        }
        

        
        
        
    }
    


}


