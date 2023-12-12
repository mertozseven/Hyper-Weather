//
//  CurrentWeatherCollectionViewCell.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = .label
        label.font = .systemFont(
            ofSize: 42,
            weight: .medium
        )
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = .label
        label.font = .systemFont(
            ofSize: 24,
            weight: .regular
        )
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        setupView()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    public func configure(
        with viewModel: CurrentWeatherCollectionViewCellViewModel
    ) {
        icon.image = UIImage(
            systemName: viewModel.iconName
        )
        conditionLabel.text = viewModel.condition
        tempLabel.text = viewModel.temperature
    }
    
    private func setupView() {
        let blurEffect = UIBlurEffect(
            style: .systemUltraThinMaterial
        )
        let blurView = UIVisualEffectView(
            effect: blurEffect
        )
        blurView.frame = bounds
        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
        addSubview(
            blurView
        )
        contentView.addSubview(
            tempLabel
        )
        contentView.addSubview(
            icon
        )
        contentView.addSubview(
            conditionLabel
        )
        
        let tempLabelConstraints = [
            tempLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            tempLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor
            ),
            tempLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor
            ),
            tempLabel.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.33
            )
        ]
        let iconConstraints = [
            icon.topAnchor.constraint(
                equalTo: tempLabel.bottomAnchor
            ),
            icon.leftAnchor.constraint(
                equalTo: contentView.leftAnchor
            ),
            icon.rightAnchor.constraint(
                equalTo: contentView.rightAnchor
            ),
            icon.bottomAnchor.constraint(
                equalTo: conditionLabel.topAnchor
            )
        ]
        let conditionLabelConstraints = [
            conditionLabel.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.33
            ),
            conditionLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor
            ),
            conditionLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor
            ),
            conditionLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ]
        NSLayoutConstraint.activate(
            tempLabelConstraints
        )
        NSLayoutConstraint.activate(
            conditionLabelConstraints
        )
        NSLayoutConstraint.activate(
            iconConstraints
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        conditionLabel.text = nil
        tempLabel.text = nil
        icon.image = nil
    }
}
