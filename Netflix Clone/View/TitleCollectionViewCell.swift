//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    //MARK: -Properties
    
    
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    //MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    //MARK: -Helper
    
    //it's going to hold the poster url
    public func configure(with model: String) {

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return}
        posterImageView.sd_setImage(with: url)
        print(model)
    }
    
    
    
    //MARK: -Selector
    
    
    

}
