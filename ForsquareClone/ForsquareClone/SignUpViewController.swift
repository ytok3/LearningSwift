//
//  ViewController.swift
//  ForsquareClone
//
//  Created by Yasemin TOK on 1.09.2021.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Funcs
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    //hiçbir hata yoksa kısmı
                    //segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
            
            
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username and Password??")
        }
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                    
                } else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        } else {
            
            makeAlert(titleInput: "ERROR!", messageInput: "Username and Password is neccessary")
            
        }
        
        
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}

