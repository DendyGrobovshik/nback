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
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { succes, error in
                if succes {
                    print("Notification enabled")
                } else if let error = error {
                    print(error.localizedDescription)
                }
                
            }
    }
    
    func enableNotification(identifier: String, hour: Int, minute: Int) {
        var date = DateComponents()
        date.hour = hour
        date.minute = minute
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true
        )
        
        let content = UNMutableNotificationContent()
        content.title = "Today session"
        content.body = "Oh, this time... so, back to N-BACK"
        content.sound = UNNotificationSound.default
        
        print(UUID().uuidString)
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func disableNotification(identifier: String) {
        UNUserNotificationCenter.current()
            .removeDeliveredNotifications(withIdentifiers: [identifier])
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
