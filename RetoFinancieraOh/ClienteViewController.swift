//
//  ClienteViewController.swift
//  RetoFinancieraOh
//
//  Created by Cesar Sosa  on 24/04/19.
//  Copyright © 2019 Cesar Sosa . All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase


class ClienteViewController: UIViewController {
 
    let ref = Database.database().reference(withPath: "client-items")

    @IBOutlet weak var apellidoUITextField: UITextField!
    
    @IBOutlet weak var edadUITextField: UITextField!
    
    @IBOutlet weak var nombresUITextField: UITextField!
    
    @IBOutlet weak var fechaNacimientoUITextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    @IBAction func save(_ sender: Any) {

        let clientItem = Client(nombres: nombresUITextField.text!, apellidos: apellidoUITextField.text!, edad: edadUITextField.text!, fechaNacimiento: fechaNacimientoUITextField.text!)
        
        let clientItemRef = self.ref.childByAutoId()
        
        clientItemRef.setValue(clientItem.toAnyObject())
        
        self.showToast(controller: self, message: "Se ha insertado en Firebase correctamente.", seconds: 2.0)
        
        nombresUITextField.text = "";
        apellidoUITextField.text = "";
        edadUITextField.text = "";
        fechaNacimientoUITextField.text = "";
        
        saveButton.isEnabled = false
        
    }
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    func setupAddTargetIsNotEmptyTextFields() {
        saveButton.isEnabled = false //hidden okButton
        nombresUITextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
        apellidoUITextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
        fechaNacimientoUITextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                              for: .valueChanged)
    }
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let nombre = nombresUITextField.text, !nombre.isEmpty,
            let apellido = apellidoUITextField.text, !apellido.isEmpty,
            let fechaNacimiento = fechaNacimientoUITextField.text,!fechaNacimiento.isEmpty
            else
        {
            self.saveButton.isEnabled = false
            return
        }
        // enable okButton if all conditions are met
        saveButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back1.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        
        showDatePicker()
        setupAddTargetIsNotEmptyTextFields();
        
    }
    
    @IBAction func log(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        self.performSegueToReturnBack()

    }
    

    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // remove left buttons (in case you added some)
        self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        fechaNacimientoUITextField.inputAccessoryView = toolbar
        fechaNacimientoUITextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        fechaNacimientoUITextField.text = formatter.string(from: datePicker.date)
        edadUITextField.text = "\(datePicker.date.age)"
        
        self.view.endEditing(true)
        
        textFieldsIsNotEmpty(sender: self.fechaNacimientoUITextField)
        
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
}

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

