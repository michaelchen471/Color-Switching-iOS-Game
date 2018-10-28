//
//  PauseScreenViewController.swift
//  Tile Game
//
//  Created by Michael Chen on 10/4/18.
//  Copyright © 2018 Codeology. All rights reserved.
//

import UIKit

class PauseScreenViewController: UIViewController {

    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var TimeKeep: UILabel!
    @IBOutlet weak var score: UILabel!
    
    var array: [CAShapeLayer] = []
    
    var timer = Timer()
    var time = 60
    
    var currScore = 0
    
    var xRangeLow: CGFloat = -1
    var xRangeHigh: CGFloat = -1
    var yRangeLow:CGFloat = -1
    var yRangeHigh:CGFloat = -1
    
    var randomRed:CGFloat = 0
    var randomGreen:CGFloat = 0
    var randomBlue:CGFloat = 0
    
    override func viewDidLoad() {
        score.text = "Score: " + String(currScore)
        playButton.isHidden = true
        homeButton.isHidden = true
        restartButton.isHidden = true
        drawGrid()
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func play(_ sender: Any) {
        playButton.isHidden = true
        homeButton.isHidden = true
        restartButton.isHidden = true
        for i in 0...(array.count - 1) {
            array[i].isHidden = false
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        playButton.isHidden = false
        homeButton.isHidden = false
        restartButton.isHidden = false
        for i in 0...(array.count - 1) {
            array[i].isHidden = true
        }
        timer.invalidate()
    }
    
    @IBAction func restart(_ sender: Any) {
        playButton.isHidden = true
        homeButton.isHidden = true
        restartButton.isHidden = true
        currScore = 0
        drawGrid()
        time = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timerUpdate() {
        time -= 1
        TimeKeep.text = String(time)
    }
    
    func drawGrid() {
        let x: CGFloat = view.frame.size.width / 3.5
        let y: CGFloat = view.frame.size.height / 3.5
        let size: CGFloat = x - 10
        let random = Int.random(in: 1 ..< 9)
        var counter = 0
        let color = randomColor()
        
        for indexx in 1...3 {
            for indexy in 1...3 {
                let startx: CGFloat = -73 + x * CGFloat(indexx)
                let starty: CGFloat = 100 + y + (CGFloat(indexy) - 1) * x
                if (counter == random) {
                    drawRect(x: startx, y: starty, size: size, color: offsetColor())
                    xRangeLow = startx
                    xRangeHigh = startx + size
                    yRangeLow = starty
                    yRangeHigh = starty + size
                } else {
                    drawRect(x: startx, y: starty, size: size, color: color)
                }
                counter += 1
            }
        }
        score.text = String(currScore)
    }
    
    func drawRect(x: CGFloat, y: CGFloat, size: CGFloat, color: UIColor) {
        let layer = CAShapeLayer()
        array.append(layer)
        layer.path = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: size, height: size), cornerRadius: 15).cgPath
        layer.fillColor = color.cgColor
        view.layer.addSublayer(layer)
    }
    
    func randomColor() -> UIColor {
        randomRed = CGFloat(drand48())
        randomGreen = CGFloat(drand48())
        randomBlue = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func offsetColor() -> UIColor {
        var offsetRed = randomRed
        var offsetGreen = randomGreen
        var offsetBlue = randomBlue
        let rand = Int.random(in: 1 ..< 4)
        if (rand == 1) {
            while (offsetRed == randomRed) {
                offsetRed = CGFloat(drand48())
            }
        } else if (rand == 2) {
            while (offsetGreen == randomGreen) {
                offsetGreen = CGFloat(drand48())
            }
        } else {
            while (offsetBlue == randomBlue) {
                offsetBlue = CGFloat(drand48())
            }
        }
        return UIColor(red: offsetRed, green: offsetGreen, blue: offsetBlue, alpha: 1.0)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: view)
            if (location.x > xRangeLow && location.x < xRangeHigh && location.y > yRangeLow && location.y < yRangeHigh) {
                currScore += 1
                drawGrid()
            } else {
                let _: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard?.instantiateViewController(withIdentifier: "gameOver") as! GameOverViewController
                vc.score = currScore
                self.present(vc, animated: true, completion: nil)
            }
            print(location.x, " ", location.y)
        }
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
