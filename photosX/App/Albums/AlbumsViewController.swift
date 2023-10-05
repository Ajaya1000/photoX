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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
        
        viewModel.profiles.enumerated().map { index, item in
            let view = getProfileView(with: item.name, image: item.image)
            view.tag = index
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectProfile(_:)))
            view.addGestureRecognizer(tapGesture)
            profileViews.append(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }.slices(of: 2).forEach { list in
            let subContainer = UIStackView()
            subContainer.axis = .horizontal
            subContainer.spacing = Constraints.horizontalSpacing
            subContainer.translatesAutoresizingMaskIntoConstraints = false
            
            list.forEach {
                subContainer.addArrangedSubview($0)
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
    
}

private extension AlbumsViewController {
    @objc func didSelectProfile(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        
        startLoaderAnimation(for: view)
    }
}

private extension AlbumsViewController {
    func startLoaderAnimation(for view: UIView) {
        view.removeFromSuperview()
        
        let outerLoaderContainer = UIStackView()
        outerLoaderContainer.axis = .horizontal
        outerLoaderContainer.alignment = .center
        
        
        let loaderContainer = UIStackView()
        loaderContainer.axis = .vertical
        loaderContainer.alignment = .center
        
        
        let loaderView = getLoaderView()
        
        loaderContainer.addArrangedSubview(view)
        loaderContainer.addArrangedSubview(loaderView)
        
        view.addSubview(outerLoaderContainer)
        
        outerLoaderContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        outerLoaderContainer.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        outerLoaderContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        outerLoaderContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        UIView.animate(withDuration: 1.0, delay: 0.0) {

        }
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
    
    func getLoaderView() -> UIView {
        
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
