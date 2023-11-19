//
//  NotificationView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 19/11/23.
//

import SwiftUI

enum NotificationAction: String {
    case dimiss
    case reminder
}

enum NotificationCategory: String {
    case general
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        completionHandler()
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
}

struct NotificationView: View {
    var body: some View {
        VStack {
            Text("Ini view sbnrnya udh ga kepake, krn udah auto notifnya. Tanya nur aja kalo ada yg gapaham ttg ini, krn msh mau ditindak lanjuti berdasarkan kesepakatan grup")
            Button("Schedule Notification") {
                
                let center = UNUserNotificationCenter.current()
                
                // create content
                let content = UNMutableNotificationContent()
                content.title = "Motomo butuh kamu!"
                content.body =  "Sudah waktunya perbarui jarak tempuh kamu nih. Yuk ke Dashboard sekarang."
                content.categoryIdentifier = NotificationCategory.general.rawValue
                content.userInfo = ["customData": "Some Data"]
                
                // create trigger
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
                
                // create trigger tiap 2 minggu sekali
//                var dateComponents = DateComponents()
//                dateComponents.hour = 10
//                dateComponents.minute = 30
//                dateComponents.day = 14 // 2 weeks in days
//                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                // create request
                let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
                
                // define actions
                let dismiss = UNNotificationAction(identifier: NotificationAction.dimiss.rawValue, title: "Dismiss", options: [])
                
                let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
                
                let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
                
                center.setNotificationCategories([generalCategory])
                
                // add request to notification center
                center.add(request) { error in
                    if let error = error {
                        print(error)
                    }
                }
                
            }
        }
    }
}

#Preview {
    NotificationView()
}
