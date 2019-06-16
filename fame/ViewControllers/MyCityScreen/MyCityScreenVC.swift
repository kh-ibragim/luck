//
//  MyCityScreenVC.swift
//  fame
//
//  Created by Ibragim Khasanov on 16/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

class MyCityScreenVC: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var searchBar : UISearchBar!
    var cities: [String] = ["Симферополь", "Севастополь", "Евпатория"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        //self.addButtonsForSearchState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigation = true
        self.hideNavigationShadow()
    }
    private func setupView() {
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.58, height: 15))
        self.searchBar.placeholder = "Город"
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            
            textFieldInsideSearchBar.clearButtonMode = .whileEditing
            textFieldInsideSearchBar.backgroundColor = .fameGrayButton
            textFieldInsideSearchBar.tintColor = .clear
            let font = UIFont.init(name: "Gilroy-Medium", size: 17)
            textFieldInsideSearchBar.font = font
            
            if let textFieldInsideSearchBarLabel = textFieldInsideSearchBar.value(forKey: "placeholderLabel") as? UILabel {
                textFieldInsideSearchBarLabel.backgroundColor = .fameGrayButton
                textFieldInsideSearchBarLabel.textColor = .fameGrayButtonText
                textFieldInsideSearchBarLabel.font = font
            }
            
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .black
            textFieldInsideSearchBar.textColor = .black
            textFieldInsideSearchBar.textColor = .black
        }
        
        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = self.headerView
        self.tableView.registerCellNib(CityCell.self)
    }
    
    
    fileprivate func addButtonsForSearchState() {
//        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.58, height: 15))
//        self.searchBar.placeholder = "Поиск по заданиям..."
//        self.searchBar.delegate = self
//        self.searchBar.searchBarStyle = .minimal
//
//        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
//            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
//
//            textFieldInsideSearchBar.clearButtonMode = .whileEditing
//            textFieldInsideSearchBar.backgroundColor = .fameGrayButton
//            textFieldInsideSearchBar.tintColor = .clear
//            let font = UIFont.init(name: "Gilroy-Medium", size: 17)
//            textFieldInsideSearchBar.font = font
//
//            if let textFieldInsideSearchBarLabel = textFieldInsideSearchBar.value(forKey: "placeholderLabel") as? UILabel {
//                textFieldInsideSearchBarLabel.backgroundColor = .fameGrayButton
//                textFieldInsideSearchBarLabel.textColor = .fameGrayButtonText
//                textFieldInsideSearchBarLabel.font = font
//            }
//
//            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
//            glassIconView.tintColor = .black
//            textFieldInsideSearchBar.textColor = .black
//            textFieldInsideSearchBar.textColor = .black
//        }
        
        //self.navigationItem.titleView = self.searchBar
        
//        self.navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: self.searchBar))
//        self.title = nil
    }

    
    //MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      //  self.setupSearchingCancelButton()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       // self.setupDefaultNavigationState()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
      //  self.setupDefaultNavigationState()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchBar.reactive.text.throttle(seconds: 0.5)
//            .bind(to: self.viewModel.searchQuery)
//            .dispose(in: self.reactive.bag)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //        searchBar.reactive.text.throttle(seconds: 0.5)
        //            .bind(to: self.viewModel.searchQuery)
        //            .dispose(in: self.reactive.bag)
        return true
    }
}
extension MyCityScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(CityCell.self), for: indexPath) as! CityCell
        cell.setupCell(name: self.cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CityManager.sharedManager.city = self.cities[indexPath.row]
        self.navigationController?.popViewController(animated: true)
    }
    
}
