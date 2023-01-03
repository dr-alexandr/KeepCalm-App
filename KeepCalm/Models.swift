//
//  Models.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 28.12.2022.
//

import Foundation
import MapKit

struct Cities: Codable {
    let mykolayiv: String?
    let chernihiv: String?
    let rivne: String?
    let chernivtsi: String?
    let ivanoFrankivsk: String?
    let khmelnytskyy: String?
    let lviv: String?
    let ternopil : String?
    let transcarpathia : String?
    let volyn : String?
    let cherkasy : String?
    let kirovohrad : String?
    let kyiv : String?
    let odessa : String?
    let vinnytsya : String?
    let zhytomyr : String?
    let sumy : String?
    let dnipropetrovsk : String?
    let donetsk : String?
    let kharkiv : String?
    let poltava : String?
    let zaporizhzhya : String?
    let kyivCity : String?
    let kherson : String?
    let luhansk : String?
    let sevastopol : String?
    let crimea : String?

    enum CodingKeys: String, CodingKey {
        case mykolayiv = "Mykolayiv"
        case chernihiv = "Chernihiv"
        case rivne = "Rivne"
        case chernivtsi = "Chernivtsi"
        case ivanoFrankivsk = "Ivano-Frankivs'k"
        case khmelnytskyy = "Khmel'nyts'kyy"
        case lviv = "L'viv"
        case ternopil = "Ternopil'"
        case transcarpathia = "Transcarpathia"
        case volyn = "Volyn"
        case cherkasy = "Cherkasy"
        case kirovohrad = "Kirovohrad"
        case kyiv = "Kyiv"
        case odessa = "Odessa"
        case vinnytsya = "Vinnytsya"
        case zhytomyr = "Zhytomyr"
        case sumy = "Sumy"
        case dnipropetrovsk = "Dnipropetrovs'k"
        case donetsk = "Donets'k"
        case kharkiv = "Kharkiv"
        case poltava = "Poltava"
        case zaporizhzhya = "Zaporizhzhya"
        case kyivCity = "Kyiv City"
        case kherson = "Kherson"
        case luhansk = "Luhans'k"
        case sevastopol = "Sevastopol"
        case crimea = "Crimea"
    }
}

struct PolygonInfo: Codable {
    
    let shapeID: String
    let level: String
    let shapeISO: String
    let shapeType: String
    let shapeName: String
    let shapeGroup: String

    enum CodingKeys: String, CodingKey {
        case shapeID = "shapeID"
        case level = "Level"
        case shapeISO = "shapeISO"
        case shapeName = "shapeName"
        case shapeGroup = "shapeGroup"
        case shapeType = "shapeType"
    }
}

struct MapOverlayer {
    var overlay : MKOverlay
    var polygonInfo : PolygonInfo
}

//Storing our Overlay Shape
class MapOverlays {
    private var overlayList = [MapOverlayer]()
    static var shared = MapOverlays()
    
    func addOverlay(mapOverlayer: MapOverlayer) {
        MapOverlays.shared.overlayList.append(mapOverlayer)
    }
    
    func returnOverlayList() -> [MapOverlayer] {
        return MapOverlays.shared.overlayList
    }
}

//Track the latest Shape Overlay
class overlayer {
    static var shared = overlayer(polygonInfo: PolygonInfo(shapeID: "", level: "", shapeISO: "", shapeType: "", shapeName: "", shapeGroup: ""))
    var polygonInfo : PolygonInfo
    
    init(polygonInfo: PolygonInfo){
        self.polygonInfo = polygonInfo
    }
    
    func changePolygon(newPolygon: PolygonInfo){
        self.polygonInfo = newPolygon
    }
}
