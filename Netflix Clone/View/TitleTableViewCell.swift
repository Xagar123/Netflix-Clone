//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    //MARK: -Properties

    static let identifier = "TitleTableViewCell"
    
    private let titlePosterUIImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLable: UILabel = {
        let lable = UILabel()
        
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
        
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    //MARK: -Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(playTitleButton)
        
        applyConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: -Helper
    
    func applyConstrain() {
        NSLayoutConstraint.activate([
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
            
            NSLayoutConstraint.activate([
                playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
    }
    
    public func configure(with model: TitleViewModel) {
        
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return}
        
        titlePosterUIImageView.sd_setImage(with: url)
        titleLable.text = model.titleName
    }
}
