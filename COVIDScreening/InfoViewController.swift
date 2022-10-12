//
//  InfoViewController.swift
//  COVIDScreening
//
//  Created by Cole McBeth on 3/12/21.
//  Copyright © 2021 Cole McBeth. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var state = "NY"
    private var row = "New York"
    private let apiKey = Bundle.main.infoDictionary?["COVID_ACT_NOW_APIKEY"] as! String;
    private var url = String()
    let content = UNMutableNotificationContent()
    

    @IBOutlet weak var CasesLabel: UILabel!
    @IBOutlet weak var LocationPicker: UIPickerView!
    @IBOutlet weak var StateButton: UIButton!
    @IBOutlet weak var DeathsLabel: UILabel!
    @IBOutlet weak var StateLabel: UILabel!
    @IBOutlet weak var FirstDoseLabel: UILabel!
    @IBOutlet weak var FullyVaccLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationPicker.isHidden = true
        StateButton.isHidden = true
        LocationPicker.delegate = self
        LocationPicker.dataSource = self
        url = "https://api.covidactnow.org/v2/state/\(state).json?apiKey=\(apiKey)"

        getApiData(from: url)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func StateButtonClicked(_ sender: UIButton) {
        url = "https://api.covidactnow.org/v2/state/\(state).json?apiKey=\(apiKey)"
        getApiData(from: url)
        LocationPicker.isHidden = true
        StateButton.isHidden = true
        CasesLabel.isHidden = false
        DeathsLabel.isHidden = false
        FirstDoseLabel.isHidden = false
        FullyVaccLabel.isHidden = false
    }
    private func getApiData(from url:String){
        
       let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                print(error)
                return
            }
            
            print(data)
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch let DecodingError.dataCorrupted(context) {
                    print(context)
            }
            catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
            guard let json = result else {
                return
            }
            DispatchQueue.main.async {
                self.StateLabel.text! = self.row.uppercased()
                self.CasesLabel.text! = "Cases: \(json.actuals!.cases!)"
                self.DeathsLabel.text! = "Deaths: \(json.actuals!.deaths!)"
                self.FirstDoseLabel.text! = "1st Dose of Vaccine: \(json.actuals!.vaccinationsInitiated!)"
                self.FullyVaccLabel.text! = "Fully Vaccinated: \(json.actuals!.vaccinationsCompleted!)"
            }
            })
        task.resume()
        
    }
    
    let states: Array = ["Alabama","Alaska", "Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania", "Puerto Rico", "Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington", "Washington, D.C.", "West Virginia","Wisconsin","Wyoming"]
    
    let statesDictionary = ["Alabama": "AL",
    "Alaska": "AK",
    "Arizona": "AZ",
    "Arkansas": "AR",
    "California": "CA",
    "Colorado": "CO",
    "Connecticut": "CT",
    "Delaware": "DE",
    "Florida": "FL",
    "Georgia": "GA",
    "Hawaii": "HI",
    "Idaho": "ID",
    "Illinois": "IL",
    "Indiana": "IN",
    "Iowa": "IA",
    "Kansas": "KS",
    "Kentucky": "KY",
    "Louisiana": "LA",
    "Maine": "ME",
    "Maryland": "MD",
    "Massachusetts": "MA",
    "Michigan": "MI",
    "Minnesota": "MN",
    "Mississippi": "MS",
    "Missouri": "MO",
    "Montana": "MT",
    "Nebraska": "NE",
    "Nevada": "NV",
    "New Hampshire": "NH",
    "New Jersey": "NJ",
    "New Mexico": "NM",
    "New York": "NY",
    "North Carolina": "NC",
    "North Dakota": "ND",
    "Ohio": "OH",
    "Oklahoma": "OK",
    "Oregon": "OR",
    "Pennsylvania": "PA",
    "Puerto Rico": "PR",
    "Rhode Island": "RI",
    "South Carolina": "SC",
    "South Dakota": "SD",
    "Tennessee": "TN",
    "Texas": "TX",
    "Utah": "UT",
    "Vermont": "VT",
    "Virginia": "VA",
    "Washington": "WA",
    "Washington, D.C.": "DC",
    "West Virginia": "WV",
    "Wisconsin": "WI",
    "Wyoming": "WY"]
    
    @IBAction func LocationButtonClicked(_ sender: IconButton) {
        DispatchQueue.main.async {
            self.LocationPicker.isHidden = false
            self.StateButton.isHidden = false
            self.CasesLabel.isHidden = true
            self.DeathsLabel.isHidden = true
            self.FirstDoseLabel.isHidden = true
            self.FullyVaccLabel.isHidden = true
        }
    }
    
}
extension InfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return states[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(row)
        self.row = states[row]
        self.state = statesDictionary[states[row]]!
        print(self.state)
        
    }
    
    
}

public struct AnyDecodable : Decodable {
  
  let value :Any
  
  public init<T>(_ value :T?) {
    self.value = value ?? ()
  }
  
  public init(from decoder :Decoder) throws {
    let container = try decoder.singleValueContainer()
    
    if let string = try? container.decode(String.self) {
      self.init(string)
    } else if let int = try? container.decode(Int.self) {
      self.init(int)
    } else {
      self.init(())
    }
    // handle all the different types including bool, array, dictionary, double etc
  }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Response: Codable {
    let fips, country, state: String?
    let county: JSONNull?
    let level: String?
    let lat: JSONNull?
    let locationID: String?
    let long: JSONNull?
    let population: Int?
    let metrics: Metrics?
    let riskLevels: RiskLevels?
    let actuals: Actuals?
    let annotations: [String: Annotation?]?
    let lastUpdatedDate: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case fips, country, state, county, level, lat
        case locationID = "locationId"
        case long, population, metrics, riskLevels, actuals, annotations, lastUpdatedDate, url
    }
}

// MARK: - Actuals
struct Actuals: Codable {
    let cases, deaths, positiveTests, negativeTests: Int?
    let contactTracers: Int?
    let hospitalBeds, icuBeds: Beds?
    let newCases, newDeaths, vaccinesDistributed, vaccinationsInitiated: Int?
    let vaccinationsCompleted, vaccinesAdministered: Int?
    let vaccinesAdministeredDemographics, vaccinationsInitiatedDemographics: VaccinedDemographics?
}

// MARK: - Beds
struct Beds: Codable {
    let capacity, currentUsageTotal, currentUsageCovid: Int?
    let typicalUsageRate: Double?
}

// MARK: - VaccinedDemographics
struct VaccinedDemographics: Codable {
    let age: [String: Int]?
    let race: Race?
    let ethnicity: Ethnicity?
    let sex: Sex?
}

// MARK: - Ethnicity
struct Ethnicity: Codable {
    let hispanic, nonHispanic, unknown: Int?

    enum CodingKeys: String, CodingKey {
        case hispanic
        case nonHispanic = "non-hispanic"
        case unknown
    }
}

// MARK: - Race
struct Race: Codable {
    let aiAn, asian, black, other: Int?
    let pacificIslander, unknown, white, multiple: Int?

    enum CodingKeys: String, CodingKey {
        case aiAn = "ai_an"
        case asian, black, other
        case pacificIslander = "pacific_islander"
        case unknown, white, multiple
    }
}

// MARK: - Sex
struct Sex: Codable {
    let female, male, other, unknown: Int?
}

// MARK: - Annotation
struct Annotation: Codable {
    let sources: [SourceElement]?
    let anomalies: [Anomaly]?
}

// MARK: - Anomaly
struct Anomaly: Codable {
    let date, type: String?
    let originalObservation: Int?

    enum CodingKeys: String, CodingKey {
        case date, type
        case originalObservation = "original_observation"
    }
}

// MARK: - SourceElement
struct SourceElement: Codable {
    let type: SourceEnum?
    let url: String?
    let name: Name?
}

enum Name: String, Codable {
    case centersForDiseaseControlAndPrevention = "Centers for Disease Control and Prevention"
    case departmentOfHealthAndHumanServices = "Department of Health and Human Services"
    case theNewYorkTimes = "The New York Times"
}

enum SourceEnum: String, Codable {
    case hhsTesting = "HHSTesting"
    case nyTimes = "NYTimes"
    case other = "other"
    case testAndTrace = "TestAndTrace"
}

// MARK: - Metrics
struct Metrics: Codable {
    let testPositivityRatio: Double?
    let testPositivityRatioDetails: TestPositivityRatioDetails?
    let caseDensity, contactTracerCapacityRatio, infectionRate, infectionRateCI90: Double?
    let icuHeadroomRatio: Double?
    let icuHeadroomDetails: IcuHeadroomDetails?
    let icuCapacityRatio, vaccinationsInitiatedRatio, vaccinationsCompletedRatio: Double?
}

// MARK: - IcuHeadroomDetails
struct IcuHeadroomDetails: Codable {
    let currentIcuCovid: Int?
    let currentIcuCovidMethod: String?
    let currentIcuNonCovid: Int?
    let currentIcuNonCovidMethod: String?
}

// MARK: - TestPositivityRatioDetails
struct TestPositivityRatioDetails: Codable {
    let source: SourceEnum?
}

// MARK: - RiskLevels
struct RiskLevels: Codable {
    let overall, testPositivityRatio, caseDensity, contactTracerCapacityRatio: Int?
    let infectionRate, icuHeadroomRatio, icuCapacityRatio: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

