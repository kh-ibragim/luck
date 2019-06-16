//
//  CityCell.swift
//  fame
//
//  Created by Ibragim Khasanov on 16/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(name: String) {
        self.cityName.text = name
    }
    
}

