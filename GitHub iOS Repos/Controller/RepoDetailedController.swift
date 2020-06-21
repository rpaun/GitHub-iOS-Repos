//
//  RepoDetailed.swift
//  GitHub iOS Repos
//
//  Created by Radu Paun on 19/06/2020.
//  Copyright © 2020 Radu Paun. All rights reserved.
//

import Foundation
import UIKit


class RepoDetailedController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var data: ItemsModel?{
        didSet{
            if let data = data{
                navigationItem.title = data.name
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = table.dequeueReusableCell(withIdentifier: "RepoDetailedCell") as! RepoDetailedCell
            cell.data = data
            //cell.isUserInteractionEnabled = false
            return cell
        default:
            let cell = table.dequeueReusableCell(withIdentifier: "RepoDetailedReadmeCell") as! RepoDetailedReadmeCell
            cell.readmeLink = data?.contents_url
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 600
        default:
            return 1000
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    let table = UITableView()
    
    @objc func LinkTapped(){
        guard let url = URL(string: data!.html_url) else {return}
        UIApplication.shared.open(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetupTable()
        SetupLayout()
        
    }
    
    func SetupTable(){
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate   = self
        table.register(RepoDetailedCell.self, forCellReuseIdentifier: "RepoDetailedCell")
        table.register(RepoDetailedReadmeCell.self, forCellReuseIdentifier: "RepoDetailedReadmeCell")
    }
    
    func SetupLayout(){
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}
