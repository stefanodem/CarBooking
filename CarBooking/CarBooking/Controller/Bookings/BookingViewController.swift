//
//  BookingViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 23.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A table view which lists all bookings of the user.
 */

class BookingViewController: UIViewController {
    
    // MARK: - Properties
    var tableViewController: GenericTableViewController<Booking, GenericTableViewCell>?
    let bookingController: BookingController
    var bookings = [Booking]() {
        didSet {
            tableViewController?.items = bookings
        }
    }
    
    // MARK: - Init
    init(bookingController: BookingController) {
        self.bookingController = bookingController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadVehicles()
    }
    
    // MARK: - Configuration
    private func setupViews() {
        title = NSLocalizedString("Bookings", comment: "A view title indicating a list of books.")
    }
    
    /// Sets up a table view for listing vehicles
    private func setupTableView() {
        let tableVC = GenericTableViewController<Booking, GenericTableViewCell>(items: bookings, configure: configureCell, selectedCellHandler: handleSelectedCell)
        // Adds the tableViewController as a child view controller
        add(tableVC)
        tableVC.tableView.fillSuperview()
        tableVC.tableView.backgroundColor = UIColor.primary
        tableVC.tableView.separatorColor = UIColor.accent
        tableVC.tableView.tableFooterView = UIView()
        tableViewController = tableVC
    }
    
    // MARK: - Networking
    /// Fetches vehicles from the network.
    private func loadVehicles() {
        bookingController.load(completion: { (response) in
            DispatchQueue.main.async {
                switch response {
                case .success(let bookings): // Response type: (Booking, Vehicle)
                    self.bookings = bookings
                case .error(let error):
                    NSLog("Error while loading vehicles: \(error)")
                }
            }
        })
    }
    
    // MARK: - TableViewController
    /// Handles selection of a vehicle and navigates to the detail view controller.
    private func handleSelectedCell(for booking: Booking) {
        guard let vehicle = booking.vehicle else {
            NSLog("Could not load vehicle associated with booking")
            return
        }
        
        let vehicleRep = VehicleRepresentation(identifier: vehicle.identifier, name: vehicle.name ?? "", shortDescript: vehicle.shortDescript, descript: vehicle.descript, image: vehicle.image)
        let detailVCs = VehicleDetailViewController(vehicle: vehicleRep)
        splitViewController?.showDetailViewController(detailVCs, sender: nil)
    }
    
    /// Handles configuration of cell.
    private func configureCell(_ cell: GenericTableViewCell, for booking: Booking) {
        guard let name = booking.vehicle?.name, let startDate = booking.startDate, let endDate = booking.endDate else {
            NSLog("Could not load vehicle associated with booking and/or booking dates")
            return
        }
        
        let bookingDates = "\(formatToString(startDate)) to \(formatToString(endDate))"
        let content = GenericTableViewCell.CellContent(title: name, detail: bookingDates)
        cell.content = content
    }
    
    // MARK: - Helpers
    private func formatToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        return dateFormatter.string(from: date)
    }
    
}
