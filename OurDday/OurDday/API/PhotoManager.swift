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
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageUrl = documentDirectory.appendingPathComponent(imageName)
        
        guard let data = image.pngData() else {
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
            print("이미지 저장 완료")
        } catch {
            print("이미지 저장 실패")
        }
    }
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageUrl = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageUrl.path)
        }
        
        return nil
    }
}
