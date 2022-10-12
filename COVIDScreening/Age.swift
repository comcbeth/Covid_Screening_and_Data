//
//  Age.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 1/12/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import Foundation

struct Age {
    var minValue: Int
    var maxValue: Int
    var text: String
    var ageRange:ClosedRange<Int>
    
    init(minValue: Int, maxValue: Int){
        self.minValue = minValue
        self.maxValue = maxValue
        self.ageRange = self.minValue...self.maxValue
        if self.maxValue<80 {
            self.text = "\(minValue)-\(maxValue)"
        }
        else {
            self.text = "\(minValue)+"
        }
    }
}
