//
//  UICheckBox.swift
//  CheckBox
//
//  Created by 周泽勇 on 15/8/10.
//  Copyright (c) 2015年 周泽勇. All rights reserved.
//

import UIKit

public enum UICheckboxAlignment:Int {
    case Right
    case Left
}

private let CheckboxDefaultSideLength:CGFloat = 20

public class UICheckbox: UIControl {
    public var checked:Bool = false {
        didSet {
            if oldValue != self.checked {
                self.setNeedsDisplay()
                self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
            }
        }
    }
    
    
    public var checkboxColor:UIColor = UIColor.blackColor() {
        didSet {
            if oldValue != self.checkboxColor {
                self.setNeedsDisplay()
            }
        }
    }
    
    public var checkboxAlignment:UICheckboxAlignment = UICheckboxAlignment.Left {
        didSet {
            if oldValue != self.checkboxAlignment {
                self.setNeedsLayout()
            }
        }
    }
    
    public var checkboxSideLength:CGFloat = CheckboxDefaultSideLength
    public var textLabel:UILabel = UILabel(frame: CGRectZero)
    
    public var text:String = "" {
        didSet {
            if oldValue != self.text {
                textLabel.text = self.text
                self.setNeedsLayout()
            }
        }
    }
    
    private var colors:[String:UIColor] = [String:UIColor]()
    private var backgroundColors:[String:UIColor] = [String:UIColor]()
    
    public func setColor(color:UIColor, state:UIControlState) {
        switch state {
        case UIControlState.Normal:
            colors["Normal"] = color
            break
        case UIControlState.Selected:
            colors["Selected"] = color
            break
        case UIControlState.Disabled:
            colors["Disabled"] = color
            break
        default:
            break
        }
        changeColorForState(self.state)
    }
    
    public func setBackgroundColor(backgroundColor:UIColor, state:UIControlState) {
        switch state {
        case UIControlState.Normal:
            backgroundColors["Normal"] = backgroundColor
            break
        case UIControlState.Selected:
            backgroundColors["Selected"] = backgroundColor
            break
        case UIControlState.Disabled:
            backgroundColors["Disabled"] = backgroundColor
            break
        default:
            break
        }
        changeBackgroundColorForState(self.state)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCheckbox()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCheckbox()
    }
    
    private func setupCheckbox() {
        self.backgroundColor = UIColor.clearColor()
        textLabel.backgroundColor = UIColor.clearColor()
        addSubview(textLabel)
        
        colors = ["Normal":UIColor.blackColor(), "Selected":UIColor.blackColor(), "Disabled":UIColor.grayColor()]
        
        addObserver(self, forKeyPath: "enabled", options: NSKeyValueObservingOptions.New, context: nil)
        addObserver(self, forKeyPath: "selected", options: NSKeyValueObservingOptions.New, context: nil)
        addObserver(self, forKeyPath: "highlighted", options: NSKeyValueObservingOptions.New, context: nil)
    }

    deinit {
        removeObserver(self, forKeyPath: "enabled")
        removeObserver(self, forKeyPath: "selected")
        removeObserver(self, forKeyPath: "highlighted")
    }
    
    public override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "enabled" || keyPath == "selected" || keyPath == "highlighted" {
            changeColorForState(state)
            changeBackgroundColorForState(state)
        }else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    private func changeColorForState(state:UIControlState) {
        var color:UIColor?
        switch state {
        case UIControlState.Normal:
            color = colors["Normal"]
            break
        case UIControlState.Selected:
            color = colors["Selected"]
            break
        case UIControlState.Disabled:
            color = colors["Disabled"]
            break
        default:
            break
        }
        if color == nil {
            color = UIColor .blackColor()
        }
        checkboxColor = color!
        textLabel.textColor = color!
    }
    
    private func changeBackgroundColorForState(state:UIControlState) {
        var color:UIColor?
        switch state {
        case UIControlState.Normal:
            color = backgroundColors["Normal"]
            break
        case UIControlState.Selected:
            color = backgroundColors["Selected"]
            break
        case UIControlState.Disabled:
            color = backgroundColors["Disabled"]
            break
        default:
            break
        }
        if color == nil {
            color = UIColor .clearColor()
        }
        backgroundColor = color!
    }
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func drawRect(rect: CGRect) {
        var frame:CGRect!
        if checkboxAlignment == UICheckboxAlignment.Left {
            frame = CGRectIntegral(CGRectMake(0, (rect.size.height - self.checkboxSideLength) / 2.0, checkboxSideLength, checkboxSideLength))
        }else {
            frame = CGRectIntegral(CGRectMake(rect.width - self.checkboxSideLength, (rect.size.height - self.checkboxSideLength) / 2.0, checkboxSideLength, checkboxSideLength))
        }
        
        if checked {
            var bezierPath = UIBezierPath()
            bezierPath.moveToPoint(CGPointMake(CGRectGetMinX(frame) + 0.75000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21875 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.40000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52500 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.28125 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37500 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.17500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47500 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.40000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75000 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.81250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28125 * CGRectGetHeight(frame)))
            bezierPath.addLineToPoint(CGPointMake(CGRectGetMinX(frame) + 0.75000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21875 * CGRectGetHeight(frame)))
            bezierPath.closePath()
            
            checkboxColor.setFill()
            bezierPath.fill()
        }
        
        var roundedRectanglePath = UIBezierPath(roundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.05000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.05000 + 0.5), floor(CGRectGetWidth(frame) * 0.95000 + 0.5) - floor(CGRectGetWidth(frame) * 0.05000 + 0.5), floor(CGRectGetHeight(frame) * 0.95000 + 0.5) - floor(CGRectGetHeight(frame) * 0.05000 + 0.5)), cornerRadius: 3)
        roundedRectanglePath.lineWidth = 2*checkboxSideLength/CheckboxDefaultSideLength
        checkboxColor.setStroke()
        roundedRectanglePath.stroke()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var textLabelOriginX = checkboxSideLength + 5
        var text:NSString = ""
        if textLabel.text != nil {
            text = textLabel.text!
        }
        
        var textLabelMaxSize = CGSizeMake(bounds.width - textLabelOriginX, bounds.height)
        var r = text.boundingRectWithSize(textLabelMaxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin|NSStringDrawingOptions.UsesFontLeading, attributes: [NSFontAttributeName:textLabel.font], context: nil)
        var textLabelSize = r.size
        
        if self.checkboxAlignment == UICheckboxAlignment.Left {
            var frame = CGRectMake(textLabelOriginX, (bounds.height - textLabelSize.height)/2, textLabelSize.width, textLabelSize.height)
            textLabel.frame = CGRectIntegral(frame)
            
        }else if checkboxAlignment == UICheckboxAlignment.Right {
            var frame = CGRectMake(0, (bounds.height - textLabelSize.height)/2, textLabelSize.width, textLabelSize.height)
            textLabel.frame = CGRectIntegral(frame)
        }
        setNeedsDisplay()
    }
    
    public override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        var location = touch.locationInView(self)
        if CGRectContainsPoint(bounds, location) {
            self.checked = !self.checked
        }
    }
}
