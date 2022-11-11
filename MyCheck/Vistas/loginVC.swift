//
//  ViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 02/07/22.
//

import UIKit

class loginVC: UIViewController{
    
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var empleadoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Redondear los botones
        userTextField.layer.cornerRadius = userTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        
        //Oscurecer los placeholders
        if let placeholder = userTextField.placeholder {
            userTextField.attributedPlaceholder = NSAttributedString(string:placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)])
        }
        
        if let placeholder = passwordTextField.placeholder {
            passwordTextField.attributedPlaceholder = NSAttributedString(string:placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)])
        }
        
    }
}

