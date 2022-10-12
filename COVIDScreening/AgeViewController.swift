//
//  AgeViewController.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 1/11/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit

public var myAge: ClosedRange<Int> = 0...1

class AgeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    public var ages: [Age] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ages = createAges()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    func createAges() -> [Age] {
        
        var tempAges: [Age] = []
        
        let ageRange1 = Age(minValue: 0, maxValue: 1)
        let ageRange2 = Age(minValue: 2, maxValue: 4)
        let ageRange3 = Age(minValue: 5, maxValue: 9)
        let ageRange4 = Age(minValue: 10, maxValue: 12)
        let ageRange5 = Age(minValue: 13, maxValue: 17)
        let ageRange6 = Age(minValue: 18, maxValue: 29)
        let ageRange7 = Age(minValue: 30, maxValue: 39)
        let ageRange8 = Age(minValue: 40, maxValue: 49)
        let ageRange9 = Age(minValue: 50, maxValue: 59)
        let ageRange10 = Age(minValue: 60, maxValue: 64)
        let ageRange11 = Age(minValue: 65, maxValue: 69)
        let ageRange12 = Age(minValue: 70, maxValue: 79)
        let ageRange13 = Age(minValue: 80, maxValue: 180)
        
        tempAges.append(ageRange1)
        tempAges.append(ageRange2)
        tempAges.append(ageRange3)
        tempAges.append(ageRange4)
        tempAges.append(ageRange5)
        tempAges.append(ageRange6)
        tempAges.append(ageRange7)
        tempAges.append(ageRange8)
        tempAges.append(ageRange9)
        tempAges.append(ageRange10)
        tempAges.append(ageRange11)
        tempAges.append(ageRange12)
        tempAges.append(ageRange13)
        
        return tempAges
        
    }
    
    @objc func setMyAge(_ sender: UIButton){
      // use the tag of button as index
        myAge = ages[sender.tag].ageRange
        print(myAge)
    }
}

extension AgeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let age = ages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Age Cell") as! TableAgeCell
        cell.setButton(age: age)
        cell.AgeButton.tag = indexPath.row
        cell.AgeButton.addTarget(self, action: #selector(setMyAge(_:)), for: .touchUpInside)
        return cell
    }
}


