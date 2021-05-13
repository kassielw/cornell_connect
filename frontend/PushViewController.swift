//
//  PushViewController.swift
//  HackChallenge_
//
//  Created by Janice Lee on 5/5/21.
//
import Foundation
import UIKit
import Malert

protocol AddPostDelegate: class {
    func addNewPost(netId: String, name: String, post: String)
}

class PushViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AddPostDelegate {
    func addNewPost(netId: String, name: String, post: String) {
        let newPost = Post(id: self.id, name: name, picture: "N/A", description: post)
        postsArray.append(newPost)
        self.postsCollectionView.reloadData()
        NetworkManager.createPost(id: self.id, netid: netId, name: name, picture: "N/A", description: post, completion: {_ in
            
        })
        
    
    }
    var image = UIImageView()
    var name = UILabel()
    var address = UILabel()
    var backButton = UIImageView()
    var id: Int
    var postsTitle = UILabel()
    var postsCollectionView: UICollectionView!
    let postCellReuseIdentifier = "postCellReuseIdentifier"
    var postsArray: [Post] = []
    var addButton = UIImageView()
    weak var createPostView: UIView!
    weak var nameTextField: UITextField!
    weak var postTextField: UITextField!
    weak var postButton: UIButton!
    
    init(id: Int, name: String, address: String, image: String) {
        
        self.id = id
        self.name.text = name
        self.address.text = address
        super.init(nibName: nil, bundle: nil)
        let url = URL(string: image)!
        downloadImage(from: url)
    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not yet been implemented")
    }
    
    weak var delegate: LocationDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.getSpecificAttraction(id: self.id){ attraction in
            self.id = attraction.id
            self.name.text = attraction.name
            self.address.text = attraction.address
        }
        
        NetworkManager.getAllPosts(id: self.id) { posts in
            self.postsArray = posts
            self.postsCollectionView.reloadData()
        }
        
        view.backgroundColor = .white
        name.textColor = UIColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        name.font = UIFont.systemFont(ofSize: 20, weight: .black)
        name.layer.masksToBounds = true
        name.contentMode = .scaleAspectFit
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        
        address.textColor = UIColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        address.font = UIFont.systemFont(ofSize: 18)
        address.layer.masksToBounds = true
        address.contentMode = .scaleAspectFit
        address.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(address)
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        postsTitle.text = "Posts"
        postsTitle.textColor = UIColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        postsTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        postsTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postsTitle)
        
        let postsLayout = UICollectionViewFlowLayout()
        postsLayout.scrollDirection = .vertical
        postsLayout.minimumInteritemSpacing = 5
        postsLayout.minimumLineSpacing = 5
        postsLayout.itemSize = CGSize(width: 350, height: 125)
        
        postsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postsLayout)
        postsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        postsCollectionView.backgroundColor = .white
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        postsCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: postCellReuseIdentifier)
        view.addSubview(postsCollectionView)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -550),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            name.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            address.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            address.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            address.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            postsTitle.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 10),
            postsTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            postsCollectionView.topAnchor.constraint(equalTo: postsTitle.bottomAnchor, constant: 8),
            postsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
        backButton.image = UIImage.init(named: "backbutton")
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonSelected))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(gestureRecognizer)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35)
        ])
        
        addButton.image = UIImage.init(named: "addbutton")
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let addGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPost))
        addButton.isUserInteractionEnabled = true
        addButton.addGestureRecognizer(addGestureRecognizer)
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 260),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 656)
        ])
    }
    
    @objc func buttonSelected(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addPost(){
        let addPostViewController = AddPostViewController(id: self.id, postsArray: self.postsArray)
        addPostViewController.delegate = self
        self.present(addPostViewController, animated: true, completion: nil)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image.image = UIImage(data: data)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellReuseIdentifier, for: indexPath) as! PostCollectionViewCell

            let post = postsArray[indexPath.item]

            cell.configure(with: post)
            cell.setNeedsUpdateConstraints()
            // so our subviews and cells actually get a layout
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return postsArray.count
    }
}
