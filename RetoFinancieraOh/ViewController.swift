//
//  ViewController.swift
//  RetoFinancieraOh
//
//  Created by Cesar Sosa  on 24/04/19.
//  Copyright © 2019 Cesar Sosa . All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth
import LocalAuthentication

class ViewController: UIViewController, GIDSignInUIDelegate, UITextFieldDelegate {

    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        
        GIDSignIn.sharedInstance().uiDelegate = self
        phoneTextField.delegate = self
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        self.phoneTextField.inputAccessoryView = toolbar
        
    }
    
    @IBAction func LoginBio(_ sender: Any) {
        
        self.stateLabel.text = ""
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            self.stateLabel.text = "Bienvenido"
                            self.redirec(withIdentifier: "toClientVC")
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            self.stateLabel.text = "Disculpa, no se logró hacer la verificacion"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                stateLabel.text = "No se pudo evaluar Policy."
            }
        } else {
            // Fallback on earlier versions
            
            stateLabel.text = "No esta soportada la biometria."
        }
       
    }
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBAction func validarNumber(_ sender: Any) {
        self.stateLabel.text = ""
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneTextField.text!, uiDelegate: nil) { (verificationID, error) in
            
            if error != nil {
                
                return
                
            }
            
            self.redirec(withIdentifier:"toClientVC")
            }
    }
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if error != nil
        {
            self.stateLabel.text = "Error en la autenticacion por Google"
        }
    }
    func redirec(withIdentifier identifier:String)
    {
        self.stateLabel.text = ""
        self.performSegue(withIdentifier: identifier, sender: self)
     }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

