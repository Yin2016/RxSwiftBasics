//
//  AppDelegate.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/10.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = ViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.barTintColor = .orange
        
        self.window?.rootViewController = nc
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("将要进入前台")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("已经活跃")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("将要进入后台")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("已经进入后台")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("将要退出程序")
    }
}

