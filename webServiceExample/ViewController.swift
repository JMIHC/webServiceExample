//
//  ViewController.swift
//  webServiceExample
//
//  Created by John Cornyn on 9/7/16.
//  Copyright © 2016 Johnny Cornyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var forecastLabel: LTMorphingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastLabel.text = ""
        
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPSessionManager()
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/city?lat=42.07225&lon=-87.722839&APPID=7ae26182752050a0c0c32b9c8e0de957",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let responseObject = responseObject {
                            
                            let json = JSON(responseObject)
                            if let forecast = json["list"][0]["weather"][0]["description"].string {
                                self.forecastLabel.text = forecast
                                self.forecastLabel.SparkleLoad()
                            }
                            activityIndicatorView.removeFromSuperview()
                        }
        },
                    failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

