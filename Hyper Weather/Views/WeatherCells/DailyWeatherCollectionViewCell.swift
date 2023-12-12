//
//  DailyWeatherCollectionViewCell.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "DailyWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.tintColor = .label
        label.numberOfLines = 0
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
            ofSize: 22,
            weight: .bold
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
    public func configure(
        with viewModel: DailyWeatherCollectionViewCellViewModel
    ) {
        icon.image = UIImage(
            systemName: viewModel.iconName
        )
        tempLabel.text = "↓\(viewModel.lowTemperature) \n↑\(viewModel.highTemperature)"
        timeLabel.text = viewModel.weekday
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
            tempLabel.heightAnchor.constraint(
                equalTo: contentView.heightAnchor
            ),
            tempLabel.leftAnchor.constraint(
                equalTo: icon.rightAnchor
            ),
            tempLabel.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.33
            )
        ]
        let iconConstraints = [
            icon.heightAnchor.constraint(
                equalTo: contentView.heightAnchor
            ),
            icon.leftAnchor.constraint(
                equalTo: timeLabel.rightAnchor
            ),
            icon.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.33
            )
        ]
        let timeLabelConstraints = [
            timeLabel.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.33
            ),
            timeLabel.heightAnchor.constraint(
                equalTo: contentView.heightAnchor
            ),
            timeLabel.leftAnchor.constraint(
                equalTo: contentView.leftAnchor
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
