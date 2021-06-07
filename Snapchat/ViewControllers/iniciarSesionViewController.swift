//
//  ViewController.swift
//  Snapchat
//
//  Created by Javier Flores Càrdenas on 5/26/21.
//  Copyright © 2021 Javier Flores Càrdenas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase

class iniciarSesionViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){(user,error) in
            print("Intentando Iniciar Sesion")
            if error != nil{
                print("Se presentó el siguiente error: \(error!)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user,error) in
                    print("Intentando crear un usuario")
                    if error != nil{
                        print("Se presentó el siguiente error al crear el usuario: \(error)")
                    }else{
                        print("El usuario fué creado exitosamente")
                        Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        
                        let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario \(self.emailTextField.text!) se creo correctamente.", preferredStyle: .alert)
                        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
                            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)})
                        alerta.addAction(btnOK)
                        self.present(alerta, animated: true, completion: nil)
                    }
                })
            }else{
                print("Inicio de sesión exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    @IBAction func iniciarSesionGoogleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil{
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            Auth.auth().signIn(with: credential){(user,error) in
                if error != nil{
                    print("Se presentó el siguiente error: \(String(describing: error))")
                }else{
                    print("Inicio de sesión con google exitoso")
                }
            }
            
        }
    }

}

