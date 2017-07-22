//
//  DataManager.swift
//  CompareML
//
//  Created by Sangeeth K Sivakumar on 7/10/17.
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

class DataManager: NSObject {
  typealias arrayOfstringDictionary = Array<Dictionary<String,String>>
  typealias anyDictionary = Dictionary<String,Any>
  var defaultPostData:Data?
  
  func makeNetworkRequest(urlString:String, method:String = "GET" ,completionHandler:@escaping (_ result:anyDictionary?, _ error:String?)->()) {
    let url:URL =  URL(string: urlString)!
    //let config = URLSessionConfiguration.background(withIdentifier: "DataManager")
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    if(method == "POST"){
        if let data = self.defaultPostData {
          request.httpBody = data
        }
    }
    
    let task = session.dataTask(with: request) { (data, response, error) in
      
      if(error == nil) {
        do {
          let resultInJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! anyDictionary
          completionHandler(resultInJSON, nil)
          
        }
        catch{
          completionHandler(nil, "parsing error")
        }
      }
      else {
        completionHandler(nil, error?.localizedDescription)
      }
      
      
    }
    task.resume()
  }
  

}
