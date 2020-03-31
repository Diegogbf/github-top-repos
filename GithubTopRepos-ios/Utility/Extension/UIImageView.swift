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
        image = nil
        
        let indicator = UIActivityIndicatorView()
        addSubview(indicator)
        indicator.snp.makeConstraints { $0.center.equalToSuperview() }
        indicator.startAnimating()
        
        if let stringUrl = url, let url = URL(string: stringUrl) {
            getImagetData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
