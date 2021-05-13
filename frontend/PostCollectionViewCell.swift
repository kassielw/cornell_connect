//
//  PostCollectionViewCell.swift
//  HackChallenge_
//
//  Created by Varsha Iyer on 5/12/21.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    var name: UILabel!
    var picture: UIImageView!
    var postDescription: UILabel!
    var postBox: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.shadowColor = CGColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 0.5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = .zero
        
        postBox = UIView()
        postBox.backgroundColor = .black
        postBox.layer.cornerRadius = 5
        postBox.layer.borderWidth = 2
        postBox.layer.borderColor = CGColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        postBox.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postBox)
        
        name = UILabel()
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        
        postDescription = UILabel()
        postDescription.textColor = .white
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postDescription)
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            postBox.topAnchor.constraint(equalTo: contentView.topAnchor),
            postBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            postBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            postBox.heightAnchor.constraint(equalToConstant: 100),
            postBox.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: postBox.topAnchor, constant: 15),
            name.leadingAnchor.constraint(equalTo: postBox.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            postDescription.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 17),
            postDescription.leadingAnchor.constraint(equalTo: postBox.leadingAnchor, constant: 15),
            postDescription.trailingAnchor.constraint(equalTo: postBox.trailingAnchor)
        ])
        super.updateConstraints()
    }
    
    func configure(with post: Post){
        name.text = post.name
        postDescription.text = "\"" + post.description + "\""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
