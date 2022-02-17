//
//  DayController.swift
//  TheDayCouple
//
//  Created by rae on 2022/02/09.
//

import UIKit

final class DayController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "기념일"
    }

}
