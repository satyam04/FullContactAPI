//
//  ResultViewController.swift
//  FullContactAPI
//
//  Created by Satyam Saluja on 04/10/17.
//  Copyright © 2017 Satyam Saluja. All rights reserved.
//

import Foundation
import UIKit
class ResultViewController: UIViewController,UITableViewDataSource {
    var resultArray:[String]=[]
    var imageURL:String=""
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageURL)
        if imageURL != ""{
        let url:URL=URL(string:imageURL)!
        
        let session=URLSession.shared
        let task=session.dataTask(with: url) { (data, response, error) in
            if data != nil{
                self.myImageView.image=UIImage(data:data!)
            }
            else{
                print(error)
            }
        }
        task.resume()
        }
        myTableView.dataSource=self
        myTableView.estimatedRowHeight=44
        myTableView.rowHeight=UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "mycell")
        cell?.textLabel?.text=resultArray[indexPath.row]
        cell?.textLabel?.numberOfLines=0
        return cell!
    }
}
