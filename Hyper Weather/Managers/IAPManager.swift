//
//  IAPManager.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 13.12.2023.
//


import RevenueCat
import Foundation

final class IAPManager {
    static let shared = IAPManager()
    
    private init() {
    }
    
    func isSubscribed(
        completion: @escaping (
            Bool
        ) -> Void
    ) {
        Purchases.shared.getCustomerInfo {
            info,
            error in
            guard let subscriptions = info?.activeSubscriptions else {
                return
            }
            completion(
                !subscriptions.isEmpty
            )
        }
    }
}
