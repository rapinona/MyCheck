//
//  ViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 02/07/22.
//

import UIKit
import GoogleSignIn

class loginVC: UIViewController{
    
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var SignInButtonGoogle: UIButton!
    @IBOutlet var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sesionIniciada = false
        // Do any additional setup after loading the view.
        // Validar si el usuario ya inició sesión
        GIDSignIn.sharedInstance.restorePreviousSignIn {
            user, error in
            guard let signInUser = user else {
                print ("Ocurrió un error al autenticar \(String(describing: error))")
                        return
                }
            var info = "Nombre: " + (signInUser.profile?.givenName ?? "") + "\n"
            info += "Apellido: " + (signInUser.profile?.familyName ?? "") + "\n"
            info += "Email: " + (signInUser.profile?.email ?? "")
            sesionIniciada = true
        }
        if(sesionIniciada){
            self.performSegue(withIdentifier: "login", sender: nil)
        }
        
        //Redondear los botones
        userTextField.layer.cornerRadius = userTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        registerBtn.setTitle("Register...", for: .normal)
        signInButton.setTitle("Sign In", for: .normal)
        
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
    
    @IBAction func register(_ sender: Any) {
        if(registerBtn.currentTitle == "Register..."){
            print("entro")
            registerBtn.setTitle("Sign In...", for: .normal)
            signInButton.setTitle("Register", for: .normal)
        }else{
            registerBtn.setTitle("Register...", for: .normal)
            signInButton.setTitle("Sign In", for: .normal)
        }
    }
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        if(registerBtn.currentTitle == "Register..."){
            guard let mail = userTextField.text,
                  let pass = passwordTextField.text
            else {
                return
            }
            var mensaje = ""
            if mail == "" {
                mensaje = "Falta el correo"
            }
            else if pass == "" {
                mensaje = "Falta el password"
            }
            else {
                let expresionRegular = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$")
                let coincidencias = expresionRegular.matches(in: mail, range: NSRange(location: 0, length: mail.count))
                if coincidencias.count != 1 {
                    // no hizo match el string con el patron
                    mensaje = "Debe indicar un correo válido"
                }
                else {
                    performSegue(withIdentifier: "login", sender: self)
                }
            }
            
            if mensaje == "" {
                // go to home
                print ("Todo OK... ahora que?")
            }
            else {
                // presentar el mensaje al usuario
                let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        let configuration = GIDConfiguration(clientID: "674182819895-5vg9hg5v894g2uhi5e5s46ugf75v4k21.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: self){
            user,error in
            guard let signInUser = user else{
                print("Ocurrio un error al autenticar ")
                return
            }
            let email =  signInUser.profile?.email ?? ""
            print(email)
            self.performSegue(withIdentifier: "login", sender: Self.self)
        }
    }
    
}

