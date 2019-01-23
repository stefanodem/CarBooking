//
//  VehiclesTableViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 21.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A table view which lists all vehicles available in the car pool.
 */

class VehiclesViewController: UIViewController {

    // MARK: - Properties
    var detailViewController: VehicleDetailViewController?
    var tableViewController: GenericTableViewController<VehicleRepresentation, UITableViewCell>?
    let vehicleController: VehicleController
    var vehicles = [VehicleRepresentation]() {
        didSet {
            tableViewController?.items = vehicles
        }
    }
    
    // MARK: - Init
    init(vehicleController: VehicleController) {
        self.vehicleController = vehicleController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVehicles()
        setupViews()
        setupTableView()
    }
    
    // MARK: - Configuration
    private func setupViews() {
        title = "Vehicles"
    }
    
    /// Sets up a table view for listing vehicles
    private func setupTableView() {
        let tableVC = GenericTableViewController<VehicleRepresentation, UITableViewCell>(items: vehicles, configure: configureCell, selectedCellHandler: handleSelectedCell)
        // Adds the tableViewController as a child view controller
        add(tableVC)
        tableVC.tableView.fillSuperview()
        tableViewController = tableVC
    }
    
    // MARK: - Networking
    /// Fetches vehicles from the network.
    private func loadVehicles() {
        vehicleController.load(completion: { (response) in
            DispatchQueue.main.async {
                switch response {
                case .success(let vehicles):
                    self.vehicles = vehicles
                case .error(let error):
                    break
                    // TODO: handle error
                }
            }
        })
    }
    
    // MARK: - TableView
    /// Handles selection of a vehicle and navigates to the detail view controller.
    private func handleSelectedCell(for vehicle: VehicleRepresentation) {
        let detailVCs = VehicleDetailViewController(vehicleController: vehicleController, vehicle: vehicle)
        splitViewController?.showDetailViewController(detailVCs, sender: nil)
//        if let detailVC = detailViewController, let detailNavVC = detailVC.navigationController {
//            let detailVC = VehicleDetailViewController()
//            detailVC.vehicleDetails = vehicle
//            detailVC.vehicleController = vehicleController
//            splitViewController?.showDetailViewController(detailNavVC, sender: nil)
//        }
    }
    
    /// Handles configuration of cell.
    private func configureCell(_ cell: UITableViewCell, for vehicle: VehicleRepresentation) {
        cell.textLabel?.text = vehicle.name
    }
    
}
