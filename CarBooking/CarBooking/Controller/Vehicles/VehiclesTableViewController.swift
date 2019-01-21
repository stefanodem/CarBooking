//
//  VehiclesTableViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 21.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

class VehiclesTableViewController: UITableViewController {

    var detailVC: VehicleDetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        title = "Vehicles"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = "sdfdsfs"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = detailVC, let detailNavVC = detailVC.navigationController {
            detailVC.view.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
            splitViewController?.showDetailViewController(detailNavVC, sender: nil)
        }
    }
    
}
