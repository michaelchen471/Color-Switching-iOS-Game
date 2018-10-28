//
//  GameOverViewController.swift
//  Tile Game
//
//  Created by Michael Chen on 10/18/18.
//  Copyright © 2018 Codeology. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: " + String(score)
        // Do any additional setup after loading the view.
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
