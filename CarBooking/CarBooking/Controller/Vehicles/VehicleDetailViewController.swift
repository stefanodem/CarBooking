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
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowOffset = CGSize(width: -15, height: 15)
        iv.layer.shadowRadius = 15
        
        return iv
    }()
    
    private var profileView: ProfileView!
    
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
        title = "Make a booking"
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        
        guard let imagePath = vehicleDetails.image,
            let aDescription = vehicleDetails.descript else { return }
        
        // Setup profile view
        let imageUrl = URL(string: imagePath, relativeTo: Constants.vehicleBaseUrl)
        let image = UIImage.download(from: imageUrl)
        profileView = ProfileView(image: image, title: vehicleDetails.name, description: aDescription)
        view.addSubview(profileView)
        profileView.anchor(top: view.topAnchor,
                           leading: view.leadingAnchor,
                           bottom: nil,
                           trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        profileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
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
                case .error(_):
                    break
                    // TODO: handle error
                }
            }
        })
    }
    
}
