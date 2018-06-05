//
//  ViewController.swift
//  LoadingBarAnimation
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: CountingLabel!
    private let shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCircle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

}

extension ViewController {
    private func drawCircle(){
        //let shapeLayer = CAShapeLayer()
        let center = view.center
        print(view.center)
        //remember the default start angle is started from the east
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        //create my track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        view.layer.addSublayer(trackLayer)
       
        
        //shapeLayer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        // make the head round
        shapeLayer.lineCap = kCALineCapRound
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    @objc private func handleTap(){
        print("hihi")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 0.5
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        counterLabel.count(fromValue: 0, to: 50, withDuration: 2, andAnimationType: .EaseOut, andCounterType: .Int)
    }
}






