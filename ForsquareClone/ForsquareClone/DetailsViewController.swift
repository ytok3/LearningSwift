//
//  DetailsViewController.swift
//  ForsquareClone
//
//  Created by Yasemin TOK on 2.09.2021.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && commentText.text != "" {
            
            if let chosenImage = imageView.image {
                
                
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeComment = commentText.text!
                placeModel.placeImage = chosenImage
                
            }
            
            performSegue(withIdentifier: "toMapVC", sender: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Error!", message: "Fields cannot be left blank", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func chooseImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
