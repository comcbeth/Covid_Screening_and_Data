//
//  ResultsViewController.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 1/11/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit


class ResultsViewController: UIViewController {

    @IBOutlet weak var ResultsText: UILabel!
    var hasPrimary: Bool = false
    var Positive: Bool = false
    var AsympExposed: Bool = false
    var Asymp: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results(symptoms: mySymptoms)
        if hasPrimary {
            ResultsText.text = "• Isolate for 10 days\n• Stay home except to get medical care.\n• Stay in your room as much as possible except to get medical care.\n• Cover your coughs and sneezes with a tissue.\n• Clean your hands often.\n• Avoid close contact with other people. Stay at least 6 feet away from other people.\n• Wear a mask when around others, if possible.\n• Do not go to work,school,or public areas including grocery stores,pharmacies,or restaurants. Consider delivery options for food and medicine.\n• Do not use public transportation or ridesharing.\n• Monitor your health and notify a medical provider if you start to feel worse.\n• You should get tested for COVID-19"
        }
        else if Positive == true {
            ResultsText.text = "• Isolate for 10 days\n• Stay home except to get medical care.\n• Stay in your room as much as possible except to get medical care.\n• Cover your coughs and sneezes with a tissue.\n• Clean your hands often.\n• Avoid close contact with other people. Stay at least 6 feet away from other people.\n• Wear a mask when around others, if possible.\n• Do not go to work,school,or public areas including grocery stores,pharmacies,or restaurants. Consider delivery options for food and medicine.\n• Do not use public transportation or ridesharing.\n• Monitor your health and notify a medical provider if you start to feel worse."
        }
        else if Asymp == true{
            ResultsText.text = "It sounds like you are feeling ok. Monitor for any COVID-19 symptoms."
        }
        else if AsympExposed == true {
            ResultsText.text = "• Quarantine for 14 days\n• Stay home except to get medical care.\n• Stay in your room as much as possible except to get medical care.\n• Cover your coughs and sneezes with a tissue.\n• Clean your hands often.\n• Avoid close contact with other people. Stay at least 6 feet away from other people.\n• Wear a mask when around others, if possible.\n• Do not go to work,school,or public areas including grocery stores,pharmacies,or restaurants. Consider delivery options for food and medicine.\n• Do not use public transportation or ridesharing.\n• Monitor your health and notify a medical provider if you start to feel worse.\n• You should get tested for COVID-19"        }
        // Do any additional setup after loading the view.
    }
    
    func results(/*age: ClosedRange<Int>,*/ symptoms: [String]){
        if symptoms.isEmpty {
            Asymp = true
        }
        else if symptoms.count == 1 && symptoms.contains("COVID-19 Exposure") {
            AsympExposed = true
        }
        else {
            for symptom in symptoms{
                if primary.contains(symptom) || secondary.contains(symptom){
                    hasPrimary = true
                }
                else if symptom == "Positive COVID-19 Test"{
                    Positive = true
                }
                

            }
        }
        
    }

   

}
