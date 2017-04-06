//
//  AppDelegate.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/21/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)

        // Initialize tabBar controller and navigation controllers
        let tabBarController = UITabBarController()
        let tabViewController1 = HomeViewController()
        let tabViewController2 = ScheduleViewController()
        let tabViewController3 = StoreViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let tabViewController4 = ActivityViewController()
        let tabViewController5 = ProfileViewController()

        let navigationController1 = UINavigationController(rootViewController: tabViewController1)
        let navigationController2 = UINavigationController(rootViewController: tabViewController2)
        let navigationController3 = UINavigationController(rootViewController: tabViewController3)
        let navigationController4 = UINavigationController(rootViewController: tabViewController4)
        let navigationController5 = UINavigationController(rootViewController: tabViewController5)

        let controllers = [navigationController1, navigationController2, navigationController3, navigationController4, navigationController5]
        tabBarController.viewControllers = controllers

        navigationController1.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        navigationController2.tabBarItem = UITabBarItem(title: "Schedule", image: nil, selectedImage: nil)
        navigationController3.tabBarItem = UITabBarItem(title: "Store", image: nil, selectedImage: nil)
        navigationController4.tabBarItem = UITabBarItem(title: "Activity", image: nil, selectedImage: nil)
        navigationController5.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
