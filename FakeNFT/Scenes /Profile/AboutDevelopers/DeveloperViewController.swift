//
//  DeveloperViewController.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 31.01.2024.
//

import UIKit

class DeveloperViewController: UIViewController {
    
    private let developerImageFirst: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "catImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let developerLabelFirst: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каталог: Альмира Хафизова"
        label.font = .sfProBold22
        label.textAlignment = .center
        return label
    }()
    
    private let developerImageSecond: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dogImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let developerLabelSecond: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Профиль: Иван Жоглов"
        label.font = .sfProBold22
        label.textAlignment = .center
        return label
    }()
    
    private var animationTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setup()
        setupNavBar()
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "backward"),
            style: .plain,
            target: self,
            action: #selector(didTapExitButton)
        )
        navigationItem.title = AppStrings.ProfileButtons.aboutDeveloperLabel
        navigationController?.navigationBar.tintColor = .ypBlack
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sfProBold17 ?? UIFont.systemFont(ofSize: 17)
             ]
        navigationController?.navigationBar.titleTextAttributes = [
             NSAttributedString.Key.foregroundColor: UIColor.ypBlack
         ]
    }
    
    private func setup() {
        [developerImageFirst, developerLabelFirst, developerImageSecond, developerLabelSecond].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            developerImageFirst.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            developerImageFirst.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            developerImageFirst.widthAnchor.constraint(equalToConstant: 100),
            developerImageFirst.heightAnchor.constraint(equalToConstant: 100),
            developerLabelFirst.topAnchor.constraint(equalTo: developerImageFirst.bottomAnchor, constant: 20),
            developerLabelFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerLabelFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            developerImageSecond.topAnchor.constraint(equalTo: developerLabelFirst.bottomAnchor, constant: 50),
            developerImageSecond.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            developerImageSecond.widthAnchor.constraint(equalToConstant: 100),
            developerImageSecond.heightAnchor.constraint(equalToConstant: 100),
            developerLabelSecond.topAnchor.constraint(equalTo: developerImageSecond.bottomAnchor, constant: 20),
            developerLabelSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            developerLabelSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func startAnimation() {
        animationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateLabelTextAndPulsatingAnimation), userInfo: nil, repeats: true)
    }
    
    private func stopAnimation() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
    @objc private func animateLabelTextAndPulsatingAnimation() {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.developerLabelFirst.alpha = 0.0
            self?.developerLabelSecond.alpha = 0.0
        } completion: { [weak self] (_) in
            UIView.animate(withDuration: 1) {
                self?.developerLabelFirst.alpha = 1.0
                self?.developerLabelSecond.alpha = 1.0
            }
        }
    }
    
    @objc private func didTapExitButton() {
        navigationController?.popViewController(animated: true)
    }
}
