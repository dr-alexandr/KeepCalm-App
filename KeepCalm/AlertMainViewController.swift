//
//  ViewController.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 28.12.2022.
//

import UIKit
import SnapKit
import CoreLocation

final class AlertMainViewController: UIViewController {
    
    // MARK: - Vars and Lets
    private let locationManager = CLLocationManager()
    private let currentLocationLabel = UILabel.getDefaultBoldLabel(size: 22)
    private let statusLabel = UILabel.getDefaultBoldLabel(size: 22)
    private let reloadButton = UIButton.getDefaultButton(text: "Оновити данні")
    private let mapButton = UIButton.getSFButton(sfSymbol: "map.fill", isEnabled: false)
    private let colorView = UIView()
    private let loader = UIActivityIndicatorView()
    private let viewModel = AlertMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
    }
    
    // MARK: - Helpers
    private func setupUI() {
        loader.startAnimating()
        view.backgroundColor = .darkGray
        reloadButton.addTarget(self, action: #selector(updateInfo), for: .touchUpInside)
        mapButton.addTarget(self, action: #selector(goToMapScreen), for: .touchUpInside)
        getStatusBind()
        locationSetup()
    }
    
    @objc func updateInfo() {
        statusLabel.text = "Перевіряю статус..."
        mapButton.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.colorView.backgroundColor = .darkGray
        }
        viewModel.getRegionsStatus()
    }
    
    @objc func goToMapScreen() {
        let vc = MapViewController()
        vc.viewModel.cities = viewModel.data
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
    
    private func getStatusBind() {
        viewModel.keepCalmStatus = { [weak self] in
            guard let self = self else { return }
            self.resetAnimated(self.statusLabel, text: "Все спокійно. \n У вашій області тривога відсутня.")
            UIView.animate(withDuration: 0.2) {
                self.colorView.backgroundColor = UIColor(named: "KeepCalm") ?? .green
            }
            self.mapButton.isEnabled = true
        }
        viewModel.hideStatus = { [weak self] in
            guard let self = self else { return }
            self.resetAnimated(self.statusLabel, text: "Повітряна тривога, ховайся!")
            UIView.animate(withDuration: 0.2) {
                self.colorView.backgroundColor = UIColor(named: "Alarm") ?? .red
            }
            self.mapButton.isEnabled = true
        }
        viewModel.unknownStatus = { [weak self] in
            guard let self = self else { return }
            self.resetAnimated(self.statusLabel, text: "Відсутня інформація по вашому місцю знаходження.")
            UIView.animate(withDuration: 0.2) {
                self.colorView.backgroundColor = .darkGray
            }
            self.mapButton.isEnabled = true
        }
    }
    
    private func setupLayout() {
        view.addSubview(currentLocationLabel)
        currentLocationLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        view.addSubview(loader)
        loader.color = .white
        loader.style = .large
        loader.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(currentLocationLabel)
        }
        view.addSubview(colorView)
        colorView.backgroundColor = .darkGray
        colorView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        statusLabel.text = "Перевіряю статус..."
        colorView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        colorView.addSubview(reloadButton)
        reloadButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        colorView.addSubview(mapButton)
        mapButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(statusLabel).inset(150)
        }
    }
    
    private func locationSetup() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - CLLocationMangerDelegate
extension AlertMainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            guard (error == nil) else {return}
            guard let placemark = placemarks else {return}
            let currentPlacemark = placemark[0]
            UserDefaults.standard.setValue(currentPlacemark.administrativeArea, forKey: "REGION")
            self.loader.stopAnimating()
            self.currentLocationLabel.text = "м.\(currentPlacemark.locality!)\n\(currentPlacemark.administrativeArea!), \(currentPlacemark.country!)"
            self.viewModel.getRegionsStatus()
            self.locationManager.stopUpdatingLocation()
        }
    }
}
