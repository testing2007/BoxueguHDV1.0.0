//
//  RWSlider.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/18.
//  Copyright © 2018年 itcast. All rights reserved.
//

import UIKit

enum RWSliderEventType {
    case startDragging
    case dragging
    case endDragging
}

class RWSlider: UISlider {
    //  self.highlighted : highlighted 0:1 开始, 1:1 滑动中 1:0 或者 0:0 结束
    
    public var isDragging = false
    var eventClosure :((_ type: RWSliderEventType,_ value: Float) ->())?
    
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            self.setState(oldHighlighted: super.isHighlighted, newHighlighted: newValue)
            super.isHighlighted = newValue
        }
    }
    
    func setState(oldHighlighted: Bool, newHighlighted: Bool) {
        
        if(oldHighlighted == false && newHighlighted == true) {
            isDragging = true
            if let eventClosure = eventClosure {
                eventClosure(.startDragging, value)
            }
        }
        
        if(oldHighlighted == true && newHighlighted == true) {
            isDragging = true
            if let eventClosure = eventClosure {
                eventClosure(.dragging, value)
            }
        }
        
        if(oldHighlighted == false && newHighlighted == false) {
            isDragging = false
            if let eventClosure = eventClosure {
                eventClosure(.endDragging, value)
            }
        }
    }
}
