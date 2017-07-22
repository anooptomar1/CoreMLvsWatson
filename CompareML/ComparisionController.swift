//
//  ComparisionController.swift
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

class ComparisionController: UIViewController {

  @IBOutlet weak var accuracyLabel1: UILabel!
  
  @IBOutlet weak var accuracyLabel2: UILabel!
  @IBOutlet weak var confidenceLabel2: UILabel!
  @IBOutlet weak var confidenceLabel1: UILabel!
  
  let nwthread3 = DispatchQueue(label:"nwThread3");
  let nwthread4 = DispatchQueue(label:"nwThread4");
  
  
  override func viewDidLoad() {
    
  }
  
  func analyze() {
    
  }
  
  
}
