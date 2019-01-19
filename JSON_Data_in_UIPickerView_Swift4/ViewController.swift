//
//  ViewController.swift
//  JSON_Data_in_UIPickerView_Swift4
//
//  Created by DeEp KapaDia on 27/05/18.
//  Copyright © 2018 DeEp KapaDia. All rights reserved.
//

import UIKit


struct Country:Decodable{
    
   let name : String
    
}

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var LBL: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    var countries = [Country]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerview.delegate = self
        pickerview.dataSource = self
        
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil{
                do{
                    
                self.countries =  try JSONDecoder().decode([Country].self, from: data!)
                    
                }catch{
                    
                    print("Parse Error")
                    
                }
                DispatchQueue.main.async {
                    
                    self.pickerview.reloadComponent(0)
                    
                }
            }
            
        }.resume()
        
    }

    //return number of componenets
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //return total data of array that we get from API Or Personal aarray
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
        
    }
    
    //API Name that we need so we count that sata and fatch only name from API
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
    
    //dalegate method
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCount = countries[row].name
        
        LBL.text = selectedCount
    }

}

