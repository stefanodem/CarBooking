//
//  AppDelegate.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let tabBarController = UITabBarController()
        let vehicleSplitVC =  UISplitViewController()
        let vehiclesMainVC = VehiclesTableViewController()
        let vehicleDetailVC = VehicleDetailViewController()
        let vehiclesMainNavVC = UINavigationController(rootViewController: vehiclesMainVC)
        let vehicleDetailNavVC = UINavigationController(rootViewController: vehicleDetailVC)
        
        vehicleSplitVC.viewControllers = [vehiclesMainNavVC, vehicleDetailNavVC]
        vehicleSplitVC.preferredDisplayMode = .allVisible
        vehicleSplitVC.delegate = self
        vehicleSplitVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        vehiclesMainVC.detailVC = vehicleDetailVC
        
        vehicleDetailNavVC.navigationItem.leftItemsSupplementBackButton = true
        vehicleDetailNavVC.navigationItem.leftBarButtonItem = vehicleSplitVC.displayModeButtonItem
        
        tabBarController.viewControllers = [vehicleSplitVC]
        
        self.window!.rootViewController = tabBarController
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let detailNavVC = secondaryViewController as? UINavigationController,
            let detailVC = detailNavVC.topViewController as? VehicleDetailViewController else {
            return false
        }
        
        /// Checks if current detailVC has a vehicle, else push the primary VC onto the nav stack.
        if detailVC.vehicle == nil {
            return true
        }
        
        return false
    }

}
