//
//  HourlyWeatherCollectionViewCell.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "HourlyWeatherCollectionViewCell"
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = .label
        label.font = .systemFont(
            ofSize: 18,
            weight: .regular
        )
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = .label
        label.font = .systemFont(
            ofSize: 15,
            weight: .regular
        )
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.tintColor = .label
        return imageView
    }()
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        backgroundColor = .clear
        setupView()
        
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        tempLabel.text = nil
        timeLabel.text = nil
        icon.image = nil
    }
    
    public func configure(
        with viewModel: HourlyWeatherCollectionViewCellViewModel
    ) {
        icon.image = UIImage(
            systemName: viewModel.iconName
        )
        tempLabel.text = viewModel.temperature
        timeLabel.text = viewModel.hour
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
            timeLabel
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
                equalTo: timeLabel.topAnchor
            )
        ]
        let timeLabelConstraints = [
            timeLabel.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.33
            ),
            timeLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor
            ),
            timeLabel.rightAnchor.constraint(
                equalTo: contentView.rightAnchor
            ),
            timeLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ]
        NSLayoutConstraint.activate(
            tempLabelConstraints
        )
        NSLayoutConstraint.activate(
            timeLabelConstraints
        )
        NSLayoutConstraint.activate(
            iconConstraints
        )
    }
}
