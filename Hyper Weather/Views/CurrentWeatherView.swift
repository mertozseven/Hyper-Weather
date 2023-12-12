//
//  CurrentWeatherView.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 13.12.2023.
//

import UIKit

final class CurrentWeatherView: UIView {
    
    private var viewModel: [WeatherViewModel] = []
    
    private var collectionView: UICollectionView?
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        translatesAutoresizingMaskIntoConstraints = false
        
        createCollectionView()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    public func configure(
        with viewModel: [WeatherViewModel]
    ) {
        self.viewModel = viewModel
        collectionView?.reloadData()
    }
    
    private func layout(
        for sectionIndex: Int
    ) -> NSCollectionLayoutSection {
        let section = CurrentWeatherSection.allCases[sectionIndex]
        
        switch section {
        case .current:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(
                        1.0
                    ),
                    heightDimension: .fractionalHeight(
                        1.0
                    )
                )
            )
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(
                        1.0
                    ),
                    heightDimension: .fractionalWidth(
                        0.75
                    )
                ),
                subitems: [item]
            )
            
            return NSCollectionLayoutSection(
                group: group
            )
        case .hourly:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(
                        1.0
                    ),
                    heightDimension: .fractionalHeight(
                        1.0
                    )
                )
            )
            
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(
                        0.25
                    ),
                    heightDimension: .absolute(
                        150
                    )
                ),
                subitems: [item]
            )
            group.contentInsets = .init(
                top: 5,
                leading: 2,
                bottom: 5,
                trailing: 2
            )
            
            let section =  NSCollectionLayoutSection(
                group: group
            )
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        case .daily:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(
                        1.0
                    ),
                    heightDimension: .fractionalHeight(
                        1.0
                    )
                )
            )
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(
                        1.0
                    ),
                    heightDimension: .absolute(
                        100
                    )
                ),
                subitems: [item]
            )
            group.contentInsets = .init(
                top: 0,
                leading: 2,
                bottom: 5,
                trailing: 2
            )
            
            return NSCollectionLayoutSection(
                group: group
            )
        }
        
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex,
            _ in
            return self.layout(
                for: sectionIndex
            )
        }
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 12
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(
            CurrentWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            HourlyWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            DailyWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier
        )
        addSubview(
            collectionView
        )
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.topAnchor,
                    constant: 5
                ),
                collectionView.leftAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.leftAnchor,
                    constant: 5
                ),
                collectionView.rightAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.rightAnchor,
                    constant: -5
                ),
                collectionView.bottomAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor,
                    constant: -5
                ),
            ]
        )
        
        self.collectionView =  collectionView
    }
}

extension CurrentWeatherView: UICollectionViewDataSource {
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return viewModel.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch viewModel[section] {
        case .current:
            return 1
        case .hourly(
            let viewModels
        ):
            return viewModels.count
        case .daily(
            let viewModels
        ):
            return viewModels.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch viewModel[indexPath.section] {
        case .current(
            let viewModel
        ):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? CurrentWeatherCollectionViewCell else {
                fatalError()
            }
            cell.layer.cornerRadius = 12
            cell.configure(
                with: viewModel
            )
            return cell
            
        case .daily(
            let viewModels
        ):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? DailyWeatherCollectionViewCell else {
                fatalError()
            }
            cell.layer.cornerRadius = 12
            cell.configure(
                with: viewModels[indexPath.row]
            )
            return cell
            
        case .hourly(
            let viewModels
        ):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? HourlyWeatherCollectionViewCell else {
                fatalError()
            }
            cell.layer.cornerRadius = 12
            cell.configure(
                with: viewModels[indexPath.row]
            )
            return cell
        }
    }
}
