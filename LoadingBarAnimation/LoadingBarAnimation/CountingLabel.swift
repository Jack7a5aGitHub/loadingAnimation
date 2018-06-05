//
//  CountingLabel.swift
//  LoadingBarAnimation
//
//  Created by Jack Wong on 2018/06/05.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

class CountingLabel: UILabel {
    
    let counterVelocity : Float = 3.0
    
    enum CounterAnimationType {
        case Linear // f(x) = x
        case EaseIn // f(x) = x^3
        case EaseOut // f(x) = (1-x) ^ 3
     }
    
    enum CounterType {
        case Int
        case Float
    }
    var startNumber: Float = 0.0
    var endNumber: Float = 0.0
    var progress: TimeInterval!
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!
    
    var counterType : CounterType!
    var counterAnimationType: CounterAnimationType!
    
    var currentCounterValue: Float {
        if progress >= duration {
            return endNumber
        }
        let percentage = Float(progress/duration)
        let update = updateCounter(counterValue: percentage)
        return startNumber + (update * (endNumber - startNumber))
    }
    var timer: Timer?
    
    func count(fromValue: Float,to toValue:Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType){
        
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        invalidateTimer()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateValue), userInfo: nil, repeats: true)
        
        if duration == 0 {
            updateText(value: toValue)
            return
        }
    }
    
    @objc func updateValue(){
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        if progress >= duration {
            invalidateTimer()
            progress = duration
        }
        //updateText in Label
        updateText(value: currentCounterValue)
    }
    
    func updateText(value :Float) {
        switch counterType! {
        case .Int:
            self.text = "\(Int(value))"
        case .Float:
            self.text = String(format: "%.2f", value)
        }
    }
    
    func updateCounter (counterValue:Float) -> Float {
        
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, counterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, counterVelocity)
        }
    }
    
    func invalidateTimer(){
        timer?.invalidate()
        timer = nil
    }
}









