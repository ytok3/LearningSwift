//
//  ViewController.swift
//  FaceRecognitionProject
//
//  Created by Yasemin TOK on 25.08.2021.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signinClicked(_ sender: Any) {
        
        let authContext = LAContext() //doğrulama işlemleri için kullanıyoruz.
        
        var error : NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //biometrik okuma kullanarak kişinin kullanıcı olup olmadığını anlamaya çalışıyor
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                if success == true {
                    //başaralı olmuştur.
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
        }
        
    }
    
}

