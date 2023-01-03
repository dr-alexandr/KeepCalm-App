//
//  AlertMainViewModel.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 28.12.2022.
//

import Foundation

final class AlertMainViewModel {
    
    var keepCalmStatus: (() -> Void)?
    var hideStatus: (() -> Void)?
    var unknownStatus: (() -> Void)?
    
    let networkManager = NetworkManager()
    let regionInfoUrl = URL(string: Constants.alarmUrl)
    var data: Cities? {
        didSet {
            checkLocationStatus()
        }
    }
    
    private func checkLocationStatus() {
        switch UserDefaults.standard.string(forKey: "REGION") {
        case "Вінницька область":
            if data?.vinnytsya == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Миколаївська область":
            if data?.mykolayiv == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Чернігівська область":
            if data?.chernihiv == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Рівненська область":
            if data?.rivne == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Чернівецька область":
            if data?.chernivtsi == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Івано-Франківська область":
            if data?.ivanoFrankivsk == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Хмельницька область":
            if data?.khmelnytskyy == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Львівська область":
            if data?.lviv == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Тернопільська область":
            if data?.ternopil == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Закарпатська область":
            if data?.transcarpathia == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Волинська область":
            if data?.volyn == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Черкаська область":
            if data?.cherkasy == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Кіровоградська область":
            if data?.kirovohrad == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Київська область":
            if data?.kyiv == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Одеська область":
            if data?.odessa == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Житомирська область":
            if data?.zhytomyr == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Сумська область":
            if data?.sumy == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Дніпропетровська область":
            if data?.dnipropetrovsk == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Донецька область":
            if data?.donetsk == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Харківська область":
            if data?.kharkiv == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Полтавська область":
            if data?.poltava == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Запорізька область":
            if data?.zaporizhzhya == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Херсонська область":
            if data?.kherson == nil {keepCalmStatus?()} else {hideStatus?()}
        case "Луганська область":
            if data?.luhansk == nil {keepCalmStatus?()} else {hideStatus?()}
        default:
            unknownStatus?()
        }
    }
    
    func getRegionsStatus() {
        networkManager.request(url: regionInfoUrl!) { [weak self] (result: Result<Cities, Error>) in
            switch result {
            case .success(let response):
                self?.data = response
            case .failure(let error):
                print(error)
            }
        }
    }
}

fileprivate enum Constants {
    static let alarmUrl = "https://sirens.in.ua/api/v1/"
}
