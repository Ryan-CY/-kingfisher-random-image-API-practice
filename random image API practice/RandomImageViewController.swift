//
//  RandomImageViewController.swift
//  random image API practice
//
//  Created by Ryan Lin on 2023/3/14.
//

import UIKit
import Kingfisher

class RandomImageViewController: UIViewController {
    
    var firstOptions = ["cat", "ocean", "sky", "people", "moon", "leaf", "flower"]
    var secondOptions = [String]()
    var firstOption = ""
    var secondOption = ""
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var optionTextField: UITextField!
    @IBOutlet var optionPickerView: UIPickerView!
    @IBOutlet var optionToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //連好PickerView的delegate跟dataSource到Controller
        optionPickerView.delegate = self
        optionPickerView.dataSource = self
        
        //把顯示鍵盤變成顯示PickerView
        optionTextField.inputView = optionPickerView
        //加入PickerView上方的ToolBar
        optionTextField.inputAccessoryView = optionToolBar
        
        tapToSelect()
        configuration()
    }
    
    func fetchImage() {
        optionTextField.isHidden = true
        if let randomURL = URL(string: "https://loremflickr.com/350/400/\(firstOption),\(secondOption)/all") {
            print(randomURL.description)
          
            //顯示未知進度
            pictureImageView.kf.indicatorType = .activity
            //等待載入影像時，顯示placeholder設定的圖示
            let processorRoundCorner = RoundCornerImageProcessor(cornerRadius: 15)
            //在影像上覆蓋一層自訂顏色的透明色調
            let processorOverLay = OverlayImageProcessor(overlay: .systemOrange)
            
            pictureImageView.kf.setImage(
                with: randomURL,
                placeholder: UIImage(systemName: "sailboat"),
                options: [
                    .processor(processorRoundCorner),
                    .processor(processorOverLay)
                ])
        }
    }
    
    func tapToSelect() {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 2
        tap.addTarget(self, action: #selector(showPickerVier))
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(tap)
    }
    
    @objc func showPickerVier() {
        //讓TextField顯示鍵盤
        optionTextField.becomeFirstResponder()
    }
    
    @IBAction func chosenCancelBarItem(_ sender: Any) {
        view.endEditing(true)
        pictureImageView.image = UIImage(systemName: "photo")
        pictureImageView.contentMode = .scaleAspectFit
        optionTextField.isHidden = false
    }
    
    
    @IBAction func getImageBarItem(_ sender: Any) {
        fetchImage()
    }
    
    func configuration() {
        pictureImageView.image = UIImage(systemName: "photo")
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.tintColor = .systemGray5
    }
}
