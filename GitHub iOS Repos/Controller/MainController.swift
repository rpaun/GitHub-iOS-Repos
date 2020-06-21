//
//  MainController.swift
//  GitHub iOS Repos
//
//  Created by Radu Paun on 19/06/2020.
//  Copyright © 2020 Radu Paun. All rights reserved.
//

import Foundation
import UIKit

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Variables
    
    var tableData: ReposModel?
    
    let table = UITableView()
    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "iOS Repos"
        SetupTable()
        SetupLayout()
        FetchData()
    }
    
    func SetupLayout(){
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func SetupTable(){
        table.register(ReposCell.self, forCellReuseIdentifier: "ReposCell")
        table.delegate       = self
        table.dataSource     = self
        table.rowHeight      = 60
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = .clear
    }
    
    func FetchData(){
        let urlString = "https://api.github.com/search/repositories?q=ios&sort=stars&order=desc"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            guard let data = data else {return}
            do{
                let json = try JSONDecoder().decode(ReposModel.self, from: data)
                self.tableData = json
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }catch let error{
                print(error)
            }
        }.resume()
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = tableData?.items{
            return items.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ReposCell") as! ReposCell
        cell.data = tableData?.items[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let vc = RepoDetailedController()
        vc.data = tableData?.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
