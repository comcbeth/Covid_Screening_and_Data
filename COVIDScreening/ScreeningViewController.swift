//
//  ScreeningViewController.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 1/7/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit

public var mySymptoms:[String] = []
public var primary: [String] = []
public var secondary: [String] = []

class ScreeningViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
   
    public var symptoms: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        symptoms = addSymptoms()
        primary = addPrimarySymptoms()
        secondary = addSecondarySymptoms()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func addPrimarySymptoms() -> [String] {
        var tempPrimary: [String] = []
        
        tempPrimary.append("Fever")
        tempPrimary.append("Cough")
        tempPrimary.append("Mild Difficulty Breathing")
        return tempPrimary
    }
    func addSecondarySymptoms() -> [String] {
        var tempSecondary: [String] = []
        tempSecondary.append("Sore Throat")
        tempSecondary.append("Aches")
        tempSecondary.append("Headache")
        tempSecondary.append("Diarrhea")
        tempSecondary.append("Loss of Taste or Smell")
        tempSecondary.append("Congestion or Runny Nose")
        return tempSecondary
    }
    func addSymptoms() -> [String] {
        var tempSymptoms: [String] = []
        tempSymptoms.append("Fever")
        tempSymptoms.append("Cough")
        tempSymptoms.append("Mild Difficulty Breathing")
        tempSymptoms.append("Sore Throat")
        tempSymptoms.append("Aches")
        tempSymptoms.append("Headache")
        tempSymptoms.append("Diarrhea")
        tempSymptoms.append("Loss of Taste or Smell")
        tempSymptoms.append("Congestion or Runny Nose")
        tempSymptoms.append("COVID-19 Exposure")
        tempSymptoms.append("Positive COVID-19 Test")
        return tempSymptoms
    }
    
    @objc func setMySymptom(_ sender: UISwitch){
          // use the tag of Switch as index
        if sender.isOn{
            mySymptoms.append(symptoms[sender.tag])
            print(mySymptoms)
        }
        else {
            let Remove = mySymptoms.firstIndex(of: symptoms[sender.tag])
            mySymptoms.remove(at: Remove!)
        }
    }
}

extension ScreeningViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptoms.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let symptom = symptoms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Symptom Cell") as! symptomCell
        cell.setLabel(labeltext: symptom)
        cell.setSwitch()
        cell.SymptomSwitch.tag = indexPath.row
        cell.SymptomSwitch.addTarget(self, action: #selector(setMySymptom(_:)), for: .touchUpInside)
        return cell
    }

}
