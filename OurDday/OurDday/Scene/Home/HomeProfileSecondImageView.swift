//
//  HomeProfileSecondImageView.swift
//  OurDday
//
//  Created by rae on 2022/08/06.
//

import UIKit

class HomeProfileSecondImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        let interaction = UIContextMenuInteraction(delegate: self)
        
        self.image = UIImage(systemName: "face.smiling")
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 50
        self.tintColor = .lightGray
        
        self.addInteraction(interaction)
        self.isUserInteractionEnabled = true
    }
}

// MARK: - UIContextMenuInteractionDelegate
extension HomeProfileSecondImageView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { _ in
                let updateAction = UIAction(title: "변경", image: UIImage(systemName: "photo")) { _ in
                    print("home profile second")
                }
                return UIMenu(title: "", children: [updateAction])
            })
    }
}
