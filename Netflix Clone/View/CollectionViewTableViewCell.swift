//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewcellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    //MARK: -Properties
    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var titles:[Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return cv
    }()
    
    
    
    //MARK: -LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //setting up frame
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
   
    public func configure(with title:[Title]) {
        self.titles = title
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            self.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath){
        DataPersistanceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            
            switch result {
                
            case .success():
//                NotificationCenter.default.post(name: NSNotification(name: NSNotification.Name(rawValue: ("Downloaded")) ?? "ddd", object: nil)
                print("download to  core data base")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("Download\(titles[indexPath.count].original_title)")
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell() }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getYoutubeMovie(with: titleName + "trailer") { [weak self] result in
            
            guard let self = self else { return}
            switch result {
                
            case .success(let VideoElement):
                print(VideoElement.id)
                
                let title = self.titles[indexPath.row]
                
                guard let titleOverView = title.overview else { return }
                
                let viewModel = TitlePreviewViewModel(title: titleName, youTubeVideo: VideoElement, titleOverView: titleOverView)
                
                self.delegate?.collectionViewTableViewcellDidTapCell(self, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider:nil) { [weak self] _ in
            
           // guard let self = self else { return}
            let downloadAction = UIAction(title: "Download",subtitle: nil,image: nil, state: .off) { _ in
                print("Download tapped")
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", options: .displayInline,children: [downloadAction])
        }
                          
      return config
    }

}


    
    

