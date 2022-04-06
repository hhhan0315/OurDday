//
//  ColorPickerController.swift
//  OurDday
//
//  Created by rae on 2022/04/06.
//

import UIKit

@available(iOS 14.0, *)
class ColorPickerController: UIColorPickerViewController {
    
    private let localStorage = LocalStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        
        supportsAlpha = false
        selectedColor = localStorage.colorForKey() ?? UIColor.systemBlue
    }
    
    private func configureNav() {
        navigationItem.title = "색상 설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(touchSaveButton))
    }
 
    @objc func touchCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func touchSaveButton() {
        localStorage.setColor(color: selectedColor)

        // notification center 등록
        NotificationCenter.default.post(name: Notification.Name.colorChange, object: nil)
        
        dismiss(animated: true)
    }
}
