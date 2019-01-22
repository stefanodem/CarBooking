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
        
        // Initializing vehicle controllers
        let vehicleSplitVC =  UISplitViewController()
        let vehicleNetworkService = NetworkService(baseUrl: Constants.vehicleBaseUrl)
        let vehicleController = VehicleController(networkService: vehicleNetworkService)
        let vehiclesMainVC = VehiclesViewController(vehicleController: vehicleController)
        //let vehicleDetailVC = VehicleDetailViewController()
        let vehiclesMainNavVC = UINavigationController(rootViewController: vehiclesMainVC)
        //let vehicleDetailNavVC = UINavigationController(rootViewController: vehicleDetailVC)
        
        vehicleSplitVC.viewControllers = [vehiclesMainNavVC]
        vehicleSplitVC.preferredDisplayMode = .allVisible
        vehicleSplitVC.delegate = self
        vehicleSplitVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        //vehiclesMainVC.detailViewController = vehicleDetailVC
        
        // Initializing booking controllers
        let bookingSplitVC =  UISplitViewController()
        let bookingNetworkService = NetworkService(baseUrl: Constants.vehicleBaseUrl)
        let bookingController = VehicleController(networkService: bookingNetworkService)
        let bookingsMainVC = VehiclesViewController(vehicleController: bookingController)
        //let bookingDetailVC = VehicleDetailViewController()
        let bookingsMainNavVC = UINavigationController(rootViewController: bookingsMainVC)
        //let bookingDetailNavVC = UINavigationController(rootViewController: bookingDetailVC)
        
        bookingSplitVC.viewControllers = [bookingsMainNavVC]
        bookingSplitVC.preferredDisplayMode = .allVisible
        bookingSplitVC.delegate = self
        bookingSplitVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        //bookingsMainVC.detailViewController = bookingDetailVC
        
        tabBarController.viewControllers = [vehicleSplitVC, bookingSplitVC]
        
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
        if detailVC.vehicleDetails == nil {
            return true
        }
        
        return false
    }

}
