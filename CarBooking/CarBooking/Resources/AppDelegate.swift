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
        // Setup appearance
        Appearance.setupNavigation()
        Appearance.setupTabBar()
        
        // Setup root view controllers
        
        let tabBarController = UITabBarController()
        
        // Initializing vehicle controllers
        let vehicleSplitVC =  UISplitViewController()
        let vehicleNetworkService = NetworkService(baseUrl: Constants.vehicleBaseUrl)
        let vehicleController = VehicleController(networkService: vehicleNetworkService)
        let vehiclesMainVC = VehiclesViewController(vehicleController: vehicleController)
        let vehiclesMainNavVC = UINavigationController(rootViewController: vehiclesMainVC)
        
        vehicleSplitVC.viewControllers = [vehiclesMainNavVC]
        vehicleSplitVC.preferredDisplayMode = .allVisible
        vehicleSplitVC.delegate = self
        let vehicleTabBarTitle = NSLocalizedString("Search", comment: "A title describing the user's searching for vehicles to book.")
        vehicleSplitVC.tabBarItem = UITabBarItem(title: vehicleTabBarTitle, image: UIImage(named: "search"), selectedImage: nil)
        
        // Initializing booking controllers
        let bookingSplitVC =  UISplitViewController()
        let bookingNetworkService = NetworkService(baseUrl: Constants.bookingBaseUrl)
        let bookingController = BookingController(networkService: bookingNetworkService)
        let bookingsMainVC = BookingViewController(bookingController: bookingController)
        let bookingsMainNavVC = UINavigationController(rootViewController: bookingsMainVC)
        
        bookingSplitVC.viewControllers = [bookingsMainNavVC]
        bookingSplitVC.preferredDisplayMode = .allVisible
        bookingSplitVC.delegate = self
        let bookingTabBarTitle = NSLocalizedString("Bookings", comment: "A title describing the user's booked vehicles.")
        bookingSplitVC.tabBarItem = UITabBarItem(title: bookingTabBarTitle, image: UIImage(named: "car"), selectedImage: nil)
        
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
        if detailVC.vehicle == nil {
            return true
        }
        
        return false
    }

}
