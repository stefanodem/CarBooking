//
//  GenericTableViewController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 21.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A generic table view controller.
 */

class GenericTableViewController<Ressource, Cell: UITableViewCell>: UITableViewController {
    var items: [Ressource] {
        didSet {
            tableView.reloadData()
        }
    }
    var configure: (Cell, Ressource) -> ()
    var selectedCellHandler: (Ressource) -> ()
    
    init(items: [Ressource], configure: @escaping (Cell, Ressource) -> (), selectedCellHandler: @escaping (Ressource) -> ()) {
        self.items = items
        self.configure = configure
        self.selectedCellHandler = selectedCellHandler
        super.init(style: .plain)
        self.tableView.register(Cell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! Cell
        
        let item = items[indexPath.row]
        configure(cell, item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        selectedCellHandler(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
