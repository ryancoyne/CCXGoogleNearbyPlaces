//
//  AppDelegate.swift
//  CCXGoogleNearbyPlaces
//
//  Created by ryancoyne_ on 11/11/2017.
//  Copyright (c) 2017 ryancoyne_. All rights reserved.
//

import UIKit
import CCXGoogleNearbyPlaces
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CCXGoogleSDK.places.apiKey = "AIzaSyBXjLkF6Zqi7ocGKppo2d50AuAqLsZO408"
        let coord = CLLocationCoordinate2D(latitude: 28.928544, longitude: -80.03130332)
        
        CCXGoogleSDK.places.get(withRadius: 300.0, coordinate: coord) { response in
            if response.status.isSuccess {
                if response.places.isNotNil {
                    if response.canLoadMore {
                        // You should only use the pageToken in the get function on your next request.
                    }
                    // Deal with the places:
                    print(response.places!)
                }
            } else if response.error.isNotNil {
                //
                print(response.error!)
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

