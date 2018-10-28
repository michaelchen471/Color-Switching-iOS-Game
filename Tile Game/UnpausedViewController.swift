//
//  UnpausedViewController.swift
//  Tile Game
//
//  Created by Michael Chen on 10/25/18.
//  Copyright © 2018 Codeology. All rights reserved.
//

import UIKit

class UnpausedViewController: UIViewController {
    
    var timer1 = Timer()
    var timing = 0
    var scores = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        scoreLabel.text = String(scores)
        timerLabel.text = String(timing)
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    @objc func timerUpdate() {
        timing -= 1
        timerLabel.text = String(timing)
    }
    
    @IBAction func playButton(_ sender: Any) {
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
