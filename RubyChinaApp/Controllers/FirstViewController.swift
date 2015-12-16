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
        provider.request(RubyChinaV3.Hello()) { result in
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
