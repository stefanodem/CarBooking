//
//  ProfileView.swift
//  CarBooking
//
//  Created by De MicheliStefano on 22.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A profile view which consists of a title, an image, and a description.
 */

class ProfileView: UIView {

    // MARK: - Properties
    var image: UIImage
    let title: String
    let aDescription: String
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.defaultSpacing
        return stackView
    }()
    
    // MARK: - Init
    init(frame: CGRect = CGRect.zero, image: UIImage?, title: String, description: String) {
        self.image = image ?? Constants.placeholderImage
        self.title = title
        self.aDescription = description
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func setupViews() {
        // Setup image view
        let imageView = UIImageView()
        mainStackView.addArrangedSubview(imageView)
        
        imageView.image = image
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        imageView.contentMode = .scaleAspectFit
        imageView.dropShadow()
        
        // Setup stack view
        addSubview(mainStackView)
        mainStackView.fillSuperview()
        
        // Setup description label
        let titleLabel = UILabel()
        mainStackView.addArrangedSubview(titleLabel)
        
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Setup description label
        let descriptionTextView = UILabel()
        mainStackView.addArrangedSubview(descriptionTextView)
        
        descriptionTextView.text = aDescription
        descriptionTextView.numberOfLines = 5
        descriptionTextView.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionTextView.textAlignment = .center
        descriptionTextView.adjustsFontForContentSizeCategory = true
        descriptionTextView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
    }
    
}
