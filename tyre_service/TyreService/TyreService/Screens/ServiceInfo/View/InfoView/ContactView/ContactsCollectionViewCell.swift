//
//  ContacntsCollectionViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import UIKit
import MapKit

class ContactsCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "ContactsCollectionViewCell"
    @IBOutlet weak var buttonMakeCall: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        initButtonMakeCall()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    func initButtonMakeCall() {
        buttonMakeCall.layer.cornerRadius = 8
        buttonMakeCall.layer.borderWidth = 1
        buttonMakeCall.layer.borderColor = UIColor(named: "buttonBorderColor")?.cgColor
    }
    
    @IBAction func actionMakeCall(_ sender: Any) {
        
    }
    
    func configure(viewModel: ContactsCellViewModel) {
        addressLabel.text = viewModel.address
        phoneLabel.text = viewModel.phone
        workTimeLabel.text = viewModel.workTime
        guard let lat = viewModel.latitude, let lon = viewModel.longitude else { return }
        showMapMarker(lat: lat, lon: lon)
    }
    
    private func showMapMarker(lat: Double, lon: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: false)
    }
    
}
