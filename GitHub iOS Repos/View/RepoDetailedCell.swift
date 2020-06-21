//
//  RepoDetailedCell.swift
//  GitHub iOS Repos
//
//  Created by Radu Paun on 20/06/2020.
//  Copyright © 2020 Radu Paun. All rights reserved.
//

import Foundation
import UIKit

class RepoDetailedCell: UITableViewCell {
    
    let avatar : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 150
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let ownerNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let forksLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let watchersLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let linkToRepo : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isUserInteractionEnabled = true
        btn.addTarget(RepoDetailedController(), action: #selector(RepoDetailedController.LinkTapped), for: .touchUpInside)
        btn.setTitleColor(.link, for: .normal)
        return btn
    }()
    
    var data: ItemsModel?{
        didSet{
            
            if let data = data{
                avatar.load(url: URL(string: data.owner.avatar_url)!)
                ownerNameLabel.text = data.owner.login
                watchersLabel.text = "Watchers : \n" + data.watchers.description
                forksLabel.text = "Forks: \n" + data.forks.description
                linkToRepo.setTitle(data.html_url, for: .normal)
            }
        }
    }
    
    override func layoutSubviews() {
        SetupLayout()
    }
    
    func SetupLayout(){
        let view = contentView
        view.addSubview(avatar)
        view.addSubview(ownerNameLabel)
        view.addSubview(forksLabel)
        view.addSubview(watchersLabel)
        view.addSubview(linkToRepo)
        
        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatar.widthAnchor.constraint(equalToConstant: 300),
            avatar.heightAnchor.constraint(equalToConstant: 300),
            
            ownerNameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor),
            ownerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            forksLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor),
            forksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            watchersLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor),
            watchersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            linkToRepo.topAnchor.constraint(equalTo: watchersLabel.bottomAnchor, constant: 10),
            linkToRepo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            linkToRepo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}
