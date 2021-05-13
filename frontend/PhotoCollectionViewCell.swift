//
//  PhotoCollectionViewCell.swift
//  HackChallenge_
//
//  Created by Janice Lee on 5/4/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photoImageView: UIImageView!
    var locationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.shadowColor = CGColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 0.5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = .zero
        
        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 15
        contentView.addSubview(photoImageView)
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
        
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            ])
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            photoImageView.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -15),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        super.updateConstraints()
    }
    
    func configure(with location: Attraction) {
        locationLabel.text = location.name
        locationLabel.sizeToFit()
        locationLabel.textColor = UIColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        let url = URL(string: location.image)!
        downloadImage(from: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.photoImageView.image = UIImage(data: data)
            }
        }
    }
}
