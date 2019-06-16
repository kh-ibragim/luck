//
//  CategotyFilterVC.swift
//  fame
//
//  Created by Ibragim Khasanov on 16/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

enum PriorCategory {
    case no
    case null
    case yes
}

class CategotyFilterVC: BaseViewController {

    @IBOutlet weak var entertainmentNoButton: UIButton!
    @IBOutlet weak var entertainmentNilButton: UIButton!
    @IBOutlet weak var entertainmentYesButton: UIButton!
    var entertainment: PriorCategory = .null
    
    @IBOutlet weak var educationNoButton: UIButton!
    @IBOutlet weak var educationNilButton: UIButton!
    @IBOutlet weak var educationYesButton: UIButton!
    var education: PriorCategory = .null
    
    @IBOutlet weak var medicineNoButton: UIButton!
    @IBOutlet weak var medicineNilButton: UIButton!
    @IBOutlet weak var medicineYesButton: UIButton!
    var medicine: PriorCategory = .null
    
    @IBOutlet weak var carNoButton: UIButton!
    @IBOutlet weak var carNilButton: UIButton!
    @IBOutlet weak var carYesButton: UIButton!
    var car: PriorCategory = .null
    
    @IBOutlet weak var shopNoButton: UIButton!
    @IBOutlet weak var shopNilButton: UIButton!
    @IBOutlet weak var shopYesButton: UIButton!
    var shop: PriorCategory = .null
    
    @IBOutlet weak var trafficNoButton: UIButton!
    @IBOutlet weak var trafficNilButton: UIButton!
    @IBOutlet weak var trafficYesButton: UIButton!
    var traffic: PriorCategory = .null
    
    @IBOutlet weak var busNoButton: UIButton!
    @IBOutlet weak var busNilButton: UIButton!
    @IBOutlet weak var busYesButton: UIButton!
    var bus: PriorCategory = .null
    
    @IBOutlet weak var logisticsNoButton: UIButton!
    @IBOutlet weak var logisticsNilButton: UIButton!
    @IBOutlet weak var logisticsYesButton: UIButton!
    var logistic: PriorCategory = .null
    var manager = MapFilterManager.sharedManager
    @IBOutlet weak var nextButton: UIButton!
    var isFromMap = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationLeftButton()
        self.setupObserve()
        if self.isFromMap {
            self.nextButton.setTitle("ПРИМЕНИТЬ", for: .normal)
            self.nextButton.setTitle("ПРИМЕНИТЬ", for: .selected)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.defaultSetupView()
    }
    
    func setupObserve(){
        self.entertainmentNoButton.reactive.tap.observeNext { [weak self] in
            self?.entertainment = .no
            self?.activeButton(active: true, button: (self?.entertainmentNoButton)!)
            self?.activeButton(active: false, button: (self?.entertainmentNilButton)!)
            self?.activeButton(active: false, button: (self?.entertainmentYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.entertainmentNilButton.reactive.tap.observeNext { [weak self] in
            self?.entertainment = .null
            self?.activeButton(active: false, button: (self?.entertainmentNoButton)!)
            self?.activeButton(active: true, button: (self?.entertainmentNilButton)!)
            self?.activeButton(active: false, button: (self?.entertainmentYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.entertainmentYesButton.reactive.tap.observeNext { [weak self] in
            self?.entertainment = .yes
            self?.activeButton(active: false, button: (self?.entertainmentNoButton)!)
            self?.activeButton(active: false, button: (self?.entertainmentNilButton)!)
            self?.activeButton(active: true, button: (self?.entertainmentYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.educationNoButton.reactive.tap.observeNext { [weak self] in
            self?.education = .no
            self?.activeButton(active: true, button: (self?.educationNoButton)!)
            self?.activeButton(active: false, button: (self?.educationNilButton)!)
            self?.activeButton(active: false, button: (self?.educationYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.educationNilButton.reactive.tap.observeNext { [weak self] in
            self?.education = .null
            self?.activeButton(active: false, button: (self?.educationNoButton)!)
            self?.activeButton(active: true, button: (self?.educationNilButton)!)
            self?.activeButton(active: false, button: (self?.educationYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.educationYesButton.reactive.tap.observeNext { [weak self] in
            self?.education = .yes
            self?.activeButton(active: false, button: (self?.educationNoButton)!)
            self?.activeButton(active: false, button: (self?.educationNilButton)!)
            self?.activeButton(active: true, button: (self?.educationYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.medicineNoButton.reactive.tap.observeNext { [weak self] in
            self?.medicine = .no
            self?.activeButton(active: true, button: (self?.medicineNoButton)!)
            self?.activeButton(active: false, button: (self?.medicineNilButton)!)
            self?.activeButton(active: false, button: (self?.medicineYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.medicineNilButton.reactive.tap.observeNext { [weak self] in
            self?.medicine = .null
            self?.activeButton(active: false, button: (self?.medicineNoButton)!)
            self?.activeButton(active: true, button: (self?.medicineNilButton)!)
            self?.activeButton(active: false, button: (self?.medicineYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.medicineYesButton.reactive.tap.observeNext { [weak self] in
            self?.medicine = .yes
            self?.activeButton(active: false, button: (self?.medicineNoButton)!)
            self?.activeButton(active: false, button: (self?.medicineNilButton)!)
            self?.activeButton(active: true, button: (self?.medicineYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.carNoButton.reactive.tap.observeNext { [weak self] in
            self?.car = .no
            self?.activeButton(active: true, button: (self?.carNoButton)!)
            self?.activeButton(active: false, button: (self?.carNilButton)!)
            self?.activeButton(active: false, button: (self?.carYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.carNilButton.reactive.tap.observeNext { [weak self] in
            self?.car = .null
            self?.activeButton(active: false, button: (self?.carNoButton)!)
            self?.activeButton(active: true, button: (self?.carNilButton)!)
            self?.activeButton(active: false, button: (self?.carYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.carYesButton.reactive.tap.observeNext { [weak self] in
            self?.car = .yes
            self?.activeButton(active: false, button: (self?.carNoButton)!)
            self?.activeButton(active: false, button: (self?.carNilButton)!)
            self?.activeButton(active: true, button: (self?.carYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.shopNoButton.reactive.tap.observeNext { [weak self] in
            self?.shop = .no
            self?.activeButton(active: true, button: (self?.shopNoButton)!)
            self?.activeButton(active: false, button: (self?.shopNilButton)!)
            self?.activeButton(active: false, button: (self?.shopYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.shopNilButton.reactive.tap.observeNext { [weak self] in
            self?.shop = .null
            self?.activeButton(active: false, button: (self?.shopNoButton)!)
            self?.activeButton(active: true, button: (self?.shopNilButton)!)
            self?.activeButton(active: false, button: (self?.shopYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.shopYesButton.reactive.tap.observeNext { [weak self] in
            self?.shop = .yes
            self?.activeButton(active: false, button: (self?.shopNoButton)!)
            self?.activeButton(active: false, button: (self?.shopNilButton)!)
            self?.activeButton(active: true, button: (self?.shopYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.trafficNoButton.reactive.tap.observeNext { [weak self] in
            self?.traffic = .no
            self?.activeButton(active: true, button: (self?.trafficNoButton)!)
            self?.activeButton(active: false, button: (self?.trafficNilButton)!)
            self?.activeButton(active: false, button: (self?.trafficYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.trafficNilButton.reactive.tap.observeNext { [weak self] in
            self?.traffic = .null
            self?.activeButton(active: false, button: (self?.trafficNoButton)!)
            self?.activeButton(active: true, button: (self?.trafficNilButton)!)
            self?.activeButton(active: false, button: (self?.trafficYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.trafficYesButton.reactive.tap.observeNext { [weak self] in
            self?.traffic = .yes
            self?.activeButton(active: false, button: (self?.trafficNoButton)!)
            self?.activeButton(active: false, button: (self?.trafficNilButton)!)
            self?.activeButton(active: true, button: (self?.trafficYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.busNoButton.reactive.tap.observeNext { [weak self] in
            self?.bus = .no
            self?.activeButton(active: true, button: (self?.busNoButton)!)
            self?.activeButton(active: false, button: (self?.busNilButton)!)
            self?.activeButton(active: false, button: (self?.busYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.busNilButton.reactive.tap.observeNext { [weak self] in
            self?.bus = .null
            self?.activeButton(active: false, button: (self?.busNoButton)!)
            self?.activeButton(active: true, button: (self?.busNilButton)!)
            self?.activeButton(active: false, button: (self?.busYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.busYesButton.reactive.tap.observeNext { [weak self] in
            self?.bus = .yes
            self?.activeButton(active: false, button: (self?.busNoButton)!)
            self?.activeButton(active: false, button: (self?.busNilButton)!)
            self?.activeButton(active: true, button: (self?.busYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.logisticsNoButton.reactive.tap.observeNext { [weak self] in
            self?.logistic = .no
            self?.activeButton(active: true, button: (self?.logisticsNoButton)!)
            self?.activeButton(active: false, button: (self?.busNilButton)!)
            self?.activeButton(active: false, button: (self?.logisticsYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.logisticsNilButton.reactive.tap.observeNext { [weak self] in
            self?.logistic = .null
            self?.activeButton(active: false, button: (self?.logisticsNoButton)!)
            self?.activeButton(active: true, button: (self?.logisticsNilButton)!)
            self?.activeButton(active: false, button: (self?.logisticsYesButton)!)
            }.dispose(in: self.reactive.bag)
        
        self.logisticsYesButton.reactive.tap.observeNext { [weak self] in
            self?.logistic = .yes
            self?.activeButton(active: false, button: (self?.logisticsNoButton)!)
            self?.activeButton(active: false, button: (self?.logisticsNilButton)!)
            self?.activeButton(active: true, button: (self?.logisticsYesButton)!)
            }.dispose(in: self.reactive.bag)
    }
    
    func defaultSetupView() {
        self.activeButton(active: self.manager.entertainment == .no, button: self.entertainmentNoButton)
        self.activeButton(active: self.manager.entertainment == .null, button: self.entertainmentNilButton)
        self.activeButton(active: self.manager.entertainment == .yes, button: self.entertainmentYesButton)
      
        self.activeButton(active: self.manager.education == .no, button: self.educationNoButton)
        self.activeButton(active: self.manager.education == .null, button: self.educationNilButton)
        self.activeButton(active: self.manager.education == .yes, button: self.educationYesButton)
        
        self.activeButton(active: self.manager.medicine == .no, button: self.medicineNoButton)
        self.activeButton(active: self.manager.medicine == .null, button: self.medicineNilButton)
        self.activeButton(active: self.manager.medicine == .yes, button: self.medicineYesButton)
        
        self.activeButton(active: self.manager.car == .no, button: self.carNoButton)
        self.activeButton(active: self.manager.car == .null, button: self.carNilButton)
        self.activeButton(active: self.manager.car == .yes, button: self.carYesButton)
        
        self.activeButton(active: self.manager.shop == .no, button: self.shopNoButton)
        self.activeButton(active: self.manager.shop == .null, button: self.shopNilButton)
        self.activeButton(active: self.manager.shop == .yes, button: self.shopYesButton)
        
        self.activeButton(active: self.manager.traffic == .no, button: self.trafficNoButton)
        self.activeButton(active: self.manager.traffic == .null, button: self.trafficNilButton)
        self.activeButton(active: self.manager.traffic == .yes, button: self.trafficYesButton)
        
        self.activeButton(active: self.manager.bus == .no, button: self.busNoButton)
        self.activeButton(active: self.manager.bus == .null, button: self.busNilButton)
        self.activeButton(active: self.manager.bus == .yes, button: self.busYesButton)
        
        self.activeButton(active: self.manager.logistic == .no, button: self.logisticsNoButton)
        self.activeButton(active: self.manager.logistic == .null, button: self.logisticsNilButton)
        self.activeButton(active: self.manager.logistic == .yes, button: self.logisticsYesButton)
        
    }
    
    
    func activeButton(active: Bool, button: UIButton) {
        if active {
            button.backgroundColor = .fameGrayButtonActive
            button.titleLabel?.textColor = .white
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.white, for: .selected)
        } else {
            button.backgroundColor = .fameGrayButton
            button.setTitleColor(.fameGrayButtonText, for: .normal)
            button.setTitleColor(.fameGrayButtonText, for: .selected)
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        let mapVC = MapScreenVC()
        self.manager.entertainment = self.entertainment
        self.manager.education = self.education
        self.manager.medicine = self.medicine
        self.manager.car = self.car
        self.manager.shop = self.shop
        self.manager.traffic = self.traffic
        self.manager.bus = self.bus
        self.manager.logistic = self.logistic
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}
