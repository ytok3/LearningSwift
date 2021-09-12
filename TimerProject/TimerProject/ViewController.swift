//
//  ViewController.swift
//  TimerProject
//
//  Created by Yasemin TOK on 17.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
       //timeLabel.text = "Time :  \(counter)"
        timeLabel.text = "Time : \(0)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true) //scheduled planlanmış demek
        //1 saniyede bir tekrarlasın
        //hedef VCnin kendisi
        //selector için func oluşturduk
        //kullanıcıya bilgi gidecek mi? hayır
        //tekrar ediyor mu? evet
        
    }
    
    @objc func timerFunction () {
        
        timeLabel.text = "Time : \(counter)"
        counter -= 1
        
        if counter == 0 {
            
            timer.invalidate() // counterı durdurur
            timeLabel.text = "Time's Over"
        }
        
    }

    @IBAction func buttonClicked(_ sender: Any) {
    }
    
}

