//
//  QuestionImageViewController.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 05/07/2025.
//

import UIKit

class QuestionImageViewController: UIViewController {
    enum Constants {
        static let spacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 16
    }

    let item: Item
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(imageTitle)
        view.addSubview(imageView)
        
        imageTitle.text = item.title
        
        if let size = item.type?.fontSize() {
            imageTitle.font = UIFont.systemFont(ofSize: size)
        }
        
        NSLayoutConstraint.activate([
            imageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalSpacing),
            imageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            imageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            
            imageView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: Constants.verticalSpacing),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let imageString = item.src, let url = URL(string: imageString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = img
                    }
                }
            }.resume()
        }
    }
}
