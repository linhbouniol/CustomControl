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
    private let componentCount = 4
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    
    private let rightToLeft = true
    
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
            let label = UILabel(frame: CGRect(x: (componentDimension + 8.0) * CGFloat(componentIndex - 1) + 8.0, y: 0, width: componentDimension, height: componentDimension))
            if rightToLeft {
                // In right to left mode, make sure the label tags go from big to small
                label.tag = 1 + componentCount - componentIndex
            } else {
                // In left to right mode, make sure the label tags go from small to big
                label.tag = componentIndex
            }
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.text = "★"
            label.textAlignment = .center
            // Set a random background color so the label's placement is obvious
//            label.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 0.5)
            
            if label.tag <= value {
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
            let touchPoint = touch.location(in: label)
            if label.bounds.contains(touchPoint) {
                if value != label.tag {
                    value = label.tag
                    sendActions(for: [.valueChanged, .primaryActionTriggered])
                    label.performFlare()
                }
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
            // It seems like the control sends .touchDragInside and .touchDragOutside automatically
//            sendActions(for: [.touchDragInside])
        } else {
//            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event)}
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            // It seems like the control sends .touchUpInside and .touchUpOutside automatically
//            sendActions(for: [.touchUpInside])
        } else {
//            sendActions(for: [.touchUpOutside])
        }
    }
    
    // Here, .touchCancel is called automatically, and there is nothing else to do in cancel, so rather than overriding it only to call super.cancelTracking, we do nothing
//    override func cancelTracking(with event: UIEvent?) {
//        sendActions(for: [.touchCancel])
//    }
}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(rotationAngle: CGFloat.pi).translatedBy(x: 0, y: 20).scaledBy(x: 2, y: 2); alpha = 0.5 }
        func unflare() { transform = .identity; alpha = 1 }

        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}

