//
//  FilterCollectionViewCell.swift
//  HackChallenge_
//
//  Created by Janice Lee on 5/4/21.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterLabel: UILabel!
    var select = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterLabel = UILabel(frame: .zero)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonSelected))
//        self.addGestureRecognizer(gestureRecognizer)
        contentView.addSubview(filterLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        super.updateConstraints()
    }
    
    func configure(with filter: Filter) {
//        filterLabel = UILabel()
        filterLabel.text = filter.name
        filterLabel.layer.borderWidth = 1
        filterLabel.layer.borderColor = CGColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        filterLabel.textAlignment = .center
        filterLabel.layer.cornerRadius = 15
        filterLabel.layer.masksToBounds = true
        
        if filter.selected{
            filterLabel.backgroundColor = UIColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
            filterLabel.textColor = .white
        }
        else{
            filterLabel.backgroundColor = .white
            filterLabel.textColor = UIColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
            
        }
    

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
