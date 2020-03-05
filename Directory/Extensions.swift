//
//  Extensions.swift
//  Directory
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//

import Foundation
import UIKit

// Copied over from previous projects
extension UIImageView {
    func loadImageFrom(url: String?) {
        let userDefaults = UserDefaults.standard

        if let url = url {
            if let data = userDefaults.data(forKey: url) {
                self.image = UIImage(data: data)
            } else {
                let asURL = URL(string: url)
                URLSession.shared.dataTask(with: asURL!) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data)
                            userDefaults.set(data, forKey: url)
                        }
                    }
                }.resume()
            }
        }
    }
    func setColor(_ color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
extension UIView {
    func drawOutline(thick: Float, color: UIColor = .white) {
        self.layer.borderWidth = CGFloat(thick)
        self.layer.borderColor = color.cgColor
    }
}
