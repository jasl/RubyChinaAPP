//
//  FirstViewController.swift
//  RubyChinaApp
//
//  Created by 姜军 on 12/6/15.
//  Copyright © 2015 RubyChina. All rights reserved.
//

import UIKit

import NetworkAbstraction
import p2_OAuth2

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func SignOut(sender: UIButton) {
        provider.resetAuthorize()
    }
    
    @IBAction func SendHello(sender: UIButton) {
        provider.request(RubyChinaV3.Users.Get(login: "huacnlee")) { result in
            switch result {
            case let .Success(response):
                //dump(response)
                let json = response.mapSwiftyJSON()
                let user = User(byJSON: json["user"])

                dump(user)
            case let .Failure(error):
                dump(error)
            }
        }
    }
    
    @IBAction func createPost(sender: UIButton) {
        let title = "yoooooo"
        let body = "*小朋友们大家好*\n\n# 还记得我是谁么\n\n- 对了\n- 我就是给蓝猫配音的演员\n\n 葛炮!"
        let nodeId = "61"

        provider.request(RubyChinaV3.Topics.Create(title: title, body: body, nodeId: nodeId)) { result in
            switch result {
            case let .Success(response):
                let json = response.mapSwiftyJSON()
                dump(json)
                let topic = Topic(byJSON: json["topic"])
                dump(topic)
            case let .Failure(error):
                dump(error)
            }
        }
    }
    
    @IBAction func signInEmbedded(sender: UIButton) {
        signIn(sender)
    }
    
    func signIn(sender: UIButton) {
        provider.authorizeContext = self
        provider.authorize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
