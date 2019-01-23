//
//  LocalNotificationsHelper.swift
//  CarBooking
//
//  Created by De MicheliStefano on 23.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    let center = UNUserNotificationCenter.current()
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func createNotification(for date: Date) {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("A reminder of your upcoming booking.", comment: "A title for the user to be reminded of an upcoming booking.")
        content.body = "We would like to remind you that you have a booking at \(formatToString(date))"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "bookings"
        
        //var dateComponent = DateComponents()
        guard let triggerDate = Calendar.current.date(byAdding: .minute, value: -30, to: date) else { return }
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day], from: triggerDate)
        
        let notificationRequest = UNNotificationRequest(identifier: formatToString(date), content: content, trigger: UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true))
        
        center.add(notificationRequest) { (error) in
            if let error = error {
                NSLog("There was an error scheduling a notification: \(error)")
            }
        }
    }
    
    private func formatToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        return dateFormatter.string(from: date)
    }
}
