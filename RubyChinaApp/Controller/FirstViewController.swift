//
//  FirstViewController.swift
//  RubyChinaApp
//
//  Created by 姜军 on 12/6/15.
//  Copyright © 2015 RubyChina. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let client = RestClient(baseURL: "https://ruby-china.org/api/v3/")
        client.get("topics") {
            (request, response, json, error) in
            let topics: [Topic] = json["topics"].arrayValue.map {
                //debugPrintln($0)
                return Topic(byJSON: $0)!
            }
            debugPrint(topics)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

