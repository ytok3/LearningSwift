//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Yasemin TOK on 18.08.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var landmarkNames = [String] ()
    var landmarksImages = [UIImage]()
    
    var chosenLandmarkName = ""
    var chosenLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self // delegate ve datasource selfe yanı VCye eşit olmalı ki alttaki funclar çalışabilsin.
        tableView.dataSource = self
        
        //landmarkBook data
        landmarkNames.append("Mercedes")
        landmarkNames.append("Redbull")
        landmarkNames.append("Ferrari")
        landmarkNames.append("Mclaren")
    
        landmarksImages.append(UIImage(named: "mclaren")!)
        landmarksImages.append(UIImage(named: "mclaren")!)
        landmarksImages.append(UIImage(named: "mclaren")!)
        landmarksImages.append(UIImage(named: "mclaren")!)
        
        navigationItem.title = "Landmark Book" 
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { //kullanıcı rowları çekip silmek istiyorsa
            landmarkNames.remove(at: indexPath.row)
            landmarksImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landmarkNames[indexPath.row] //diziye göre kendisi indexPath ile sıralayacak
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenLandmarkName = landmarkNames[indexPath.row]
        chosenLandmarkImage = landmarksImages[indexPath.row]
        
        performSegue(withIdentifier: "toImageVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //segue olmadan önce yapılacak işlem
        
        if segue.identifier == "toImageVC" {
            
            let destinationVC = segue.destination as! imageViewController //tanımla ve imageVCye gönder
            destinationVC.selectedLandmarkName = chosenLandmarkName
            destinationVC.selectedLandmarkImage = chosenLandmarkImage
        }
        
    }
}

