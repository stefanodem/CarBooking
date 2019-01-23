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
        
    private var profileView: ProfileView!
    private let dateInputVC = DateInputViewController()
    private var padding = Constants.defaultPadding
    
    private var bookingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Book Now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.accent
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleBooking), for: .touchUpInside)
        return button
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
        title = "Make a booking"
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.primary
        
        guard let imagePath = vehicleDetails.image else { return }
        
        // Setup profile view
        let aDescription = (UIDevice.current.userInterfaceIdiom == .pad ? vehicleDetails.descript : vehicleDetails.shortDescript) ?? ""
        let imageUrl = URL(string: imagePath, relativeTo: Constants.vehicleBaseUrl)
        let image = UIImage.download(from: imageUrl)
        profileView = ProfileView(image: image, title: vehicleDetails.name, description: aDescription)
        view.addSubview(profileView)
        profileView.anchor(top: view.topAnchor,
                           leading: view.leadingAnchor,
                           bottom: nil,
                           trailing: view.trailingAnchor,
                           padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        profileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65).isActive = true
        
        // Setup date input view
        add(dateInputVC)
        view.addSubview(dateInputVC.view)
        dateInputVC.view.anchor(top: profileView.bottomAnchor,
                                leading: view.leadingAnchor,
                                bottom: nil,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        dateInputVC.view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        // Setup booking button
        view.addSubview(bookingButton)
        bookingButton.anchor(top: nil,
                             leading: view.leadingAnchor,
                             bottom: view.bottomAnchor,
                             trailing: view.trailingAnchor,
                             padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        bookingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    // MARK: - User actions
    @objc private func handleBooking() {
        print("booked")
    }
    
}
