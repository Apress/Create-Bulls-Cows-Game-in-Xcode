//
//  ViewController.swift
//  BullsCows
//
//  Created by Tihomir RAdeff on 4.10.23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pv1: UIPickerView!
    @IBOutlet weak var pv2: UIPickerView!
    @IBOutlet weak var pv3: UIPickerView!
    @IBOutlet weak var pv4: UIPickerView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    let pickerData = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    var gen1: Int?
    var gen2: Int?
    var gen3: Int?
    var gen4: Int?
    
    var result = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generate random 4 digit number without duplicates
        gen1 = Int.random(in: 1...9)
        
        repeat {
            gen2 = Int.random(in: 1...9)
        } while gen2 == gen1
                    
        repeat {
            gen3 = Int.random(in: 1...9)
        } while gen3 == gen1 || gen3 == gen2
                    
        repeat {
            gen4 = Int.random(in: 1...9)
        } while gen4 == gen1 || gen4 == gen2 || gen4 == gen3
                    
        checkButton.layer.cornerRadius = 16
        
        pv1.delegate = self
        pv1.dataSource = self
        pv1.selectRow(0, inComponent: 0, animated: true)
        
        pv2.delegate = self
        pv2.dataSource = self
        pv2.selectRow(1, inComponent: 0, animated: true)
        
        pv3.delegate = self
        pv3.dataSource = self
        pv3.selectRow(2, inComponent: 0, animated: true)
        
        pv4.delegate = self
        pv4.dataSource = self
        pv4.selectRow(3, inComponent: 0, animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row])"
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        let num1 = pv1.selectedRow(inComponent: 0) + 1
        let num2 = pv2.selectedRow(inComponent: 0) + 1
        let num3 = pv3.selectedRow(inComponent: 0) + 1
        let num4 = pv4.selectedRow(inComponent: 0) + 1
        
        //check for duplicates
        if num1 != num2 && num1 != num3 && num1 != num4 && num2 != num3 && num2 != num4 && num3 != num4 {
            
            //bulls - guessed digit and its place
            var bulls = 0
            
            if num1 == gen1 {
                bulls = bulls + 1
            }
            
            if num2 == gen2 {
                bulls = bulls + 1
            }
            
            if num3 == gen3 {
                bulls = bulls + 1
            }
            
            if num4 == gen4 {
                bulls = bulls + 1
            }
            
            //cows - guessed digit but misplaced
            var cows = 0
            
            if num1 == gen2 || num1 == gen3 || num1 == gen4 {
                cows = cows + 1
            }
            
            if num2 == gen1 || num2 == gen3 || num2 == gen4 {
                cows = cows + 1
            }
            
            if num3 == gen2 || num3 == gen1 || num3 == gen4 {
                cows = cows + 1
            }
            
            if num4 == gen2 || num4 == gen3 || num4 == gen1 {
                cows = cows + 1
            }
            
            index = index + 1
            
            result = "\(result)\(index). \(num1)\(num2)\(num3)\(num4) Bulls: \(bulls) Cows: \(cows)\n"
            
            //check for win
            if bulls == 4 {
                checkButton.isUserInteractionEnabled = false
                result = "\(result)You won!"
            }
            
            //display result
            textView.text = result
            
        } else {
            result = "\(result)Wrong input!\n"
            textView.text = result
        }
    }
    
}

