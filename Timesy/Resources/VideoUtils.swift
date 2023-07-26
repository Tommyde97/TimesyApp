//
//  VideoUtils.swift
//  Timesy
//
//  Created by Tomas D. De Andrade Gomes on 7/25/23.
//

//import AVFoundation
//import UIKit
//import Foundation
//
//class VideoUtils {
//    
//    static func generateThumbnail(url: URL, completion: @escaping (UIImage?) -> Void) {
//        DispatchQueue.global().async {
//            let asset = AVAsset(url: url)
//            let imageGenerator = AVAssetImageGenerator(asset: asset)
//            imageGenerator.appliesPreferredTrackTransform = true
//            
//            let time = CMTime(seconds: 1, preferredTimescale: 60) // Get thumbnail at 1 second
//            do {
//                
//                let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//                let thumbnail = UIImage(cgImage: cgImage)
//                DispatchQueue.main.async {
//                    completion(thumbnail)
//                }
//            } catch {
//                print("Error generating thumbnail: \(error)")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            }
//        }
//    }
//}
