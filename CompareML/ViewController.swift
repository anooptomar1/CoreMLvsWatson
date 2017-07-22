//
//  ViewController.swift
//  CompareML
//
//  Created by Sangeeth K Sivakumar on 7/9/17.
/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var selectedImageView: UIImageView!
  
  @IBOutlet weak var count: UILabel!
  @IBOutlet weak var value2: UILabel!
  @IBOutlet weak var value1: UILabel!
  var countValue = 1;
 typealias anyDictionary = Dictionary<String,Any>
  let nwthread = DispatchQueue(label:"nwThread1");
  let nwthread2 = DispatchQueue(label:"nwThread2");
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    selectedImageView.image = UIImage(named: "file1");
    self.analyze()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func detailTapped(_ sender: Any) {
    
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "compare") as! ComparisionController
    
    self.navigationController?.pushViewController(vc, animated: true);
  }
  
  
  @IBAction func nextButtonTapped(_ sender: Any) {
    countValue = (countValue == 15 ? 1 : countValue + 1);
    self.count.text = "Count : \(countValue)"
    selectedImageView.image = UIImage(named: "file\(countValue)");
    analyze()
  }
  
func analyze() {
  let manager = DataManager()
  manager.defaultPostData = UIImageJPEGRepresentation(self.selectedImageView.image!, 0.5)
  nwthread.async {
    //Replace XXX with your local Device IP
    let url = "http://XXX:8080/data/analyzeImage" // Local URL EndPoint
    manager.makeNetworkRequest(urlString: url, method: "POST", completionHandler: { (result, error) in
      
      let resultToPrint = self.getResult(input: result!)
      
      DispatchQueue.main.async {
        self.value1.text = resultToPrint
      }
    })
  }
  nwthread2.async {
    // Watson deafult API - // Replace with API Key XXXXX
    let url = "https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?api_key=XXXXXXXXXXXXXXXXXXXX&version=2016-05-20"
    
    manager.makeNetworkRequest(urlString: url, method: "POST", completionHandler: { (result, error) in
      
      let resultToPrint = self.getResultForWatson(input: result!)
      
      DispatchQueue.main.async {
        self.value2.text = resultToPrint
      }
    })
  }
  
  }
  
  func getResult(input:anyDictionary) -> String {
    let value = (input["data"] as! Array)[0] as anyDictionary;
    
    let result = """
    Identified: \(value["identifier"] ?? "NIL")
    Confidence: \(value["value"] ?? "NIL")
    """
    return result
  }
  
  func getResultForWatson(input:anyDictionary) -> String {
    let level1 = (input["images"] as! Array)[0] as anyDictionary
    
    let level2 = (level1["classifiers"] as! Array)[0] as anyDictionary
    
    let level3 = (level2["classes"] as! Array)[0] as anyDictionary
    
    let result = """
    Identified: \(level3["class"] ?? "NIL")
    Confidence: \(level3["score"] ?? "NIL")
    """
    return result
  }
}

