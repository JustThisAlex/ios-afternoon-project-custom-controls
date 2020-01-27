//
//  CustomControl.swift
//  Star Rating
//
//  Created by Alexander Supe on 27.01.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    private (set) var value: Int = 1
    
    private let componentDimension: CGFloat = 40
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    private var labelArray: [UILabel] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        for i in 1...componentCount {
            labelArray.append(UILabel(frame: CGRect(x: 8.0 * CGFloat(i) + componentDimension * CGFloat(i-1), y: CGFloat(0), width: componentDimension, height: componentDimension)))
            self.addSubview(labelArray[i-1])
            labelArray[i-1].tag = i
            labelArray[i-1].font = UIFont.boldSystemFont(ofSize: 32)
            labelArray[i-1].text = "★"
            if i == 1 { labelArray[i-1].textColor = componentActiveColor }
            else { labelArray[i-1].textColor = componentInactiveColor }
            
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if bounds.contains(touch.location(in: self)) {
            updateValue(at: touch)
            sendActions(for: .touchDragInside)
        } else { sendActions(for: .touchDragOutside) }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        if bounds.contains(touch.location(in: self)) {
            updateValue(at: touch)
            sendActions(for: .touchUpInside)
        } else { sendActions(for: .touchUpOutside) }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    func updateValue(at touch: UITouch) {
        for i in 0...labelArray.count-1 {
            if labelArray[i].frame.contains(touch.location(in: self)) {
                if value != labelArray[i].tag {
                    value = labelArray[i].tag
                    sendActions(for: .valueChanged)
                    updateColors(for: labelArray[i].tag)
                }
            }
        }
    }
    
    func updateColors(for state: Int) {
        for i in 1...state { labelArray[i-1].textColor = componentActiveColor;
        labelArray[i-1].performFlare()}
        if state == labelArray.count { return }
        for i in state+1...labelArray.count { labelArray[i-1].textColor = componentInactiveColor
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
}

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
