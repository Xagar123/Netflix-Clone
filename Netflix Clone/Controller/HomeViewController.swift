//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Admin on 11/01/23.
//

import UIKit

enum Section: Int {
    case TrendingMovie = 0
    case TrendingTv    = 1
    case Popular       = 2
    case Upcomming     = 3
    case TopRated      = 4
}

class HomeViewController: UIViewController {
    
    
    //MARK: -Properties
    
    let sectionTitle:[String] = ["Trending Movies","Tranding TV","Popular" ,"Upcomming Movies","Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    //MARK: - Selector
    
    
    //MARK: -Helper
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            
        UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
        UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        
        navigationController?.navigationBar.tintColor = .white
        
    }
    
}


//MARK: -UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell()}
        
        
        switch indexPath.section {
        case Section.TrendingMovie.rawValue :
            APICaller.shared.getTrendingMovie { result in
                switch result {
                    
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Section.TrendingTv.rawValue:
            APICaller.shared.getTrandingTV { result in
                switch result {
                    
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Section.Popular.rawValue:
            APICaller.shared.getPopularMovie { result in
                switch result {
                    
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Section.Upcomming.rawValue:
            APICaller.shared.getUpcommingMovies { result in
                switch result {
                    
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Section.TopRated.rawValue:
            APICaller.shared.getTopRating { result in
                switch result {
                    
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
                

        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
        
        //hiding the nav bar when scroll up and showing when scroll down
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let defaultOffSet = view.safeAreaInsets.top
            let offset = scrollView.contentOffset.y + defaultOffSet
            
            navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        }
        
        //set header title
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTitle[section]
        }
        
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            header.textLabel?.frame = CGRect(x: Int(header.bounds.origin.x) + 20, y: Int(header.bounds.origin.y), width: 100, height: Int(header.bounds.height))
            header.textLabel?.textColor = .white
            header.textLabel?.text = header.textLabel?.text?.capitalizerFirstLeter()
        }
    }
    


//MARK: -UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
