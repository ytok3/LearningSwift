//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Yasemin TOK on 19.08.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var mySimpsons = [Simpson] ()
    
    var chosenSimpson : Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //simpson object
        
        let homer = Simpson(nameInit: "Homer", jobInit: "Nuclear Safety", imageInit:UIImage(named: "homer")!)
        let marge = Simpson(nameInit: "Marge", jobInit: "Housewife", imageInit:UIImage(named: "marge")!)
        let bart = Simpson(nameInit: "Bart", jobInit: "Student", imageInit:UIImage(named: "bart")!)
        let lisa = Simpson(nameInit: "Lisa", jobInit: "Student", imageInit:UIImage(named: "lisa")!)
        let maggie = Simpson(nameInit: "Maggie", jobInit: "Baby", imageInit:UIImage(named: "maggie")!)
        
        mySimpsons.append(homer)
        mySimpsons.append(marge)
        mySimpsons.append(bart)
        mySimpsons.append(lisa)
        mySimpsons.append(maggie)
        
        navigationItem.title = "Simpsons Book"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mySimpsons[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenSimpson = mySimpsons[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            mySimpsons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }

}

