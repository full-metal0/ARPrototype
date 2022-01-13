//
//  FirebaseStorageHelper.swift
//  ARPtorotype
//
//  Created by Kaligula on 13.01.2022.
//

import Foundation
import Firebase

class FirebaseStorageHelper {
    static private var cloudStorage = Storage.storage()
    
    // call itself
    class func asyncDownloadToFileSystem(relativePath: String, handler: @escaping (_ fileUrl: URL) -> Void) {
        // Create local filesystem Url
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = docsUrl.appendingPathComponent(relativePath)
        
        // Check if asset is already in the local filesystem, if it is, load that asset and return
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            handler(fileUrl)
            
            return
        }
        
        // Create a reference to the asset
        let storageRef = cloudStorage.reference(withPath: relativePath)
        
        // Download to the local filesystem
        storageRef.write(toFile: fileUrl) { url, error in
            guard let localUrl = url else {
                print("FirebaseStorage: Error downloading file with relativePath: \(relativePath)")
                return
            }
            
            handler(localUrl)
        }.resume()
    }
}
