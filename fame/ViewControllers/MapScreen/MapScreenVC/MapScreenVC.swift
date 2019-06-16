//
//  MapScreenVC.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit
import CoreLocation
import YandexMapKit
import ReactiveKit
import MapKit
import DeckTransition

class MapScreenVC: BaseViewController, YMKMapObjectTapListener, CLLocationManagerDelegate, YMKMapCameraListener {
    
    @IBOutlet weak var yandexMap: YMKMapView!
    @IBOutlet weak var searchUserLocation: UIButton!

    var viewModel = MapScreenViewModel()
    var locationManager = CLLocationManager()
    var userLocationLayer: YMKUserLocationLayer!
    var isLocServEnab = false
    var latitude:  Double?
    var longitude: Double?
    var array = [YMKPoint]()
    var initialCameraPosition = YMKCameraPosition()
    let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: 12))
    var lastEnableLatitude = 34.101075
    var lastEnableLongitude = 44.949581
    let deltaTransitionForCamera = 0.0012
    var customPositionCamera: YMKCameraPosition?
    var filterManager = MapFilterManager.sharedManager
    var enableZoom: Float = 10.0
    var isAuthZone = false
    let sizePolygon = 0.011
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupObserve()
        self.getUserLocation()
        self.update()
        self.yandexMap.mapWindow.map.userLocationLayer.isEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        self.getObjectMap()
      //  self.navigationLeftButton()
    }
    //--
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.filterManager.needRequest {
            self.getObjectMap()
            self.filterManager.needRequest = false
        }
        self.hideNavigation = true
        self.hideNavigationShadow()
    }
    //--
    func setupObserve(){
        self.yandexMap.mapWindow.map.addCameraListener(with: self)
        
        self.viewModel.showHUD.observeNext(with: {[weak self] (show) in
            self?.showHUD(show, false, 30)
        }).dispose(in: self.reactive.bag)
        
        _ = self.viewModel.loadData.observeNext { [unowned self] loadData in
            self.update()
            }.dispose(in: self.reactive.bag)
        
        self.viewModel.yRegion.skip(first: 1).observeNext { [unowned self] _ in
            self.getObjectMap()
            }.dispose(in: self.bag)
        
    }
    
    
    @IBAction func popAction(_ sender: UIButton) {
        if self.navigationController?.viewControllers[0] == self {
            self.showMenu()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func willEnterForeground() {
        self.getUserLocation()
        self.update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.yandexMap.mapWindow.onMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
        self.reactive.bag.dispose()
        if self.yandexMap != nil {
            self.yandexMap.mapWindow.map.mapObjects.clear()
            self.yandexMap.mapWindow.map.deinitialize()
            self.yandexMap.mapWindow.deinitialize()
        }
    }
    
    public func update() {
        DispatchQueue.main.async(execute: {
            self.array.removeAll()
            self.yandexMap.mapWindow.map.mapObjects.clear()
            self.setMapView()
        })
    }
    
    func getObjectMap() {
        if self.yandexMap.mapWindow.map.cameraPosition.zoom >= self.enableZoom {
            let centerLat = self.viewModel.yRegion.value?.centerLatitude ?? String(self.filterManager.getUserGeoposition().latitude!)
            let centerLong = self.viewModel.yRegion.value?.centerLongitude ?? String(self.filterManager.getUserGeoposition().longitude!)
            self.viewModel.getData { (complete, error) in
                self.drawPolygon()
            }
        }
    }
    
    func drawPolygon() {
        let lat = 44.949581
        let long = 34.101075
        let trianglePoints = [
            YMKPoint(
                latitude: lat - sizePolygon/2,
                longitude: long + sizePolygon/2),
            YMKPoint(
                latitude: lat,
                longitude: long),
            YMKPoint(
                latitude: lat + (sizePolygon * 0.7),
                longitude: long),
            YMKPoint(
                latitude: lat + sizePolygon/2 + (sizePolygon * 0.7),
                longitude: long + sizePolygon/2),
            YMKPoint(
                latitude: lat + (sizePolygon * 0.7),
                longitude: long + (sizePolygon * 0.7)),
            YMKPoint(
                latitude: lat,
                longitude: long + (sizePolygon * 0.7))
        ]
        
        let triangle = self.yandexMap.mapWindow.map.mapObjects.addPolygon(
            with: YMKPolygon(outerRing: YMKLinearRing(points: trianglePoints), innerRings: []))
        triangle.fillColor = UIColor.goodPlace
        triangle.strokeColor = UIColor.goodPlace
        triangle.strokeWidth = 1
        triangle.zIndex = 100
    }
    
    func getUserLocation() {
        self.locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.isLocServEnab = false
                self.latitude  = Double(self.filterManager.getUserGeoposition().latitude!)
                self.longitude = Double(self.filterManager.getUserGeoposition().longitude!)
                self.setCameraPosition()
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.isLocServEnab = false
                self.latitude  = Double(self.filterManager.getUserGeoposition().latitude!)
                self.longitude = Double(self.filterManager.getUserGeoposition().longitude!)
                self.setCameraPosition()
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
                if let position = self.locationManager.location?.coordinate {
                    self.filterManager.saveUserGeoposition(latitude: Float(position.latitude), longitude: Float(position.longitude))
                    self.isLocServEnab = true
                }
                self.latitude  = Double(self.filterManager.getUserGeoposition().latitude!)
                self.longitude = Double(self.filterManager.getUserGeoposition().longitude!)
                self.setCameraPosition()
            }
        } else {
            self.isLocServEnab = false
            self.latitude  = Double(self.filterManager.getUserGeoposition().latitude!)
            self.longitude = Double(self.filterManager.getUserGeoposition().longitude!)
            self.setCameraPosition()
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    func setCameraPosition() {
        let camera = YMKCameraPosition(target: YMKPoint(latitude: 44.949581, longitude: 34.101075), zoom: 15.0, azimuth: 0, tilt: 0)
        self.setCamera(camera)
    }
    
    func setMapView() {
        
        guard self.viewModel.mapObjects != nil else {
            return
        }
        
        if self.isLocServEnab {
            //  self.searchUserLocation.isHidden = false
        }
        
        
        var cameraPosition = YMKCameraPosition()
        if (self.viewModel.mapObjects?.data?.count)! > 0 {
            let bounds = YMKGetPolylineBounds(YMKPolyline(points: self.array))
            cameraPosition = self.yandexMap.mapWindow.map.cameraPosition(with: bounds!)
            cameraPosition = YMKCameraPosition(target: cameraPosition.target, zoom: cameraPosition.zoom - 0.5, azimuth: 0, tilt: 0)
        } else {
            cameraPosition = YMKCameraPosition(target: YMKPoint(latitude: self.latitude!, longitude: self.longitude!), zoom: 15, azimuth: 0, tilt: 0)
        }
        self.initialCameraPosition = cameraPosition
        cameraPosition = self.customPositionCamera == nil ? cameraPosition : self.customPositionCamera!
        self.yandexMap.mapWindow.map.isRotateGesturesEnabled = false
        //  self.yandexMap.mapWindow.map.move(with: cameraPosition)
        
    }
    
    func setCamera(_ cameraPosition: YMKCameraPosition) {
        self.yandexMap.mapWindow.map.move(with: cameraPosition)
    }
    
    @IBAction func searchUser(_ sender: UIButton) {
        if self.isLocServEnab {
            self.setCameraPosition()
        } else {
            self.showAgreeAlert(title: "", message: "Для определения текущего местоположения включите геолокацию", yesAction: {
                //
            })
        }
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        let filterVC = CategotyFilterVC()
        filterVC.isFromMap = true
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    func onMapObjectTap(with mapObject: YMKMapObject?, point: YMKPoint) -> Bool {
//        let placemarkTitle = mapObject?.userData as! String
//        if placemarkTitle == "user location" {
//            let currentLoc = YMKPoint(latitude: self.latitude!, longitude: self.longitude!)
//            self.yandexMap.mapWindow.map.move(with: YMKCameraPosition(target: currentLoc, zoom: 15, azimuth: 0, tilt: 0))
//            return true
//        }
//        let modal = ModalDetailMapObjectViewController()
//        for objectMap in (self.viewModel.mapObjects?.data)! {
//            let str = objectMap.latitude! + objectMap.longitude!
//            if placemarkTitle == str {
//                modal.objectMap = objectMap
//            }
//        }
//        modal.latitude = self.latitude
//        modal.longitude = self.longitude
//        let transitionDelegate = DeckTransitioningDelegate()
//        modal.transitioningDelegate = transitionDelegate
//        modal.modalPresentationStyle = .custom
//        present(modal, animated: true, completion: nil)
        return true
    }
    
    func onCameraPositionChanged(with map: YMKMap,
                                 cameraPosition: YMKCameraPosition,
                                 cameraUpdateSource: YMKCameraUpdateSource,
                                 finished: Bool) {
        if finished {
//            self.viewModel.yRegion.next(map.visibleRegion(with: cameraPosition))
//            if cameraPosition.zoom >= self.enableZoom {
//              //  self.zoomView.isHidden = true
//            } else {
//             //   self.zoomView.isHidden = false
//                self.array.removeAll()
//                self.yandexMap.mapWindow.map.mapObjects.clear()
//            }
//
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            self.lastEnableLatitude = locations.last!.coordinate.latitude
            self.lastEnableLongitude = locations.last!.coordinate.longitude
            self.latitude = locations.last?.coordinate.latitude
            self.longitude =  locations.last?.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.getUserLocation()
        self.update()
    }
    
}

extension MapScreenVC: YMKLocationDelegate {
    func onLocationUpdated(with location: YMKLocation) {
    }
    
    func onLocationStatusUpdated(with status: YMKLocationStatus) {
    }
}
