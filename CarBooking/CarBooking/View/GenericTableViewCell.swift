//
//  VehicleTableViewCell.swift
//  CarBooking
//
//  Created by De MicheliStefano on 23.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

class GenericTableViewCell: UITableViewCell {
    
    struct CellContent {
        var title: String
        var detail: String
    }
    
    var content: CellContent? {
        didSet {
            setupViews()
        }
    }
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor = UIColor.secondary
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.textFontSize)
        label.textColor = UIColor.secondary
        return label
    }()
    
    private func setupViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(detailLabel)
        
        let padding = Constants.defaultPadding
        mainStackView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        
        backgroundColor = UIColor.primary
        titleLabel.text = content?.title
        detailLabel.text = content?.detail
    }

}
