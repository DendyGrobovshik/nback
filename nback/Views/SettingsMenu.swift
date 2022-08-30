//
//  SettingsMenu.swift
//  nback
//
//  Created by Denis Gradoboev on 30.08.2022.
//

import SwiftUI

struct SettingsMenu: View {
    @Binding var sessionTime: Double
    
    @AppStorage("IDENTIFIER") var identifier: String = ""
    @AppStorage("HOUR") var hour: Int = 21
    @AppStorage("MINUTE") var minute: Int = 30
    @State() var date: Date = Calendar.current.date(bySettingHour: 21, minute: 30, second: 0, of: Date())!
    
    let notify = NotificationHandler()
    
    var body: some View {
        VStack {
            HStack {
                Text("Session time: \(Int(sessionTime))")
                Slider(
                    value: $sessionTime,
                    in: 1...60
                )
            }
            if identifier == "" {
                HStack {
                    DatePicker(
                        "Notification time",
                        selection: $date,
                        displayedComponents: [.hourAndMinute]
                    )
                    .frame(width: 180)
                    Button("Set the time of daily notifications") {
                        notify.disableNotification(identifier: identifier)
                        
                        identifier = UUID().uuidString
                        hour = Calendar.current.component(.hour, from: date)
                        minute = Calendar.current.component(.minute, from: date)
                        notify.enableNotification(identifier: identifier, hour: hour, minute: minute)
                    }
                }
                .font(.title3)
            } else {
                HStack {
                    Text("The daily notification comes in \(hour):\(minute)")
                    
                    Button("Remove") {
                        notify.disableNotification(identifier: identifier)
                        identifier = ""
                    }
                }
            }
            
            Spacer()
                .frame(maxHeight: 50)
            
            Text("Problems with notifications?")
                .foregroundColor(.blue)
            Text("↓")
                .foregroundColor(.blue)
            Button("Ask permission for notification") {
                notify.askPermission()
            }
        }
        .padding()
    }
}

struct SettingsMenu_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenu(sessionTime: .constant(15.0))
    }
}
