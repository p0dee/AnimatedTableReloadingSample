//
//  TableViewRootCell.swift
//  AnimatedReloadingTableViewExp
//
//  Created by Takeshi Tanaka on 10/31/15.
//  Copyright © 2015 p0dee. All rights reserved.
//

import UIKit

class TableViewRootCell: UITableViewCell {
    
    var initialHeight: CGFloat = 60.0
    private var scale: CGFloat = 1.0
    private let cross = UIImageView()
    let label = UILabel()
    
    var extended: Bool {
        didSet {
            let angle: CGFloat = self.extended ? CGFloat(M_PI * 45 / 180) : 0
            let t = CGAffineTransformExtractScale(cross.transform)
            cross.transform = CGAffineTransformRotate(t, angle)
        }
    }
    
    override var frame: CGRect {
        didSet {
            scale = self.frame.size.height / initialHeight
            label.transform = CGAffineTransformMakeScale(scale, scale)
            let t = CGAffineTransformExtractRotation(cross.transform)
            cross.transform = CGAffineTransformScale(t, scale, scale)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        extended = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        extended = false
        super.init(coder: aDecoder)
        self.setupViews()
        self.setupConstraints()
    }
    
    private func setupViews() {
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.image = UIImage(named: "cross")
        self.contentView.addSubview(cross)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(30.0)
        self.contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        let triangleLeading = NSLayoutConstraint(item: cross, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0)
        let triangleCenterY = NSLayoutConstraint(item: cross, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        let labelCenterX = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let labelCenterY = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activateConstraints([triangleLeading, triangleCenterY, labelCenterX, labelCenterY])
    }
}
