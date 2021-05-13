//
//  AddPostView.swift
//  HackChallenge_
//
//  Created by Janice Lee on 5/12/21.
//

import Foundation
import UIKit


class AddPostViewController: UIViewController{
    weak var delegate: AddPostDelegate?
    var postsTitle = UILabel()
    var nameLabel = UILabel()
    var netIdLabel = UILabel()
    var postLabel = UILabel()
    var backButton = UIImageView()
    private var netIdTextField = UITextField()
    private var nameTextField = UITextField()
    private var postTextField = UITextField()
    private var updateButton = UIButton()
    
    var namePlaceholder: String!
    var postPlaceholder: String!
    var id: Int!
    var postsArray: [Post] = []

    init(id: Int, postsArray: [Post]) {
        self.id = id
        self.postsArray = postsArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        postsTitle.text = "Add Post"
        postsTitle.font = UIFont.systemFont(ofSize: 25)
        postsTitle.textColor = .black
        postsTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postsTitle)
        
        netIdLabel.text = "NetId"
        netIdLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        netIdLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netIdLabel)
        
        
        nameLabel.text = "Name"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        netIdTextField.placeholder = "Your netID..."
        netIdTextField.textColor = .black
        netIdTextField.font = UIFont.systemFont(ofSize: 15)
        netIdTextField.layer.borderWidth = 1
        netIdTextField.layer.cornerRadius = 6
        netIdTextField.layer.borderColor = CGColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        netIdTextField.autocapitalizationType = .none
        netIdTextField.spellCheckingType = .no
        netIdTextField.autocorrectionType = .no
        netIdTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netIdTextField)
        
        nameTextField.placeholder = "Your name..."
        nameTextField.textColor = .black
        nameTextField.font = UIFont.systemFont(ofSize: 15)
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = CGColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        nameTextField.layer.cornerRadius = 6
        nameTextField.autocapitalizationType = .none
        nameTextField.spellCheckingType = .no
        nameTextField.autocorrectionType = .no
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        postLabel.text = "Post"
        postLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postLabel)
        
        postTextField.placeholder = "Say something..."
        postTextField.textColor = .black
        postTextField.font = UIFont.systemFont(ofSize: 15)
        postTextField.layer.borderWidth = 1
        postTextField.layer.cornerRadius = 6
        postTextField.layer.borderColor = CGColor.init(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        postTextField.autocapitalizationType = .none
        postTextField.spellCheckingType = .no
        postTextField.autocorrectionType = .no
        postTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postTextField)
        
        updateButton.setTitle("Post", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = UIColor(red: 168/255, green: 15/255, blue: 15/255, alpha: 1)
        updateButton.layer.cornerRadius = 4
        updateButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updateButton)
        setUpConstraints()
        
        backButton.image = UIImage.init(named: "blackbackbutton")
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonSelected))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(gestureRecognizer)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: postsTitle.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35)
        ])
}
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            postsTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postsTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            netIdLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            netIdLabel.topAnchor.constraint(equalTo: postsTitle.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: netIdTextField.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            netIdTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            netIdTextField.topAnchor.constraint(equalTo: netIdLabel.bottomAnchor, constant: 20),
            netIdTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            netIdTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            postLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            postLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
        ])
        NSLayoutConstraint.activate([
            postTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postTextField.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 20),
            postTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            postTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
        NSLayoutConstraint.activate([
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: postTextField.bottomAnchor, constant: 40),
            updateButton.widthAnchor.constraint(equalToConstant: 200),
            updateButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func buttonSelected(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissViewController() {
        delegate?.addNewPost(netId: netIdTextField.text ?? "netId", name: nameTextField.text ?? "Anonymous", post: postTextField.text ?? "post")
        self.dismiss(animated: true, completion: nil)
    }
    
}


