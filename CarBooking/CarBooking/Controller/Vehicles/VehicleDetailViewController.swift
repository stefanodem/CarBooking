//
//  VehicleDetailViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 21.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A view controller that shows details of a vehicle and lets users book a vehicle.
 */

class VehicleDetailViewController: UIViewController {
    
    // MARK: - Properties
    var vehicleDetails: VehicleRepresentation {
        didSet {
            setupViews()
        }
    }
    let vehicleController: VehicleController
    
    private var vehicleImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = Constants.placeholderImage
        
        return iv
    }()
    
    // MARK: - Init
    init(vehicleController: VehicleController, vehicle: VehicleRepresentation) {
        self.vehicleController = vehicleController
        self.vehicleDetails = vehicle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        setupViews()
    }
    
    // MARK: - Configuration
    private func setupViews() {
        title = vehicleDetails.name
        view.backgroundColor = .white
        view.addSubview(vehicleImageView)
        vehicleImageView.anchor(top: view.topAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: nil,
                                padding: UIEdgeInsets(top: 30, left: 15, bottom: 15, right: 15))
        vehicleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let imagePath = vehicleDetails.image,
            let url = URL(string: imagePath, relativeTo: Constants.vehicleBaseUrl),
            let image = UIImage.download(from: url) {
            vehicleImageView.image = image
            vehicleImageView.setNeedsDisplay()
        }
    }
    
    private func updateViews() {
        
    }
    
    /// Fetches vehicle details from the network.
    private func loadDetails() {        
        vehicleController.loadDetail(for: vehicleDetails.identifier,completion: { (response) in
            DispatchQueue.main.async {
                switch response {
                case .success(let vehicleDetails):
                    self.vehicleDetails = vehicleDetails
                case .error(let error):
                    break
                    // TODO: handle error
                }
            }
        })
    }
    
}
