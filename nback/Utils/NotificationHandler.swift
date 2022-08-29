//
//  NotificationHandler.swift
//  nback
//
//  Created by Denis Gradoboev on 29.08.2022.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { succes, error in
            if succes {
                print("Notification enabled")
            } else if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func sendNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        
        var date = DateComponents()
        date.hour = 17
        date.minute = 55
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Today session"
        content.body = "back to N-BACK"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
