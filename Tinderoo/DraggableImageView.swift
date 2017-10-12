//
//  DraggableImageView.swift
//  Tinderoo
//
//  Created by Kavita Gaitonde on 10/11/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi}
}

class DraggableImageView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBInspectable
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    fileprivate let centerOffScreen: CGFloat = 1000
    fileprivate let rotationScale: CGFloat = 20.0
    var pictureCentre : CGPoint!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self)
        let translation = sender.translation(in: self)
        //let velocity = sender.velocity(in: self)
        
        if sender.state == .began {
            print("Image Pan began at: \(point)")
            self.pictureCentre = self.imageView.center
        } else if sender.state == .changed {
            print("Image changed at: \(point)")
            
            if translation.x > 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.center.x = 1000
                })
            } else if translation.x < -50 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.center.x = -1000
                })
            } else {
                self.imageView.center = CGPoint(x: self.pictureCentre.x + translation.x, y: self.pictureCentre.y)
                
                if point.y <= pictureCentre.y {
                    transform = CGAffineTransform(rotationAngle: (translation.x / rotationScale).degreesToRadians)
                } else {
                    transform = CGAffineTransform(rotationAngle: (-translation.x / rotationScale).degreesToRadians)
                }
            }
         } else if sender.state == .ended {
            print("Image ended at: \(point)")
            
            UIView.animate(withDuration: 0.5, animations: {
                    self.imageView.center = self.pictureCentre
                    self.transform = .identity
                })
        }
    }
}
