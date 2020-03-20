//
//  UIImage+DownloadImage.swift
//  Zap Challenge
//
//  Created by Diego Gomes on 21/01/20.
//  Copyright © 2020 Diego Gomes. All rights reserved.
//

import UIKit

extension UIImageView {
    private func getImagetData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(url: String?) {
        if let stringUrl = url, let url = URL(string: stringUrl) {
            getImagetData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
