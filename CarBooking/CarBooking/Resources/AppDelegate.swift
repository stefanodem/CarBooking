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
        
        // Setup mockServices for booking controllers
        
        // Initializing vehicle controllers
        let vehicleSplitVC =  UISplitViewController()
        // Setup a mocking loader for booking controller.
        let mockLoader = MockLoader(data: mockJSON, error: nil)
        let bookingMockService = NetworkService(networkLoader: mockLoader, baseUrl: Constants.bookingBaseUrl)
        let bookingMockController = BookingController(networkService: bookingMockService)
        // Setup vehicle controller.
        let vehicleNetworkService = NetworkService(baseUrl: Constants.vehicleBaseUrl)
        let vehicleController = VehicleController(networkService: vehicleNetworkService)
        // Setup vehicle view controllerand inject booking & vehicle controller.
        let vehiclesMainVC = VehiclesViewController(vehicleController: vehicleController, bookingController: bookingMockController)
        let vehiclesMainNavVC = UINavigationController(rootViewController: vehiclesMainVC)
        
        vehicleSplitVC.viewControllers = [vehiclesMainNavVC]
        vehicleSplitVC.preferredDisplayMode = .allVisible
        vehicleSplitVC.delegate = self
        let vehicleTabBarTitle = NSLocalizedString("Search", comment: "A title describing the user's searching for vehicles to book.")
        vehicleSplitVC.tabBarItem = UITabBarItem(title: vehicleTabBarTitle, image: UIImage(named: "search"), selectedImage: nil)
        
        // Initializing booking controllers
        let bookingSplitVC =  UISplitViewController()
        // Setup booking controller.
        let bookingNetworkService = NetworkService(baseUrl: Constants.bookingBaseUrl)
        let bookingController = BookingController(networkService: bookingNetworkService)
        // Setup booking view controller and inject booking controller.
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

        return true
    }

}
