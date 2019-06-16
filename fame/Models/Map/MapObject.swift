//
//  MapObject.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation
import ObjectMapper

class MapObject: Mappable {
    var data: [MapObjectData]?
    //var status: Status?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.data <- map["data"]
      //  self.status <- map["status"]
    }
}


class MapObjectData: Mappable {
    var typecode: String?
    var typeColor: String?
    var objname: String?
    var phone: String?
    var latitude: String?
    var typeCaption: String?
    var addr: String?
    var worktime: String?
    var addinfo: String?
    var longitude: String?
    var distance: Int?
    var yandexMap: String?
    var children: [MapObjectData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.typecode <- map["typecode"]
        self.typeColor <- map["typeColor"]
        self.objname <- map["objname"]
        self.phone <- map["phone"]
        self.latitude <- map["latitude"]
        self.typeCaption <- map["typeCaption"]
        self.addr <- map["addr"]
        self.worktime <- map["worktime"]
        self.addinfo <- map["addinfo"]
        self.longitude <- map["longitude"]
        self.distance <- map["distance"]
        self.yandexMap <- map["yandexMap"]
        self.children <- map["children"]
    }
}

class Response: Mappable {
    var features: [Feature]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.features <- map["features"]
    }
}
class Feature: Mappable {
    var properties: [PropertiesElement]?
    var geometry: [GeometryElement]?
    var geometries: [GeometriesElement]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.properties <- map["properties"]
        self.geometry <- map["geometry"]
        self.geometries <- map["geometries"]
        
    }
}

class propertiesElement: Mappable {
    var id: Int?
    var description: String?
    var name: String?
    var boundedBy: [BoundedByElement]?
    ///parse
    var CompanyMetaData    : [CompanyMetaDataElement]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.description <- map["description"]
        self.name <- map["name"]
        self.CompanyMetaData <- map["CompanyMetaData"]
        
    }
}
class BoundedByElement: Mappable {
    var coord: [Float]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.coord <- map["coord"]
        
    }
}
class CompanyMetaDataElement: Mappable {
    var name: String?
    var address: String?
    var Categories: [CategoriesElement]?
    var Phones: [PhonesElement]?
    var Hours: [HoursElement]?
    var Features: [FeaturesElement]?
    var Snippet: [SnippetElement]?
    var Links: [LinksElement]?
    var Properties: [PropertiesElement]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.address <- map["address"]
        self.Categories <- map["Categories"]
        self.Phones <- map["Phones"]
        self.Hours <- map["Hours"]
        self.Features <- map["Features"]
        self.Snippet <- map["Snippet"]
        self.Links <- map["Links"]
        self.Links <- map["Links"]
        self.Properties <- map["Properties"]
    }
}

class CategoriesElement: Mappable {
    var Cclass: String?
    var name : String?
    var Tags: [TagsElement]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.Cclass <- map["class"]
        self.name <- map["name "]
        self.Tags <- map["Tags"]
        
    }
}

class TagsElement: Mappable {
    var type: String?
    var formatted: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.type <- map["type"]
        self.formatted <- map["formatted"]
    }
}

class PhonesElement: Mappable {
    var type: String?
    var formatted: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.type <- map["type"]
        self.formatted <- map["formatted"]
    }
}

class HoursElement: Mappable {
    var text: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.text <- map["text"]
    }
}

class FeaturesElement: Mappable {
    var id: String?
    var type: String?
    var name: String?
    var values: [FeaturesElementValuesElement]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.type <- map["type"]
        self.name <- map["name"]
        self.values <- map["values"]
    }
}

class FeaturesElementValuesElement: Mappable {
    var id: String?
    var value: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.value <- map["value"]
    }
}

class SnippetElement: Mappable {
    var tag: String?
    //need parse
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.tag <- map["tag"]
    }
}

class LinksElement: Mappable {
    var type: String?
    var aref: String?
    var href: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.type <- map["type"]
        self.aref <- map["aref"]
        self.href <- map["href"]
    }
}

class PropertiesElement: Mappable {
    var Property: PropertiesElementProperty?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.Property <- map["Property"]
    }
}

class PropertiesElementProperty: Mappable {
    var key: String?
    var value: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.key <- map["key"]
        self.value <- map["value"]
    }
}

class GeometryElement: Mappable {
    var type: String?
    var coordinates: [Float]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.type <- map["type"]
    }
}

class GeometriesElement: Mappable {
    var type: String?
    var coordinates: [Float]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.type <- map["type"]
    }
}


