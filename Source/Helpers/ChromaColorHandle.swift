//
//  ChromaColorHandle.swift
//  ChromaColorPicker
//
//  Created by Jon Cardasis on 4/11/19.
//  Copyright © 2019 Jonathan Cardasis. All rights reserved.
//

import UIKit

public class ChromaColorHandle: UIView, ChromaControlStylable {
    
    /// Current selected color of the handle.
    public var color: UIColor = .black {
        didSet { setNeedsLayout() }
    }
    
    /// An image to display above the handle.
    public var popoverImage: UIImage?
    
    /// A view to display above the handle. Overrides any provided `popoverImage`.
    public var popoverView: UIView?
    
    public var borderWidth: CGFloat = 3.0 {
        didSet { setNeedsLayout() }
    }
    
    public var borderColor: UIColor = .white {
        didSet { setNeedsLayout() }
    }
    
    public var showsShadow: Bool = true {
        didSet { setNeedsLayout() }
    }
    
    // MARK: - Initialization
    
    public convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.color = color
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutHandleShape()
        
        layer.masksToBounds = false
    }
    
    // MARK: - Private
    internal let handleShape = CAShapeLayer()
    
    internal func commonInit() {
        backgroundColor = UIColor.red.withAlphaComponent(0.25) //DEBUG
        layer.addSublayer(handleShape)
    }
    
    internal func updateShadowIfNeeded() {
        if showsShadow {
            let shadowProps = shadowProperties(forHeight: bounds.height)
            applyDropShadow(shadowProps)
        } else {
            removeDropShadow()
        }
    }
    
    internal func makeHandlePath(frame: CGRect) -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.minX + 0.5 * frame.width, y: frame.minY + 1 * frame.height))
        path.addCurve(to: CGPoint(x: frame.minX + 1 * frame.width, y: frame.minY + 0.40310 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.83333 * frame.width, y: frame.minY + 0.80216 * frame.height), controlPoint2: CGPoint(x: frame.minX + 1 * frame.width, y: frame.minY + 0.60320 * frame.height))
        path.addCurve(to: CGPoint(x: frame.minX + 0.5 * frame.width, y: frame.minY * frame.height), controlPoint1: CGPoint(x: frame.minX + 1 * frame.width, y: frame.minY + 0.18047 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.77614 * frame.width, y: frame.minY * frame.height))
        path.addCurve(to: CGPoint(x: frame.minX * frame.width, y: frame.minY + 0.40310 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.22386 * frame.width, y: frame.minY * frame.height), controlPoint2: CGPoint(x: frame.minX * frame.width, y: frame.minY + 0.18047 * frame.height))
        path.addCurve(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 1 * frame.height), controlPoint1: CGPoint(x: frame.minX * frame.width, y: frame.minY + 0.60837 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.16667 * frame.width, y: frame.minY + 0.80733 * frame.height))
        path.close()
        return path.cgPath
    }
    
    internal func layoutHandleShape() {
        let size = CGSize(width: bounds.height * handleWidthHeightRatio, height: bounds.height)
        handleShape.path = makeHandlePath(frame: CGRect(origin: .zero, size: size))
        handleShape.frame = CGRect(origin: CGPoint(x: bounds.midX - (size.width / 2), y: bounds.midY - size.height), size: size)
        
        handleShape.fillColor = color.cgColor
        handleShape.strokeColor = borderColor.cgColor
        handleShape.lineWidth = borderWidth
    }
}

internal let handleWidthHeightRatio: CGFloat = 52.0 / 65
