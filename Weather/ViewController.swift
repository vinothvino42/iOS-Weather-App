//
//  ViewController.swift
//  Weather
//
//  Created by Vinoth Vino on 16/05/17.
//  Copyright © 2017 CoderEarth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultsLabel: UILabel!
        
    @IBAction func submitBtn(_ sender: Any) {
        
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/"+cityTextField.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest") {
            
        // let urlnew = URL(string: "https://www.stackoverflow.com")!
        //   print(url)
        
        let request = NSMutableURLRequest(url: url)
        //  print(request)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var msg = ""
            
            if error != nil{
                
                print(error)
                
            }else{
                
                
                if let unwrappedData = data{
                    
                    //   print("Unwrapped Datass")
                    // print(unwrappedData)
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    //   print("Data Stringss")
                    // print(dataString)
                    
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArrays = dataString?.components(separatedBy: stringSeparator){
                        
                        //   print(contentArrays)
                        if contentArrays.count > 1 {
                            
                            
                            stringSeparator = "</span>"
                            
                            let newContentArrays = contentArrays[1].components(separatedBy: stringSeparator)
                            
                            if newContentArrays.count > 1 {
                                
                                msg = newContentArrays[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(msg)
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if msg == "" {
                
                msg = "Please try again later"
            }
            
            DispatchQueue.main.sync(execute: {
                
                
                self.resultsLabel.text = msg
                
            })
            
        }
    
        task.resume()
            
        }else{
            
            resultsLabel.text = "Please try agan later"
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}

