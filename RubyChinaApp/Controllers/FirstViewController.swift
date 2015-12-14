//
//  FirstViewController.swift
//  RubyChinaApp
//
//  Created by 姜军 on 12/6/15.
//  Copyright © 2015 RubyChina. All rights reserved.
//

import UIKit

import NetworkAbstraction

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = APIProvider()
        provider.request(RubyChinaV3.Topics.Listing(type: .Excellent)) { result in
            switch result {
            case let .Success(response):
                //dump(response)
                let json = response.mapSwiftyJSON()

                let topics: [Topic] = json["topics"].arrayValue.map {
                    return Topic(byJSON: $0)!
                }

                dump(topics)
            case let .Failure(error):
                dump(error)
            }
        }

        provider.request(RubyChinaV3.Topics.Show(id: "28230")) { result in
            switch result {
            case let .Success(response):
                //dump(response)
                let json = response.mapSwiftyJSON()

                let topic = Topic(byJSON: json["topic"])!

                dump(topic)
            case let .Failure(error):
                dump(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
