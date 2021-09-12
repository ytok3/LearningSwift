//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Yasemin TOK on 19.08.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //bağlantı için id yeterli olacaktır.
    
    var nameArray  = [String] ()
    var idArray = [UUID] ()
    
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        //barButtonSystemItem ekleme kamera vs için hazır görsel verir.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
        navigationItem.title = "Art Book"
        
    }
    
    override func viewWillAppear(_ animated: Bool) { //her VC açıldığında  çağrılacak çünkü viewLoad sadece bir kere çalışır
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil) //bir gözlemci oluşturduk. gelen bildirim var mı varsa hangisi diye bakıyor.
        //selector ise getData yapılabilir.
    }
    
    @objc func getData () {
        
        nameArray.removeAll(keepingCapacity: false) //tableView'de veriler sadece bir kere gözüksün
        idArray.removeAll(keepingCapacity: false) //çünkü birden fazla defa datacore'dan veri çekiyoruz
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //kaydedilen verilere erişmek için datacore'a ulaştık
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        //sonuçlarını alabilmek için bir istek oluşturuyoruz
        fetchRequest.returnsObjectsAsFaults = false //arkaplanda yapılan bir okuma işlemi daha verimli oldu, çok büyük veri için verimli olacaktır.
        
        do {
            
            let results = try context.fetch(fetchRequest) //geri dönen cevap bir dizi içinde olacak
        
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {  //dizi içinde gelenlerden sadece birine odaklanmak için
                    if let name = result.value(forKey: "name") as? String { //eğer bu gerçekleşirse gelen veriyi String olarak kaydet ve işlem yap
                        self.nameArray.append(name)
                        
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        
                        self.idArray.append(id)
                        
                    }
                    self.tableView.reloadData() // yeni veri kendini güncelle
                }
            }
        } catch {
            print("error")
    }
}
    
    @objc func addButtonClicked() {
        
        selectedPainting = "" // +ya tıklandıysa görsel seçilmedi
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
            //seçilen ismin hem ismini hem idsini diğer tarafa aktarmış olduk.
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row] //bir isme tıklandığındaysa bir isme tıklandı uyarısı (arka planda)
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { //silme işlemi yapıyoruz
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[indexPath.row].uuidString //nereye tıklandıysa onun idsini bul
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            if id  == idArray[indexPath.row] {
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                } catch{
                                    print("error")
                                }
                                
                                break //aradığım şeyi bulup silersem bırak
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }
    
}

