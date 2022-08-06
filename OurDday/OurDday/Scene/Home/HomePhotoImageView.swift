//
//  HomePhotoImageView.swift
//  OurDday
//
//  Created by rae on 2022/08/06.
//

import UIKit

class HomePhotoImageView: UIImageView {
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
        
        self.image = UIImage(named: "photo")
        self.addInteraction(interaction)
        self.isUserInteractionEnabled = true
    }
}

// MARK: - UIContextMenuInteractionDelegate
extension HomePhotoImageView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { _ in
                let updateAction = UIAction(title: "변경", image: UIImage(systemName: "photo")) { _ in
                    print("photo")
                }
                return UIMenu(title: "", children: [updateAction])
            })
    }
}
