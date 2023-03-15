//
//  RandomImageViewController+Extension.swift
//  random image API practice
//
//  Created by Ryan Lin on 2023/3/14.
//

import Foundation
import UIKit

extension RandomImageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return firstOptions.count
        } else {
            return secondOptions.count
        }
    }
}

extension RandomImageViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return firstOptions[row]
        } else {
            return secondOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            secondOptions = firstOptions
            let firstSelected = pickerView.selectedRow(inComponent: 0)
            
            secondOptions.remove(at: firstSelected)
            pickerView.selectRow(2, inComponent: 1, animated: true)
            pickerView.reloadComponent(1)
        } else if component == 1 {
            //因為array會隨component0而改變所以也必須更新
            pickerView.reloadComponent(1)
        }
        firstOption = firstOptions[pickerView.selectedRow(inComponent: 0)]
        secondOption = secondOptions[pickerView.selectedRow(inComponent: 1)]
    }
}
