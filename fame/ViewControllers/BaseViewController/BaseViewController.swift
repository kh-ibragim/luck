//
//  BaseViewController.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//


import UIKit
import SkeletonView

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    public var hideNavigation = false {
        didSet {
            self.navigationController?.navigationBar.isHidden = self.hideNavigation
          //  self.sideMenuController?.isLeftViewSwipeGestureDisabled = true
        }
    }
    
    public var enableSwipeBack = true {
        didSet {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = self.enableSwipeBack
        }
    }
    
    public var largeNavTitle = false {
        didSet {
            if #available(iOS 11.0, *) {
                self.navigationController?.navigationBar.prefersLargeTitles = self.largeNavTitle
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = self.enableSwipeBack
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismissKeyboard()
    }
    
    public func setTitle(_ title: String) {
        self.title = title
    }
    
    public func setupNavigationBar() {
        self.hideNavigation = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navBackSmGrey")
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "navBackSmGrey")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:self, action:#selector(backAction))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black/*, .font: UIFont(name: "Gilroy-Bold", size: 19)!*/]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationLeftButton()
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func hideNavigationShadow() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func transperentNavigationBar() {
        self.hideNavigation = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationLeftButton()
    }
    
    func hidenNavigation() {
        self.hideNavigation = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func navigationLeftButton() {
        if self.navigationController?.viewControllers[0] == self {
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.showMenu))
          //  self.sideMenuController?.isLeftViewSwipeGestureDisabled = false
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navBackSmGrey"), style: .plain, target: self, action: #selector(self.back))
         //   self.sideMenuController?.isLeftViewSwipeGestureDisabled = true
        }
    }
    
    @objc private func unAuthorizationHandler(notification: Notification) {
//        User.userLogout()
//        API.removeUserToken()
//        let regController = RegistrationViewController()
//        self.presentNewRoot(regController)
    }
    
    func colorTitle(_ color: UIColor) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    public func presentNewRoot(_ viewController: UIViewController, _ animated: Bool = true) {
        self.navigationController?.setViewControllers([viewController], animated: animated)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupDismissButton(title: String?, image: UIImage?, action: Selector?) {
        self.navigationItem.leftBarButtonItem = nil
        var buttonItem : UIBarButtonItem?
        if let title = title {
            buttonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: action)
        } else if let image = image {
            buttonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: action)
        }
        self.navigationItem.setLeftBarButton(buttonItem, animated: true)
    }
    
    func addRightBarButton(image: UIImage?, title: String?, action: Selector?, tintColor: UIColor = .black, attributes: [NSAttributedString.Key : Any]? = nil) {
        self.navigationItem.rightBarButtonItem = nil
        var buttonItem : UIBarButtonItem?
        if let title = title {
            buttonItem = UIBarButtonItem.init(title: title, style: .done, target: self, action: action)
        } else if let image = image {
            buttonItem = UIBarButtonItem.init(image: image, style: .done, target: self, action: action)
        }
        self.navigationItem.setRightBarButton(buttonItem, animated: true)
        self.navigationItem.rightBarButtonItem?.tintColor = tintColor
        
        if attributes != nil {
            self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributes!, for: .normal)
        }
    }
    @objc func showMenu() {
       // self.sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
}

extension BaseViewController {
    public func showHUD(_ shouldShow: Bool, _ needBlur: Bool = true, backColor: UIColor = .blackShadowEffect, _ offsetCenterY: Int = 0) {
        DispatchQueue.main.async {
            self.dismissKeyboard()
            self.view.isUserInteractionEnabled = !shouldShow
            shouldShow ? self.view.setHUD(color: .fameGrayButtonActive, needBlur, backColor, offsetCenterY) : self.view.removeHUD()
        }
    }
}

extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func dispatchDelay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
    }
}

//MARK: Error viewing extension

extension BaseViewController {
    
    func showAlertWith(title: String?, message: String?, buttonTitle: String?, completion: @escaping()->()) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: buttonTitle ?? "OK", style: .cancel) { (action) in
            completion()
        }
        alertViewController.addAction(actionButton)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func showWhithTitleMessageCancelButtonActions(title: String?, message: String, cancelButtonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title:title, message: message as String, preferredStyle: .alert)
            let cancel = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) -> Void in
            }
            alertViewController.addAction(cancel)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func showWithError(error: NSError) {
        let alertViewController = UIAlertController(title: nil, message: "Error", preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertViewController.addAction(actionButton)
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension BaseViewController {
    func isTheDeviceIphoneX() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                return false
            case 1334:
                print("iPhone 6/6S/7/8")
                return false
            case 1792:
                print("iPhone XR")
                return true
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
                return false
            case 2436:
                print("iPhone X/XS")
                return true
            case 2688:
                print("iPhone XS Max")
                return true
            default:
                print("unknown")
                return false
            }
        } else {
            return false
        }
    }
    
    func heightForDescription(text: String, numberOfLine: Int) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80, height: 20))
        let font = UIFont(name: "Gilroy-Medium", size: 16)!
        
        label.numberOfLines = numberOfLine
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    public func showAgreeAlert(title: String? = nil, message: String? = nil, yesAction: (()->())? = nil) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
            let yes = UIAlertAction(title: "ОК", style: .default) { (_) -> Void in
                yesAction?()
            }
            alertVC.addAction(yes)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
