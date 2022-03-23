//
//  TravelTableViewCell.swift
//  Travel Register
//
//  Created by sunder-con870 on 07/02/22.
//

import UIKit

class TRDetailedTableViewCell: UITableViewCell {
    private let placeNameLabel : UILabel = {
        let placeNameLabel = UILabel()
        return placeNameLabel
    }()
    let rightArrowImage : UIImageView = {
        let rightArrowImage = UIImageView()
        rightArrowImage.image = UIImage(systemName: "chevron.right")
        return rightArrowImage
    }()
    private let daysLabel : UILabel = {
        let daysLabel = UILabel()
        
        return daysLabel
    }()
    private let tripDateLabel : UILabel = {
        let tripDateLabel = UILabel()
        tripDateLabel.textAlignment = .right
        return tripDateLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(placeNameLabel)
        contentView.addSubview(rightArrowImage)
        contentView.addSubview(daysLabel)
        contentView.addSubview(tripDateLabel)
    }
    public func configureCellLabels(placeTxt : String, days : String, date : String) {
        placeNameLabel.text = placeTxt
        daysLabel.text = days
        tripDateLabel.text = date
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        placeNameLabel.frame = CGRect(x: 70, y: 0, width: (contentView.frame.width-70) - 35, height: contentView.frame.height/2)
        rightArrowImage.frame = CGRect(x: (Int(contentView.frame.width)-35), y: Int(9.25), width: 15, height: Int(contentView.frame.height)/4)
        daysLabel.frame = CGRect(x: 70, y: contentView.frame.height/2, width: contentView.frame.width/2 - 70, height: contentView.frame.height/2)
        tripDateLabel.frame = CGRect(x: (contentView.frame.width/2), y: contentView.frame.height/2, width: contentView.frame.width/2 - 10, height: contentView.frame.height/2)
    }
}

class BaseCell<U> : TRDetailedTableViewCell {
    var item : U!
}
