//
//  RepoDetailedReadme.swift
//  GitHub iOS Repos
//
//  Created by Radu Paun on 20/06/2020.
//  Copyright © 2020 Radu Paun. All rights reserved.
//

import Foundation
import UIKit
import Down
import Alamofire


class RepoDetailedReadmeCell: UITableViewCell {
    
    
    var readmeDownLink : String?{
        didSet{
            AF.request(readmeDownLink!, method: .get).responseString { (response) in
                let down = try? DownView(frame: self.contentView.bounds, markdownString: response.description)
                self.contentView.addSubview(down!)
            }
        }
    }
    
    var readmeLink : String?{
        didSet{
            let readmelinkarr = readmeLink!.split(separator: "{")
            let urlStr = String(readmelinkarr[0] + "README.md")
            let url = URL(string: urlStr)!
            
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                guard let data = data else {return}
                do{
                    let json = try JSONDecoder().decode(ReadmeModel.self, from: data)
                    self.readmeDownLink = json.download_url
                }catch let error{
                    print(error)
                }
            }.resume()
        }
    }
    
    override func layoutSubviews() {
        
    }
}

