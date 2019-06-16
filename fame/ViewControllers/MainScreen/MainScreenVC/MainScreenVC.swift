//
//  MainScreenVC.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

class MainScreenVC: BaseViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectCityButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectCityButton.setTitle(CityManager.sharedManager.city, for: .normal)
        self.selectCityButton.setTitle(CityManager.sharedManager.city, for: .selected)
    }
    
    func setupView() {
        self.selectCityButton.layer.borderWidth = 1.0
        self.selectCityButton.layer.borderColor = UIColor.fameGray.cgColor
    }
    
    
    @IBAction func selectCityAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(MyCityScreenVC(), animated: true)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(CategotyFilterVC(), animated: true)
    }
}
