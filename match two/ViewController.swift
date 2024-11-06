//
//  ViewController.swift
//  match two
//
//  Created by Aila Aila on 01.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var stepCountLabel: UILabel!
    
    
    var imageNames = [ "c", "c",
                       "d", "d",
                       "e", "e",
                       "f", "f",
                       "g", "g",
                       "h", "h",
                       "i", "i",
                       "j","j" ]
    
    var isOpened = false
    var previousButtonTag = 0
    var isTimerEnabled = false
    var count = 0
    
    var steps = 0 {
        didSet {
            stepCountLabel.text = "Steps: " + String(steps)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }

    func clear(){
        
        imageNames.shuffle()
        
        steps = 0
        count = 0
        
        for i in 1...16 {
            
            let button = view.viewWithTag(i) as! UIButton
            
            button.setBackgroundImage(nil, for: .normal)
            
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "WIN!!!", message: "Play again?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.clear()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func game(_ sender: UIButton) {
        
        if isTimerEnabled == true {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: imageNames[sender.tag - 1]), for: .normal)
        
        if isOpened == true {
        steps += 1
            
            if imageNames[sender.tag - 1] == imageNames[previousButtonTag - 1] {
                count += 1
                
            } else {
            isTimerEnabled = true
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    sender.setBackgroundImage(nil, for: .normal)
                
                    let previousButton = self.view.viewWithTag(self.previousButtonTag) as!
                    UIButton
                    
                    previousButton.setBackgroundImage(nil, for: .normal)
                    
                    self.isTimerEnabled = false
                    
                }
            }
            
        } else {
            
            previousButtonTag = sender.tag // 1
            
        }
        
        isOpened.toggle()
        
        if count == 8 {
            showAlert()
        }
        
    }
    
    
    
    
    
    
    
    
}

