//
//  SymptomCell.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 1/14/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit

class symptomCell: UITableViewCell {
    
    @IBOutlet weak var SymptomLabel: UILabel!
    @IBOutlet weak var SymptomSwitch: UISwitch!
    
    func setSwitch() {
        SymptomSwitch.isOn = false
    }
    
    func setLabel(labeltext: String){
        SymptomLabel.text = labeltext
    }
    
    

}
