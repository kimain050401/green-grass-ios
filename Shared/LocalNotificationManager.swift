//
//  LocalNotificationManager.swift
//  greengrass
//
//  Created by 김아인 on 2022/01/16.
//

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
    var body: String
}

class LocalNotificationManager {
    var notifications = [Notification]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                // Good
            }
        }
    }
    
    func addNotification(title: String, body: String) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title, body: body))
    }
    
    func schedule(isTest: Bool) -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
              switch settings.authorizationStatus {
              case .notDetermined:
                  self.requestPermission()
              case .authorized, .provisional:
                  print(isTest)
                  if(isTest == true){
                      self.scheduleNotifications(isTest: true)
                  } else{
                      self.scheduleNotifications(isTest: false)
                  }
              default:
                  break
                
            }
        }
        
    }
    
    func scheduleNotifications(isTest: Bool) -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            print(isTest)
            if(isTest == true){
                print("true!!!")
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return }
                    print("Scheduling notification with id: \(notification.id)")
                    UserDefaults.standard.set("notification.id", forKey: "pushAlertID")
                }
            } else{
                print("false!!!")
                var dateComponents = DateComponents()
                dateComponents.hour = Int(UserDefaults.standard.string(forKey: "selectPushAlertTimeHour") ?? "23")
                dateComponents.minute = Int(UserDefaults.standard.string(forKey: "selectPushAlertTimeMinute") ?? "00")
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return }
                    print("Scheduling notification with id: \(notification.id)")
                    UserDefaults.standard.set("notification.id", forKey: "pushAlertID")
                }
            }
        }
    }
    
    func removeNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
