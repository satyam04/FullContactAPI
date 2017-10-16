//
//  ViewController.swift
//  FullContactAPI
//
//  Created by Satyam Saluja on 03/10/17.
//  Copyright © 2017 Satyam Saluja. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var emailTextFeild: UITextField!
    var overallArray:[String]=[]
    var organisationArray:[String]=[]
    var socialProfiles:[String]=[]
    var photoURL:String=""
    @IBAction func nextButton(_ sender: Any) {
        let email=emailTextFeild.text!
        let header:HTTPHeaders=["X-FullContact-APIKey":"3f740c21034fc175"]
        Alamofire.request("https://api.fullcontact.com/v2/person.json?email=\(email)", method: .get, parameters: nil, headers: header).responseJSON { (response) in
            print(response.result.value!)
            let json=JSON(response.result.value)
            if let photoUrl=json["photos"].array{
                self.photoURL=photoUrl.first!["url"].string!
            }
            if let fullname=json["contactInfo"]["fullName"].string{
            self.overallArray.append("NAME: "+fullname)
            }
            if let ageRange=json["demographics"]["ageRange"].string{
                self.overallArray.append("AGE RANGE: " + ageRange)
            }
            if let locationGeneral=json["demographics"]["locationGeneral"].string{
                self.overallArray.append("LOCATION:"+locationGeneral)
            }
            if let socialProfiles=json["socialProfiles"].array{
            for social in socialProfiles{
              self.socialProfiles.append(social["typeName"].string! + ", URL- " + social["url"].string!)
            }
        }
            if let organisations=json["organizations"].array{
            for org in organisations{
                self.organisationArray.append("ORGANISATION NAME:" + org["name"].string! + " POSITION:" + org["title"].string!)
            }
          }
            self.receivedData()
        }
    }
    func receivedData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ResultVc=storyboard.instantiateViewController(withIdentifier:"resultVc") as! ResultViewController
        ResultVc.imageURL=self.photoURL
        ResultVc.resultArray.append(contentsOf: overallArray)
        if organisationArray.count>=1{
        ResultVc.resultArray.append(contentsOf: organisationArray)
        }
        if socialProfiles.count>=1{
        ResultVc.resultArray.append(contentsOf: socialProfiles)
        }
        
        present(ResultVc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

