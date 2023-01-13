//
//  SearchReasult.swift
//  Netflix Clone
//
//  Created by Admin on 12/01/23.
//

import UIKit

protocol SearchReasultDelegate: AnyObject {
    func searchReasultVCDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchReasult: UIViewController {
    
    public var titles:[Title] = [Title]()
    
    public weak var delegate: SearchReasultDelegate?

    public let searchResultCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
    

}

extension SearchReasult: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell  else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        
        APICaller.shared.getYoutubeMovie(with: titleName ) { [weak self] result in
            switch result {
                
            case .success(let videoElement):
                self?.delegate?.searchReasultVCDidTapItem(TitlePreviewViewModel(title: title.original_title ?? "", youTubeVideo: videoElement, titleOverView: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
       
    }
    
    
}
