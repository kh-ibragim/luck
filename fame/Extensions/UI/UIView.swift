//
//  UIView.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


extension UIView {
    
    public func awakeOutlets() {
        let view = self.loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    static func fromNib<T>(_ type: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: type), owner: self, options: nil)?.first as! T
    }
    
    static func add<T:UIView>(_ type:T.Type, into superview: UIView, below viewAbove: UIView?) -> T {
        let view = UIView.fromNib(T.self)
        if viewAbove != nil {
            view.frame.origin.y = viewAbove!.frame.origin.y + viewAbove!.frame.size.height
        }
        
        view.frame.size.width = superview.bounds.size.width
        superview.addSubview(view)
        return view
    }
    
    @discardableResult
    func createGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [ UIColor.red.cgColor, UIColor.green.cgColor]//array colors
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, below: self.layer.sublayers?.first)
        return gradientLayer
    }
    
    func setGradientHorisontal(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        var colorsGradient: [CGColor] = []
        colors.forEach { (color) in
            colorsGradient.append(color.cgColor)
        }
        gradientLayer.colors = colorsGradient.reversed()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        print(self.layer.sublayers!)
        self.layer.insertSublayer(gradientLayer, below: self.layer.sublayers?.first)
    }
    
    func setup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let className = String.className(type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    /// Устаналивает HUD поверх всех экранов
    func setHUD(color: UIColor, _ needBlur: Bool = true, _ colorBack: UIColor = .lighterPurple, _ offsetCenterY: Int = 0) {
        let indicatorWidth: CGFloat = 60
        let indicatorHeight: CGFloat = 60
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenCenterX = screenWidth / 2 - indicatorWidth / 2
        let screenCenterY = screenHeight / 2 - indicatorHeight * 2
        
        let backFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let backgroundView = UIView(frame: backFrame)
        backgroundView.tag = -12
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            if needBlur {
                backgroundView.backgroundColor = .clear
                let blurEffect = UIBlurEffect(style: .extraLight)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = backgroundView.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                backgroundView.addSubview(blurEffectView)
            } else {
                backgroundView.backgroundColor = colorBack
            }
        } else {
            if needBlur {
                backgroundView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
            } else {
                backgroundView.backgroundColor = colorBack
            }
        }
        
        let activity = NVActivityIndicatorView(frame: CGRect(x: screenCenterX, y: screenCenterY + 45 + CGFloat(integerLiteral: offsetCenterY), width: indicatorWidth, height: indicatorHeight), type: .circleStrokeSpin)
        activity.padding = 0
        activity.color = color
        activity.startAnimating()
        
        backgroundView.addSubview(activity)
      //  backgroundView.fadeIn()
        self.addSubview(backgroundView)
    }
    
    /// Удаляет HUD с экрана
    func removeHUD() {
        self.viewWithTag(-12)?.removeFromSuperview()
    }
    
    func setupShadows(size: CGSize = CGSize(width: 0, height: 2), opacity: Float = 0.2, shadowColor: UIColor = UIColor.blackShadowEffect) {
        self.layer.shadowColor = shadowColor.withAlphaComponent(0.92).cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacity
        self.backgroundColor = .clear
    }
    
    func changeBackgroundAnimated(color: UIColor, duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.backgroundColor = color
        }
    }
    
    func setBlockHUD(activityColor: UIColor = .margiGold) {
        let rect = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        let backgroudView = UIView(frame: rect)
        backgroudView.backgroundColor = .white
        backgroudView.tag = -12
        //backgroudView.setSubviewType(.fullHUD)
        let activity = NVActivityIndicatorView(frame: CGRect(origin: CGPoint(x: UIScreen.main.bounds.size.width / 2 - 12, y: self.frame.size.height / 2 - 12), size: CGSize(width: 24, height: 24)), type: .ballClipRotate, color: activityColor, padding: 0)
        activity.tag = -13
        activity.startAnimating()
        backgroudView.addSubview(activity)
        self.addSubview(backgroudView)
    }
    
    func dismissBlockHUD() {
        self.subviews.forEach { (subview) in
            if subview.tag == -12 || subview.tag == -13 {
                subview.removeFromSuperview()
            }
        }
    }
    
}

