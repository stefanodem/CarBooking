//
//  CarBookingTests.swift
//  CarBookingTests
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import XCTest
@testable import CarBooking

class CarBookingTests: XCTestCase {
    
    var testLoader: NetworkDataLoader!
    var dateInputController: DateInputViewController!

    override func setUp() {
        testLoader = MockLoader(data: validVehicleJSON, error: nil)
        dateInputController = DateInputViewController()
    }
    
    func testValidVehicleData() {
        let networkService = NetworkService(networkLoader: testLoader, baseUrl: Constants.vehicleBaseUrl)
        let vehicleController = VehicleController(networkService: networkService)
        
        let expectation = self.expectation(description: "Perform vehicle fetch")
        
        vehicleController.load { (response) in
            XCTAssertNotNil(Constants.vehicleBaseUrl)
            
            switch response {
            case .success(let vehicles):
                XCTAssertNotNil(vehicles)
                XCTAssertEqual(vehicles.count, 1)
                XCTAssertEqual(vehicles[0].name, "Batmobile")
            case .error(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testValidInputDates() {
        let startDate = dateInputController.startDate
        let endDate = dateInputController.minEndDate!
        let expectedEndDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        let tomorrow9AM = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: startDate)!
        XCTAssertGreaterThan(endDate, startDate)
        XCTAssertEqual(endDate, expectedEndDate)
        XCTAssertEqual(startDate, tomorrow9AM)
    }

}
