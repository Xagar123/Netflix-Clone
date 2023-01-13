//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Admin on 12/01/23.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 22, weight: .bold)
        lable.text = "Herry potter"
        return lable
    }()
    
    private let overViewLable: UILabel = {
       let lable = UILabel()
        lable.font = .systemFont(ofSize: 18, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.text = "this is test case"
        return lable
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.layer.cornerRadius = 40 / 2
        button.clipsToBounds = true
        return button
    }()

    private let webView: WKWebView = {
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLable)
        view.addSubview(overViewLable)
        view.addSubview(downloadButton)
        
        configureConstrain()
    }
    

    func configureConstrain() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            overViewLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15),
            overViewLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overViewLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overViewLable.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overViewLable.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLable.text = model.title
        overViewLable.text = model.titleOverView
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youTubeVideo.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }

}
