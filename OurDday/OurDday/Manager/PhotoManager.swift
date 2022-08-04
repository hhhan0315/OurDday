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
    
    func saveImageToDocumentDirectory(imageName: String = "homeBackGroundImage", image: UIImage) {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurDday") else { return }
        
        let imageUrl = containerURL.appendingPathComponent(imageName)
        
        guard let data = image.jpegData(compressionQuality: 1) else {
            print("압축 실패")
            return
        }
        
        if FileManager.default.fileExists(atPath: imageUrl.path) {
            do {
                try FileManager.default.removeItem(at: imageUrl)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제 실패")
            }
        }
        
        do {
            try data.write(to: imageUrl)
            LocalStorageManager.shared.setImageUrl(url: imageUrl)
            print("이미지 저장 완료")
        } catch {
            print("이미지 저장 실패")
        }
    }
    
//    func loadImageFromDocumentDirectory(imageName: String = "homeBackGroundImage") -> UIImage? {
//        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurDday") else {
//            return nil
//        }
//        let imageUrl = containerURL.appendingPathComponent(imageName)
//        
//        if let image = UIImage(contentsOfFile: imageUrl.path) {
//            return image
//        }
//        
//        return nil
//    }
    
    func removeImageFromDocumentDirectory(imageName: String = "homeBackGroundImage") {
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurDday") else {
            return
        }
        let imageUrl = containerURL.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: imageUrl.path) {
            do {
                try FileManager.default.removeItem(at: imageUrl)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제 실패")
            }
        }
    }
}
