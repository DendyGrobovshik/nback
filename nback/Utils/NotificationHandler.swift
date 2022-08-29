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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { succes, error in
            if succes {
                print("Notification enabled")
            } else if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func sendNotification() {
        var date = DateComponents()
        date.hour = 20
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Today session"
        content.body = "Oh, this time... so, back to N-BACK"
        content.sound = UNNotificationSound.default
        
        print(UUID().uuidString)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
