//
//  ViewController.swift
//  AlertProject
//
//  Created by Yasemin TOK on 17.08.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userSignUpLabel: UILabel!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text == "" { //((userNameText.text?.isEmpty) != false diğer yol
            
            messageAlert(titleInput: "ERROR!", messageInput: "User not found!")
            
        } else if passwordText.text == "" { //((userNameText.text?.isEmpty) != true && (passwordText.text?.isEmpty) != false) diğer yol
        
            messageAlert(titleInput: "ERROR!", messageInput: "Password not found!")
        
        } else if (passwordText.text != passwordAgainText.text) {
            
           messageAlert(titleInput: "ERROR!", messageInput: "Password did not match!")
            
        } else {
            
            messageAlert(titleInput: "SUCCESS", messageInput: "USER OK")
            
        }
        
      /*  let alert = UIAlertController(title: "ERROR!", message: "Username not found!", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in //butona tıklayınca ne  yapsın. default sadece görünüm //eğer altta yazılması gereken bir şey yoksa nil yaz geç
            //button clicked
            print("Button Clicked")
            } //butonla bir aksiyon oluşturup uyarı mesajının içine ekledik
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil) //VCye bir şeyi göster diyor
        //göstermesini istediğimiz "alert", animasyon kullan, gösterildikten sonra bir işlem yapılsın mı : nil */
    }
    
    func messageAlert(titleInput : String, messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

