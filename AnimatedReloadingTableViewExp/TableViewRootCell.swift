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
    var scale: CGFloat = 1.0
    let triangle = UIImageView()
    let label = UILabel()
    
    var extended: Bool {
        didSet {
            let angle: CGFloat = self.extended ? CGFloat(M_PI * 45 / 180) : 0
            let t = triangle.transform
            let scaleX = sqrt(t.a * t.a + t.c * t.c)
            let scaleY = sqrt(t.b * t.b + t.d * t.d) //CGAffineTransformAdditions
            let t_ = CGAffineTransformMakeScale(scaleX, scaleY)
            triangle.transform = CGAffineTransformRotate(t_, angle)
        }
    }
    
    override var frame: CGRect {
        didSet {
            scale = self.frame.size.height / initialHeight
            label.transform = CGAffineTransformMakeScale(scale, scale)
            let angle = atan2(triangle.transform.b, triangle.transform.a)
            let t = CGAffineTransformMakeRotation(angle)
            triangle.transform = CGAffineTransformScale(t, scale, scale)
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
    
    func setupViews() {
        triangle.translatesAutoresizingMaskIntoConstraints = false
        triangle.image = UIImage(named: "cross")
        self.contentView.addSubview(triangle)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(30.0)
        self.contentView.addSubview(label)
    }
    
    func setupConstraints() {
        let triangleLeading = NSLayoutConstraint(item: triangle, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0)
        let triangleCenterY = NSLayoutConstraint(item: triangle, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        let labelCenterX = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let labelCenterY = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activateConstraints([triangleLeading, triangleCenterY, labelCenterX, labelCenterY])
    }
}
