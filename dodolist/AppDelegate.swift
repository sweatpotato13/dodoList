//
//  AppDelegate.swift
//  dodolist
//
//  Created by JCR on 2020/04/05.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    /* 앱 설정 변수 */
    var window: UIWindow?
    
    var fontSize: String? = "Medium"
    var darkMode: Bool? = false
    var alarm: Bool? = false
    var lock: Bool? = false
    /* ================== */

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { (authorized, error) in
            if !authorized {
               print("App is useless becase you did not allow notification")
            }
        })

        let HollowAction = UNNotificationAction(identifier: "addHellow", title: "Hellow", options: [])
        let ByeAction = UNNotificationAction(identifier: "addBye", title: "Bye", options: [])
        let category = UNNotificationCategory(identifier: "eduCategory", actions: [HollowAction, ByeAction], intentIdentifiers: [], options: [])

        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self

        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "addHellow" {
            print("Say Hellow!")
        }else{
            print("Say Bye~")
        }
    }
    
    func showEduNotification(title: String, date: Date){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Just a remind Me"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "eduCategory"
        
        //Timmer
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        
        //Date
                let date = Date(timeIntervalSinceNow: 20)
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,repeats: false)
        
        //Weekly
        //        let triggerWeekly = Calendar.current.dateComponents([.weekday,hour,.minute,.second,], from: date)
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        //Daily
        //let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        
        
        let request = UNNotificationRequest(identifier: "eduNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request){ (error) in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

