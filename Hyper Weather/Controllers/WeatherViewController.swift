//
//  ViewController.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 12.12.2023.
//

import WeatherKit
import UIKit
import RevenueCatUI
import RevenueCat

class WeatherViewController: UIViewController {
    
    private let primaryView = CurrentWeatherView()
    
    private let paywallButtonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(
            systemName: "crown"
        )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(
            frame: view.bounds
        )
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(
            named: "wallpaper"
        )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        title = "Weather"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        setupView()
        getLocation()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: paywallButtonImage.image,
            style: .done,
            target: self,
            action: #selector(
                didTapUpgrade
            )
        )
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc
    private func didTapUpgrade() {
        let vc = PaywallViewController()
        vc.delegate = self
        present(
            vc,
            animated: true
        )
    }
    private func getLocation() {
        LocationManager.shared.getCurrentLocation { location in
            WeatherManager.shared.getWeather(
                for: location
            ) { [weak self] in
                DispatchQueue.main.async {
                    guard let currentWeather = WeatherManager.shared.currentWeather else {
                        return
                    }
                    self?.createViewModels(
                        currentWeather: currentWeather
                    )
                }
            }
        }
    }
    private func createViewModels(
        currentWeather: CurrentWeather
    ) {
        var viewModels: [WeatherViewModel] = [
            .current(
                viewModel: .init(
                    model: currentWeather
                )
            ),
            .hourly(
                viewModel: WeatherManager.shared.hourlyWeather.compactMap({
                    .init(
                        model: $0
                    )
                })
            ),
        ]
        primaryView.configure(
            with: viewModels
        )
        
        IAPManager.shared.isSubscribed { [weak self] subscribed in
            if subscribed {
                viewModels.append(
                    .daily(
                        viewModel: WeatherManager.shared.dailytWeather.compactMap({
                            .init(
                                model: $0
                            )
                        })
                    )
                )
                DispatchQueue.main.async {
                    self?.primaryView.configure(
                        with: viewModels
                    )
                    self?.navigationItem.rightBarButtonItem = nil
                }
            } else {
                DispatchQueue.main.async {
                    self?.navigationItem.rightBarButtonItem = UIBarButtonItem(
                        image: UIImage(
                            systemName: "crown"
                        ),
                        style: .done,
                        target: self,
                        action: #selector(
                            self?.didTapUpgrade
                        )
                    )
                }
            }
        }
    }
    private func setupView() {
        view.insertSubview(
            backgroundImageView,
            at: 0
        )
        view.addSubview(
            primaryView
        )
        let backgroundConstraints = [
            backgroundImageView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ]
        NSLayoutConstraint.activate(
            backgroundConstraints
        )
        let primaryViewConstraints = [
            primaryView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            primaryView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor
            ),
            primaryView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor
            ),
            primaryView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ]
        NSLayoutConstraint.activate(
            primaryViewConstraints
        )
    }
    
}

extension WeatherViewController: PaywallViewControllerDelegate {
    func paywallViewController(
        _ controller: PaywallViewController,
        didFinishPurchasingWith customerInfo: CustomerInfo
    ) {
        print(
            "Purchased: \(customerInfo)"
        )
        controller.dismiss(
            animated: true
        )
        guard let currentWeather = WeatherManager.shared.currentWeather else {
            return
        }
        createViewModels(
            currentWeather: currentWeather
        )
    }
    func paywallViewController(
        _ controller: PaywallViewController,
        didFinishRestoringWith customerInfo: CustomerInfo
    ) {
        print(
            "Restored: \(customerInfo)"
        )
        controller.dismiss(
            animated: true
        )
    }
}
