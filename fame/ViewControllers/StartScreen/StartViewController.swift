//
//  StartViewController.swift
//  fame
//
//  Created by Ibragim Khasanov on 16/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func skipAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(MainScreenVC(), animated: true)
    }
    
    @IBAction func agreeAction(_ sender: UIButton) {
    //    self.navigationController?.pushViewController(MyCityScreenVC(), animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
