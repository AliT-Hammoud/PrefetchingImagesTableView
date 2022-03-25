//
//  ViewModel.swift
//  PrefetchingDataSource
//
//  Created by Ali Hammoud on 25/03/2022.
//

import Foundation
import UIKit

class ViewModel {
    init() {}
    
    private var cachedImage: UIImage?
    private var isDownloading = false
    private var callBack: ((UIImage?)->())?
    
    func downloadImage(completion: ((UIImage?)->())?) {
        if let image = cachedImage {
            completion?(image)
            return
        }
        
        guard !isDownloading else {
            self.callBack = completion
            return
        }
        isDownloading = true
        
        let size = Int.random(in: 200...350)
        
        guard let url = URL(string: "https://source.unsplash.com/random/\(size)x\(size)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, _ in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.cachedImage = image
                self?.callBack?(image)
                self?.callBack = nil
                completion?(image)
            }
            
        }
        task.resume()
    }
}
