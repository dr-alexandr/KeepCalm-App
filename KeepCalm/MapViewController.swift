//
//  MapViewController.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 29.12.2022.
//

import UIKit
import SnapKit
import MapKit

final class MapViewController: UIViewController {
    private let containerView = UIView.getMapContainerView()
    private let dimmedView = UIView.getDimmedView()
    private let maxDimmedAlpha: CGFloat = 0.6
    private let mapView = MKMapView()
    let viewModel = MapViewModel()
    private lazy var northEastCoordinate = CLLocationCoordinate2D(latitude:Constants.northLatitude, longitude: Constants.eastLongitude)
    private lazy var southWestCoordinate = CLLocationCoordinate2D(latitude: Constants.southLatitude, longitude: Constants.westLongitude)
    private lazy var northEastPoint = MKMapPoint(northEastCoordinate)
    private lazy var southWestPoint = MKMapPoint(southWestCoordinate)
    private lazy var mapRect = MKMapRect(x: fmin(northEastPoint.x,southWestPoint.x),
                                 y: fmin(northEastPoint.y,southWestPoint.y),
                                 width: fabs(northEastPoint.x-southWestPoint.x),
                                 height: fabs(northEastPoint.y-southWestPoint.y))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isUserInteractionEnabled = false
        mapView.setCameraBoundary(MKMapView.CameraBoundary(mapRect: mapRect), animated: true)
        mapView.layer.cornerRadius = 25
        loadGeoJson()
    }
    
    private func setupLayout() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerY.centerY.equalToSuperview()
            make.height.equalTo(375)
        }
        containerView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(300)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func loadGeoJson() {
        guard let url = Bundle.main.url(forResource: "UkraineGeoJSONProvinces", withExtension: "geojson") else {
            fatalError("unable to get geojson")
        }
        var geoJson = [MKGeoJSONObject]()
        var overlays = [MKOverlay]()
        do {
            let data = try Data(contentsOf: url)
            geoJson = try MKGeoJSONDecoder().decode(data)
        } catch {
            fatalError("Unable to decode JSON")
        }
        for item in geoJson {
            if let feature = item as? MKGeoJSONFeature {
                let geometry = feature.geometry.first
                let propData = feature.properties!
                if let polygon = geometry as? MKPolygon {
                    let polygonInfo = try? JSONDecoder.init().decode(PolygonInfo.self, from: propData)
                    render(overlay: polygon, info: polygonInfo)
                }
                if let multiPolygon = geometry as? MKMultiPolygon {
                    let polygonInfo = try? JSONDecoder.init().decode(PolygonInfo.self, from: propData)
                    render(overlay: multiPolygon, info: polygonInfo)
                }
                for geo in feature.geometry {
                    if let polygon = geo as? MKPolygon {
                        overlays.append(polygon)
                    }
                }
            }
        }
    }
    
    func render(overlay: MKOverlay, info: Any?) {
        if let polygonInfo = info as? PolygonInfo {
            overlayer.shared.changePolygon(newPolygon: polygonInfo)
        }
        let newMapOverlay = MapOverlayer(overlay: overlay, polygonInfo: overlayer.shared.polygonInfo)
        MapOverlays.shared.addOverlay(mapOverlayer: newMapOverlay)
        mapView.addOverlay(overlay)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.fillColor = viewModel.checkAlarm(area: overlayer.shared.polygonInfo.shapeName)
            renderer.lineWidth = 0.1
            renderer.polygon.title = overlayer.shared.polygonInfo.shapeName
            renderer.polygon.subtitle = "\(overlayer.shared.polygonInfo.shapeID)"
            return renderer
        }
        if let multiPolygon = overlay as? MKMultiPolygon {
            let renderer = MKMultiPolygonRenderer(multiPolygon: multiPolygon)
            renderer.fillColor = viewModel.checkAlarm(area: overlayer.shared.polygonInfo.shapeName)
            renderer.lineWidth = 0.1
            renderer.multiPolygon.title = overlayer.shared.polygonInfo.shapeName
            renderer.multiPolygon.subtitle = "\(overlayer.shared.polygonInfo.shapeID)"
            return renderer
        }
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}

// MARK: - Constants Enum
fileprivate enum Constants {
    static let northLatitude = 53.024001
    static let southLatitude = 43.559654
    static let eastLongitude = 40.753240
    static let westLongitude = 21.417305
}
