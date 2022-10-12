//
//  AgeCell.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 1/12/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit

class TableAgeCell: UITableViewCell {



    @IBOutlet weak var AgeButton: UIButton!
    
    func setButton(age: Age){
        AgeButton.setTitle(age.text,for: .normal)
    }
    
}
