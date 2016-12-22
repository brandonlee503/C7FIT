//
//  AppDelegate.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/21/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize tabBar controller and navigation controllers
        let tabBarController = UITabBarController()
        let tabViewController1 = UIViewController()
        let tabViewController2 = UIViewController()
        let tabViewController3 = UIViewController()
        let tabViewController4 = UIViewController()
        let tabViewController5 = UIViewController()
        
        let navigationController1 = UINavigationController(rootViewController: tabViewController1)
        let navigationController2 = UINavigationController(rootViewController: tabViewController2)
        let navigationController3 = UINavigationController(rootViewController: tabViewController3)
        let navigationController4 = UINavigationController(rootViewController: tabViewController4)
        let navigationController5 = UINavigationController(rootViewController: tabViewController5)
        
        let controllers = [navigationController1, navigationController2, navigationController3, navigationController4, navigationController5]
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
        
        navigationController1.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        navigationController2.tabBarItem = UITabBarItem(title: "Personal Trainer", image: nil, selectedImage: nil)
        navigationController3.tabBarItem = UITabBarItem(title: "Classes", image: nil, selectedImage: nil)
        navigationController4.tabBarItem = UITabBarItem(title: "Activity", image: nil, selectedImage: nil)
        navigationController5.tabBarItem = UITabBarItem(title: "More", image: nil, selectedImage: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

