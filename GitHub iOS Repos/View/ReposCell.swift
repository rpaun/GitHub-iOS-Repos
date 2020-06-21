//
//  ReposCell.swift
//  GitHub iOS Repos
//
//  Created by Radu Paun on 19/06/2020.
//  Copyright © 2020 Radu Paun. All rights reserved.
//

import Foundation
import UIKit

class ReposCell: UITableViewCell{
    
    var data : ItemsModel?{
        didSet{
            
            if let name = data?.name {
                nameLabel.text = name
            }else{
                print("Error unwrapping data at cell")
            }
        }
    }
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func layoutSubviews() {
        let view = contentView
        view.addSubview(nameLabel)
        view.addSubview(descLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            descLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
        ])
    }
}
