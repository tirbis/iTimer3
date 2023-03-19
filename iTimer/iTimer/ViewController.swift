//
//  ViewController.swift
//  iTimer
//
//  Created by Тирбулатов Ислам Асланович on 13/3/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet weak var timerr: UILabel!
    @IBOutlet weak var startbutton: UIButton!
    @IBOutlet weak var stopbutton: UIButton!
    @IBOutlet weak var resetbutton: UIButton!
    @IBOutlet weak var lapbutton: UIButton!
    
    @IBOutlet weak var lap_1: UILabel!
    @IBOutlet weak var lap_2: UILabel!
    @IBOutlet weak var lap_3: UILabel!
    
    @IBOutlet weak var backgr1: UIImageView!
    @IBOutlet weak var backgr2: UIImageView!
    @IBOutlet weak var backgr3: UIImageView!
    @IBOutlet weak var backgr4: UIImageView!
    @IBOutlet weak var backgr5: UIImageView!
    @IBOutlet weak var backgr6: UIImageView!

    
    var l1 = 0
    var l2 = 0
    var l3 = 0
    
    var bgtask = 0
    var timer = Timer()
    var fractions: Int = 0
    var seconds: Int = 0
    var minutes: Int = 0
    
    var lapRecorded: String = ""
    
    var timerStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timerr.text = "00:00.00"
        
        startbutton.isEnabled = true
        stopbutton.isEnabled = false
        resetbutton.isEnabled = false
        lapbutton.isEnabled = false
        
        lap_1.isHidden = true
        lap_2.isHidden = true
        lap_3.isHidden = true
        
    }

    @IBAction func startTimerr(_ sender: Any) {
        if timerStarted == false {
            
            if bgtask == 0 {
                bgtask = 1
                registerBackgroundTask()
            }
            timerStarted = true
            
            inBackground()
            
            startbutton.isEnabled = false
            stopbutton.isEnabled = true
            resetbutton.isEnabled = true
            lapbutton.isEnabled = true
        }
    }
    
    @IBAction func stopTimerr(_ sender: Any) {
        
        if timerStarted == true {
            timerStarted = false
            timer.invalidate()
            resetbutton.isEnabled = false
            startbutton.isEnabled = true
            resetbutton.isEnabled = true
            lapbutton.isEnabled = false
            
            if bgtask == 1{
                endBackgroundTask()
                bgtask = 0
            }
        }
    }
    
    @IBAction func resetTimerr(_ sender: Any) {
        
        timer.invalidate()
        
         fractions = 0
         seconds = 0
         minutes = 0
        
         timerStarted = false
        
        startbutton.isEnabled = true
        stopbutton.isEnabled = false
        resetbutton.isEnabled = false
        lapbutton.isEnabled = false
        
        timerr.text = "00:00.00"
        
        lap_1.isHidden = true
        lap_2.isHidden = true
        lap_3.isHidden = true
        l1 = 0
        l2 = 0
        l3 = 0
        
        if bgtask == 1{
            endBackgroundTask()
            bgtask = 0
        }
    }
    
    @IBAction func lapTimerr(_ sender: Any) {
        
        lapRecorded = timerr.text!
        
        if l1 == 0 {
            
            lap_1.isHidden = false
            lap_1.text = "  Lap: \(lapRecorded)"
            l1 = 1
            
        } else if l2 == 0 {
            
            lap_2.isHidden = false
            lap_2.text = lap_1.text
            lap_1.text = "  Lap: \(lapRecorded)"
            l2 = 1
            
        } else if l3 == 0 {
            
            lap_3.isHidden = false
            lap_3.text = lap_2.text
            lap_2.text = lap_1.text
            lap_1.text = "  Lap: \(lapRecorded)"
            l3 = 1
            
        } else {
            
            lap_3.text = lap_2.text
            lap_2.text = lap_1.text
            lap_1.text = "  Lap: \(lapRecorded)"
            
        }
        
    }
    
    
    
    func inBackground() {
        //call endBackgroundTask() on completion..
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }
    
    func endBackgroundTask() {
        
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }
    
    
    @objc func updateTimer(){
        fractions += 1
        
        if fractions == 100 {
            fractions = 0
            seconds += 1
        }
        
        if seconds == 60 {
            seconds = 0
            minutes += 1
        }
        
        
        let fracStr: String = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secStr: String = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minStr: String = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        timerr.text = "\(minStr):\(secStr).\(fracStr)"
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
