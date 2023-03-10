//
//  UIImageView+ResizeWithImage.swift
//  CatsAndSomeMoreCats
//
//  Created by Alma Hodzic on 10.01.23.
//

import UIKit

extension UIImageView {
    var sizeBasedOnImageWithAspectFit: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale = bounds.width / image.size.width

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
