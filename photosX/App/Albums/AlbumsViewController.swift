//
//  AlbumsViewController.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import UIKit

class AlbumsViewController: BaseViewController {
    private let viewModel: AlbumViewModel
    
    private var profileViews: [UIView] = []
    
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        addProfileViews()
    }
}

private extension AlbumsViewController {
    func addProfileViews() {
        let outerContainer = UIStackView()
        outerContainer.translatesAutoresizingMaskIntoConstraints = false
        outerContainer.axis = .horizontal
        outerContainer.alignment = .center
        
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .center
        container.spacing = Constraints.verticalSpacing
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.profiles.slices(of: 2).forEach { list in
            let subContainer = UIStackView()
            subContainer.axis = .horizontal
            subContainer.spacing = Constraints.horizontalSpacing
            subContainer.translatesAutoresizingMaskIntoConstraints = false
            
            list.forEach {
                let view = getProfileView(with: $0.name, image: $0.image)
                profileViews.append(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                
                subContainer.addArrangedSubview(view)
            }
            
            container.addArrangedSubview(subContainer)
        }
        
        outerContainer.addArrangedSubview(container)
        
        view.addSubview(outerContainer)
        
        outerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        outerContainer.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        outerContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        outerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        startAnimation()
    }
    
    func startAnimation() {
        profileViews.enumerated().forEach { index, view in
            UIView.animate(withDuration: 1.5,
                           delay: 0.1 * Double(index),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 5,
                           options: []) {
                view.transform = .identity
                view.layer.opacity = 1.0
            }
        }
    }
}

private extension AlbumsViewController {
    func getProfileView(with title: String, image: String) -> UIView {
        let containerView = UIStackView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.axis = .vertical
        containerView.alignment = .center
        containerView.spacing = Constraints.contentSpacing
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: Constraints.imageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constraints.imageHeight).isActive = true
        
        imageView.image = UIImage(named: image)
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = Constraints.cornerRadius
        imageView.clipsToBounds = true
        
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = title
        nameLabel.textColor = .white
        
        containerView.addArrangedSubview(imageView)
        containerView.addArrangedSubview(nameLabel)
        
        containerView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        containerView.layer.opacity = 0.0
        
        return containerView
    }
}

private struct Constraints {
    static let horizontalSpacing = CGFloat(24.0)
    static let verticalSpacing = CGFloat(24.0)
    
    static let imageWidth = CGFloat(100)
    static let imageHeight = CGFloat(100)
    
    static let contentSpacing = CGFloat(12.0)
    
    static let cornerRadius = CGFloat(8.0)
}
