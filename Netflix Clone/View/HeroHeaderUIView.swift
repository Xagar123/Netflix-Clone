//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import UIKit

class HeroHeaderUIView: UIView {

    //MARK: -Properties
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true //avoid overflow
        iv.image = UIImage(named: "heroImage")
        return iv
    }()
    
    
    //MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImageView)
        addGraident()
        
        addSubview(playButton)
        addSubview(downloadButton)
        addContrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    //MARK: -Helper
    
    
    
    private func addContrain() {
        let playButtonConstrain = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let downloadButton = [
            downloadButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 25),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
//            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            downloadButton.widthAnchor.constraint(equalToConstant: 100),
            
            downloadButton.heightAnchor.constraint(equalToConstant: 50)]
        NSLayoutConstraint.activate(playButtonConstrain)
        NSLayoutConstraint.activate(downloadButton)
    }
    
    private func addGraident() {
        let graidentLayer = CAGradientLayer()
        graidentLayer.colors = [ UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        graidentLayer.frame = bounds
        layer.addSublayer(graidentLayer)
    }
    
    public func configure(with model: TitleViewModel) {
        print("before guard===================")
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            print("error=============================")
            return}
        
        print("image before set")
        heroImageView.sd_setImage(with: url)
        print("image after set")
    }
}
