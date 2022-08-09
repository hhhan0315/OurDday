//
//  PhotoManager.swift
//  OurDday
//
//  Created by rae on 2022/03/10.
//

import Foundation
import UIKit

final class PhotoManager {
    static let shared = PhotoManager()
    
    func saveImageToDocumentDirectory(imageFileType: ImageFileType, image: UIImage) {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurDday") else { return }
                
        let imageURL = containerURL.appendingPathComponent(imageFileType.rawValue)
        
        guard let data = image.jpegData(compressionQuality: 1) else {
            return
        }
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
            } catch {
            }
        }
        
        do {
            try data.write(to: imageURL)
            
            switch imageFileType {
            case .photo:
                LocalStorageManager.shared.setPhotoURL(url: imageURL)
            case .profileFirst:
                LocalStorageManager.shared.setProfileFirstURL(url: imageURL)
            case .profileSecond:
                LocalStorageManager.shared.setProfileSecondURL(url: imageURL)
            }
        } catch {
            print("이미지 저장 실패")
        }
    }
    
    func removeImageFromDocumentDirectory(imageFileType: ImageFileType) {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurDday") else {
            return
        }
        let imageUrl = containerURL.appendingPathComponent(imageFileType.rawValue)
        
        if FileManager.default.fileExists(atPath: imageUrl.path) {
            do {
                try FileManager.default.removeItem(at: imageUrl)
            } catch {
                print("이미지 삭제 실패")
            }
        }
    }
}
