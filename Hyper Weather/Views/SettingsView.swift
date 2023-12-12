//
//  SettingsView.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 13.12.2023.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func settingsView(
        _ settingsView: SettingsView,
        didTap option: SettingOption
    )
}

final class SettingsView: UIView {
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(
            style: .systemUltraThinMaterial
        )
        let blurEffectView = UIVisualEffectView(
            effect: blurEffect
        )
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    weak var delegate: SettingsViewDelegate?
    
    private var viewModel: SettingsViewViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.insetsContentViewsToSafeArea = true
        tableView.layer.cornerRadius = 12
        return tableView
    }()
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(
            blurEffectView
        )
        sendSubviewToBack(
            blurEffectView
        )
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
        
    }
    
    private func setupView() {
        
        tableView.layer.cornerRadius = 12
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate(
            [
                blurEffectView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor,
                    constant: 5
                ),
                blurEffectView.rightAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.rightAnchor,
                    constant: -5
                ),
                blurEffectView.leftAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.leftAnchor,
                    constant: 5
                ),
                
                blurEffectView.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor,
                    constant: -5
                )
            ]
        )
        
        tableView.backgroundColor = .clear
        addSubview(
            tableView
        )
        let tableViewConstraints = [
            tableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 5
            ),
            tableView.rightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.rightAnchor,
                constant: -5
            ),
            tableView.leftAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leftAnchor,
                constant: 5
            ),
            tableView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -5
            )
        ]
        NSLayoutConstraint.activate(
            tableViewConstraints
        )
    }
    
    public func configure(
        with viewModel: SettingsViewViewModel
    ) {
        self.viewModel = viewModel
    }
    
    
}



// MARK: TABLE VIEW DELEGATE METHODS

extension SettingsView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
        guard let viewModel else {
            return
        }
        let option = viewModel.options[indexPath.row]
        
        // Handle Tap
        delegate?.settingsView(
            self,
            didTap: option
        )
    }
}

// MARK: TABLE VIEW DATA SOURCE METHODS

extension SettingsView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel?.options.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        
        if let viewModel {
            cell.textLabel?.text = viewModel.options[indexPath.row].title
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
