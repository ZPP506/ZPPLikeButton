//
//  File.swift
//
//
//  Created by admin on 2021/3/2.
//

import UIKit

class JLContentItemView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 15
        configSnpOfSubview()
        //        rotateAnimation()
        
    }
    func rotateAnimation() {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber.init(value: Double.pi)
        animation.duration = 0.1
        animation.repeatCount = 1100 //无限大重复次数
        self.layer.add(animation, forKey: "rotateAnimation")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("销毁")
    }
    private func configSnpOfSubview() {
        
        
    }
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType{
        
        return .ellipse
    }
    
}
