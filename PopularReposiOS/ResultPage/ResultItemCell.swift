//
//  ResultItemCell.swift
//  PopularReposiOS
//
//  Created by Filip on 14/06/2021.
//

import UIKit

class ResultItemCell: UITableViewCell {
    
    private let text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
        
        contentView.addSubview(text)
        NSLayoutConstraint.activate(
            [
                text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                contentView.bottomAnchor.constraint(equalTo: text.bottomAnchor, constant: 8),
                contentView.trailingAnchor.constraint(greaterThanOrEqualTo: text.trailingAnchor, constant: 8)
            ]
        )
    }
    
    func update(text: String) {
        self.text.text = text
    }
}
