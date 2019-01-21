//
//  VehiclesTableViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 21.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

class VehiclesTableViewController: UIViewController {

    // MARK: - Properties
    var detailViewController: VehicleDetailViewController? // TODO: Weak?
    var tableViewController: GenericTableViewController<VehicleRepresentation, UITableViewCell>?
    let vehicleController: VehicleController
    var vehicles = [VehicleRepresentation]() {
        didSet {
            tableViewController?.items = vehicles
        }
    }
    
    // MARK: - Init
    init(frame: CGRect = CGRect.zero, vehicleController: VehicleController) {
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
        let tableVC = GenericTableViewController<VehicleRepresentation, UITableViewCell>(items: vehicles,
                                                                                         configure: configureCell,
                                                                                         selectedCellHandler: handleSelectedCell)
        // Adds the tableViewController as a child view controller
        add(tableVC)
        tableVC.tableView.fillSuperview()
        tableViewController = tableVC
    }
    
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
    private func handleSelectedCell(for vehicle: VehicleRepresentation) {
        if let detailVC = detailViewController, let detailNavVC = detailVC.navigationController {
            detailVC.view.backgroundColor = .red
            splitViewController?.showDetailViewController(detailNavVC, sender: nil)
        }
    }
    
    private func configureCell(_ cell: UITableViewCell, for vehicle: VehicleRepresentation) {
        cell.textLabel?.text = vehicle.name
    }
    
}
