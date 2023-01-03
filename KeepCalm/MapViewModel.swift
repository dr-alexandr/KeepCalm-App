//
//  MapViewModel.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 03.01.2023.
//

import Foundation
import MapKit

final class MapViewModel {
    
    var cities: Cities?
    
    func checkAlarm(area: String) -> UIColor {
        guard let cities = cities else { return UIColor(named: "MapUnknown") ?? .gray}
        switch area {
        case "Autonomous Republic of Crimea":
            if cities.crimea == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.crimea == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Sevastopol":
            if cities.sevastopol == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.sevastopol == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Kherson Oblast":
            if cities.kherson == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.kherson == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Volyn Oblast":
            if cities.volyn == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.volyn == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Rivne Oblast":
            if cities.rivne == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.rivne == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Zhytomyr Oblast":
            if cities.zhytomyr == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.zhytomyr == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Chernihiv Oblast":
            if cities.chernihiv == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.chernihiv == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Sumy Oblast":
            if cities.sumy == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.sumy == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Kharkiv Oblast":
            if cities.kharkiv == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.kharkiv == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Luhansk Oblast":
            if cities.luhansk == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.luhansk == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Donetsk Oblast":
            if cities.donetsk == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.donetsk == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Zaporizhia Oblast":
            if cities.zaporizhzhya == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.zaporizhzhya == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Lviv Oblast":
            if cities.lviv == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.lviv == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Ivano-Frankivsk Oblast":
            if cities.ivanoFrankivsk == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.ivanoFrankivsk == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Zakarpattia Oblast":
            if cities.transcarpathia == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.transcarpathia == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Ternopil Oblast":
            if cities.ternopil == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.ternopil == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Chernivtsi Oblast":
            if cities.chernivtsi == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.chernivtsi == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Odessa Oblast":
            if cities.odessa == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.odessa == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Mykolaiv Oblast":
            if cities.mykolayiv == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.mykolayiv == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Vinnytsia Oblast":
            if cities.vinnytsya == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.vinnytsya == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Khmelnytskyi Oblast":
            if cities.khmelnytskyy == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.khmelnytskyy == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Cherkasy Oblast":
            if cities.cherkasy == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.cherkasy == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Poltava Oblast":
            if cities.poltava == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.poltava == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Dnipropetrovsk Oblast":
            if cities.dnipropetrovsk == "full" {return UIColor(named: "MapAlarm") ?? .red} else if cities.dnipropetrovsk == nil {return UIColor(named: "MapCalm") ?? .green} else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Kirovohrad Oblast":
            if cities.kirovohrad == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.kirovohrad == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Kyiv":
            if cities.kyivCity == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.kyivCity == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        case "Kyiv Oblast":
            if cities.kyiv == "full" {return UIColor(named: "MapAlarm") ?? .red}
            else if cities.kyiv == nil {return UIColor(named: "MapCalm") ?? .green}
            else {return UIColor(named: "MapUnknown") ?? .gray}
        default:
            return UIColor(named: "MapUnknown") ?? .gray
        }
    }
}
