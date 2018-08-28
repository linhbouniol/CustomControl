//
//  CustomControl.swift
//  Custom UIControl
//
//  Created by Linh Bouniol on 8/28/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1
    
    private var labelsArray = [UILabel]()
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        setup()
    }
    
    // Tells auto layout how big the custom control should be...
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    private func setup() {
        // Build 5 labels
//        let label1 = UILabel(frame: CGRect(x: 8.0, y: 0, width: componentDimension, height: componentDimension))
//        let label2 = UILabel(frame: CGRect(x: componentDimension + 8.0, y: 0, width: componentDimension, height: componentDimension))
//        let label3 = UILabel(frame: CGRect(x: componentDimension * 2 + 8.0, y: 0, width: componentDimension, height: componentDimension))
//        let label4 = UILabel(frame: CGRect(x: componentDimension * 3 + 8.0, y: 0, width: componentDimension, height: componentDimension))
//        let label5 = UILabel(frame: CGRect(x: componentDimension * 4 + 8.0, y: 0, width: componentDimension, height: componentDimension))
//
//        // Tag each view
//        label1.tag = 1
//        label2.tag = 2
//        label3.tag = 3
//        label4.tag = 4
//        label5.tag = 5
//
//        // Attributes
//        label1.font = UIFont.boldSystemFont(ofSize: 32.0)
//        label2.font = UIFont.boldSystemFont(ofSize: 32.0)
//        label3.font = UIFont.boldSystemFont(ofSize: 32.0)
//        label4.font = UIFont.boldSystemFont(ofSize: 32.0)
//        label5.font = UIFont.boldSystemFont(ofSize: 32.0)
//
//        label1.text = "★"
//        label2.text = "★"
//        label3.text = "★"
//        label4.text = "★"
//        label5.text = "★"
        
        for componentIndex in 1...componentCount {
            let label = UILabel(frame: CGRect(x: componentDimension * CGFloat(componentIndex - 1) + 8.0, y: 0, width: componentDimension, height: componentDimension))
            label.tag = componentIndex
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.text = "★"
            label.textAlignment = .center
            
            if componentIndex <= value {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
            
            self.addSubview(label)
            
            labelsArray.append(label)
        }
    }
    
    func updateValue(at touch: UITouch) {
        for label in labelsArray {
            let touchPoint = touch.location(in: self)
            if label.bounds.contains(touchPoint) {
                value = label.tag
                sendActions(for: .valueChanged)
            }
        }
        
        for label in labelsArray {
            if label.tag <= value {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
        }
    }
    
    // MARK: - Touch Tracking
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event)}
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
}

