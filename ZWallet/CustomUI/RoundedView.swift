//
//  RoundedView.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import UIKit

//@IBDesignable
class CustomView: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0
    @IBInspectable
    var shadowRadius: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubviews()
    }
    
    func update() {
        layoutSubviews()
    }
    
    private var shadowLayer: CAShapeLayer!
    private var fillColor: UIColor = .white
     
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = shadowRadius

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

class RoundView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
