//
//  TabViewController.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 13.12.2023.
//

import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    
    //MARK: TAB BAR CONFIG
    
    private func configureTabBar() {
        tabBar.backgroundColor = .clear
        //        let blurEffect = UIBlurEffect(
        //            style: .systemUltraThinMaterial
        //        )
        //        let blurView = UIVisualEffectView(
        //            effect: blurEffect
        //        )
        //        blurView.frame = tabBar.bounds
        //        blurView.clipsToBounds = true
        //        
        //        // Add the visual effect view to the background
        //        tabBar.addSubview(
        //            blurView
        //        )
        //        let blurViewConstraints = [
        //            blurView.topAnchor.constraint(equalTo: tabBar.topAnchor),
        //            blurView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
        //            blurView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
        //            blurView.bottomAnchor.constraint(equalTo: SettingsView.bottomAnchor),
        //        ]
        //        NSLayoutConstraint.activate(blurViewConstraints)
        
        
        tabBar.tintColor = .white
        
        let tab1 = WeatherViewController()
        let tab2 = SettingsViewController()
        
        let nav1 = UINavigationController(
            rootViewController: tab1
        )
        let nav2 = UINavigationController(
            rootViewController: tab2
        )
        
        nav1.tabBarItem = UITabBarItem(
            title: "Weather",
            image: UIImage(
                systemName: "cloud.sun.rain.fill"
            ),
            tag: 1
        )
        nav2.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(
                systemName: "gear"
            ),
            tag: 2
        )
        
        self.setViewControllers(
            [
                nav1,
                nav2
            ],
            animated: true
        )
        
    }
    
}
