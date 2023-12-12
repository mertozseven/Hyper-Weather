//
//  SettingsViewController.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 13.12.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
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
    
    private let primaryView: SettingsView = {
        let view = SettingsView()
        let viewModel = SettingsViewViewModel(
            options: SettingOption.allCases
        )
        view.configure(
            with: viewModel
        )
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        title = "Settings"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        primaryView.delegate = self
        setupView()
        
    }
    
    private func setupView() {
        
        view.backgroundColor = .clear
        view.addSubview(
            primaryView
        )
        view.insertSubview(
            backgroundImageView,
            at: 0
        )
        let backgroundConstraints = [
            backgroundImageView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
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

extension SettingsViewController: SettingsViewDelegate {
    func settingsView(
        _ settingsView: SettingsView,
        didTap option: SettingOption
    ) {
        switch option {
        case .upgrade:
            break
        case .privacyPolicy:
            break
        case .terms:
            break
        case .contact:
            break
        case .getHelp:
            break
        case .rateApp:
            break
        case .setupTheme:
            break
        }
    }
}
