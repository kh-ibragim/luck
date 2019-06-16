//
//  MapScreenViewModel.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit
import CoreLocation
import YandexMapKit
import YandexMapKitSearch

class MapScreenViewModel: BaseViewModel {
    let loadData = PublishSubject<Bool, NoError>()
    var mapObjects: MapObject?
    let yRegion = Property<YMKVisibleRegion?>(nil)
    var searchManager: YMKSearchManager!
    var searchSession: YMKSearchSession!
    
    var entertainmentArray: [Feature]?
    var educationArray: [Feature]?
    var medicineArray: [Feature]?
    var carArray: [Feature]?
    var shopArray: [Feature]?
    var trafficArray: [Feature]?
    var busArray: [Feature]?
    var logisticArray: [Feature]?

    func getData(completionHandler: @escaping (Bool, NSError?) -> Void) {
        self.cleanData()
        self.showHUD.next(true)
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "развлечения") { (object, error) in
            self.entertainmentArray = object?.features
            dGroup.leave()
        }
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "образование") { (object, error) in
            self.educationArray = object?.features
            dGroup.leave()
        }
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "медицина") { (object, error) in
            self.medicineArray = object?.features
            dGroup.leave()
        }
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "магазины") { (object, error) in
            self.shopArray = object?.features
            dGroup.leave()
        }
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "траффик") { (object, error) in
            self.trafficArray = object?.features
            dGroup.leave()
        }
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "остановки") { (object, error) in
            self.busArray = object?.features
            dGroup.leave()
        }
        
        dGroup.enter()
        self.getObject(latitude: "34.101075", longitude: "44.949581", text: "логистика") { (object, error) in
            self.logisticArray = object?.features
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main, execute: {
           // self.filtrationDataList()
            self.showHUD.next(false)
            completionHandler(true, nil)
        })
    }
    
    func getObject(latitude: String, longitude: String, text: String, completionHandler: @escaping (Response?, NSError?) -> Void)  {
        API.Map.getObjects(latitude: latitude, longitude: longitude, text: text).responseObject(Response.self){ (rate, error) in
            if error != nil {
                completionHandler(nil, error)
            } else {
                completionHandler(rate, nil)
            }
        }
    }
    
    func cleanData() {
        
    }
}
