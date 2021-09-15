//
//  File.swift
//
//
//  Created by admin on 2021/3/2.
//
import UIKit
import CoreMotion

extension UIImage {
    func clips() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        path.addClip()
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let clipsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clipsImage
    }
}

class JQEmitterButton: UIButton, CAAnimationDelegate {
//    private var itemWH = 30
    private lazy var emitterSuperView: UIView? = {
        
        return UIViewController.getTopVC()?.view
    }()
    private  var animator: UIDynamicAnimator?
    private lazy var gravityBeahvior: UIGravityBehavior = {
        let v = UIGravityBehavior()
        return v
    }()
    private lazy var collisionBehavior: UICollisionBehavior = {
        let v = UICollisionBehavior()
        v.translatesReferenceBoundsIntoBoundary = true
        return v
    }()
    private lazy var dynamicItemBehavior: UIDynamicItemBehavior = {
        let v = UIDynamicItemBehavior()
        v.allowsRotation = true//允许旋转
        v.elasticity = 0.5//弹性
        v.friction = 0//摩擦力
        v.resistance = 0//阻力
        return v
    }()
    private lazy var motionManager: CMMotionManager = {
        let v = CMMotionManager()
        let queue = OperationQueue()
        v.startDeviceMotionUpdates(to: queue) { [weak self] (motion, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self?.gravityBeahvior.gravityDirection = CGVector(dx: motion?.gravity.x ?? 0.0, dy: -(motion?.gravity.y ?? 0.0))
                }
            }
        }
        return v
    }()
    
    // MARK: - Pubilc property
    var blingImage: UIImage?
    
    // MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        let longPan = UILongPressGestureRecognizer(target: self, action: #selector(self.longPanBegin(_:)))
        self.addGestureRecognizer(longPan)
        setup()
    }
    @objc private func longPanBegin(_ pan: UILongPressGestureRecognizer) {
        if pan.state == .began {
            self.perform(#selector(longPan), with: nil, afterDelay: 0.03)
        }
        if pan.state == .ended || pan.state == .cancelled || pan.state == .failed {
            longPanEnd()
        }
    }
    @objc private func longPanEnd() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(longPan), object: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    @objc private func longPan() {
        self.perform(#selector(longPan), with: nil, afterDelay: 0.03)
        buttonClick()
    }
    fileprivate func setup() {
        addTarget(self, action: #selector(JQEmitterButton.buttonClick), for: .touchUpInside)
    }
    
    // MARK: - Events
    
    @objc fileprivate func buttonClick() {
        item1()
        item2()
        item3()
        item4()
        item5()
    }
   
    /// 竖直方向
    private func item1() {
        let endPointX = jlArc4random(min:Int(self.bounds.size.width * 0.5) - 10, max: Int(self.bounds.size.width * 0.5) + 10)
        let endPointY = jlArc4random(min: 80, max: 150)
        let controlPoint2X =  jlArc4random(min: endPointX - 50, max: endPointX + 50)
        let controlPoint2Y = jlArc4random(min: Int(Double(endPointY) * 0.5), max: Int(Double(endPointY) * 0.5))
        let endPoint = CGPoint(x: endPointX, y: -(endPointY))
        let controlPoint2 = CGPoint(x: controlPoint2X , y: -controlPoint2Y)
        let startPoint =  CGPoint(x: bounds.width/2 , y: 0)
        createAnitem(startPoint: startPoint, endPoint: endPoint, controlPoint2: controlPoint2)
    }
    /// 右边弧度
    private func item2() {
        
        let endPointX = jlArc4random(min:150 - 30, max: 150 + 30)
        let endPointY = jlArc4random(min: 0 - 50, max: 0 + 50)
        
        let endPoint = CGPoint(x: endPointX, y: endPointY)
        let controlPoint2X =  jlArc4random(min: endPointX - 50, max: endPointX - 10)
        let controlPoint2Y = jlArc4random(min: endPointY - 50, max:  endPointY)
        let controlPoint2 = CGPoint(x: controlPoint2X, y: controlPoint2Y)
        let startPoint =  CGPoint(x: bounds.width/2 + 10 , y: 0)
        createAnitem(startPoint: startPoint, endPoint: endPoint, controlPoint2: controlPoint2)
    }
    /// 左边弧度
    private func item3() {
        
        let endPointX = jlArc4random(min:100 - 30, max: 100 + 30)
        let endPointY = jlArc4random(min: 0 - 50, max: 0 + 50)
        
        let endPoint = CGPoint(x: -endPointX, y: endPointY)
        let controlPoint2X =  jlArc4random(min: endPointX - 50, max: endPointX - 10)
        let controlPoint2Y = jlArc4random(min: endPointY - 50, max:  endPointY)
        let controlPoint2 = CGPoint(x: -controlPoint2X, y: controlPoint2Y)
        let startPoint =  CGPoint(x: bounds.width/2 - 10 , y: 0)
        createAnitem(startPoint: startPoint, endPoint: endPoint, controlPoint2: controlPoint2)
        
    }
    /// 右边弧度
    private func item4() {
        
        let endPointX = jlArc4random(min:150 - 60, max: 150 - 30)
        let endPointY = jlArc4random(min: 0 - 100, max: 0 - 70)
        
        let endPoint = CGPoint(x: endPointX, y: endPointY)
        let controlPoint2X =  jlArc4random(min: endPointX - 50, max: endPointX - 10)
        let controlPoint2Y = jlArc4random(min: endPointY - 50, max:  endPointY)
        let controlPoint2 = CGPoint(x: controlPoint2X, y: controlPoint2Y)
        let startPoint =  CGPoint(x: bounds.width/2 + 5 , y: 0)
        createAnitem(startPoint: startPoint, endPoint: endPoint, controlPoint2: controlPoint2)
        
    }
    /// 左边弧度
    private func item5() {
        
        let endPointX = jlArc4random(min:100 - 60, max: 100 - 30)
        let endPointY = jlArc4random(min: 0 - 100, max: 0 - 70)
        
        let endPoint = CGPoint(x: -endPointX, y: endPointY)
        let controlPoint2X =  jlArc4random(min: endPointX - 50, max: endPointX - 10)
        let controlPoint2Y = jlArc4random(min: endPointY - 50, max:  endPointY)
        let controlPoint2 = CGPoint(x: -controlPoint2X, y: controlPoint2Y)
        let startPoint =  CGPoint(x: bounds.width/2 - 5 , y: 0)
        createAnitem(startPoint: startPoint, endPoint: endPoint, controlPoint2: controlPoint2)
        
    }
    private func createAnitem(startPoint: CGPoint, endPoint: CGPoint, controlPoint2: CGPoint) {
        let blingImageView = JLContentItemView(image: UIImage(named: "em_click_\(arc4random_uniform(5) + 1)"))
        blingImageView.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        blingImageView.center = CGPoint(x: bounds.width/2, y: 0)
        addSubview(blingImageView)
        
        /// 首次上升
        let upDuration = 0.5
        let animation = CAKeyframeAnimation(keyPath: "position")
        let path = UIBezierPath()
        let startPoint = startPoint
        path.move(to: startPoint)
        let controlPoint1X = startPoint.x
        let controlPoint1Y = startPoint.y - 50
        let controlPoint1 = CGPoint(x: controlPoint1X , y: controlPoint1Y)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        //path.addQuadCurve(to: endPoint, controlPoint: controlPoint2)
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)]
        animation.path = path.cgPath
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        // 缩小
        blingImageView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)


        /// 动画组
        // 放大
        let animationscale = CABasicAnimation.init(keyPath: "transform.scale")
        animationscale.toValue = NSNumber.init(value: 1.0)
        
        // 旋转
        let rotation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber.init(value: Double.pi * 2)
        rotation.duration = upDuration
        
        let group = CAAnimationGroup()
        group.animations = [animation, animationscale,rotation]
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.duration = upDuration
        group.repeatCount = 1
        group.delegate = self
        
        blingImageView.layer.add(group, forKey: "scaleAnimation")
        
        // 重力
        DispatchQueue.main.asyncAfter(deadline: .now() + upDuration) {
            self.endAnimation(gravityBallView: blingImageView, endPoint: endPoint)
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + upDuration) {
//            self.bubbleAnimation(start: endPoint, isAuto: false, bubble: blingImageView)
//        }
        
    }
    func endAnimation(gravityBallView: JLContentItemView, endPoint: CGPoint) {
        if animator == nil {
            animator = UIDynamicAnimator(referenceView: emitterSuperView ?? UIView())
            print(motionManager)
            animator?.addBehavior(gravityBeahvior)
            animator?.addBehavior(collisionBehavior)
            animator?.addBehavior(dynamicItemBehavior)
        }
        gravityBallView.alpha = 0.01
        gravityBallView.removeFromSuperview()
        let iv = JLContentItemView(image: gravityBallView.image)
        self.emitterSuperView?.addSubview(iv)
        let center = self.convert(endPoint, to: self.emitterSuperView)
        iv.frame.origin = CGPoint(x: center.x - 15, y: center.y - 15)
        iv.frame.size = CGSize(width: gravityBallView.bounds.width, height: gravityBallView.bounds.height)
        gravityBeahvior.addItem(iv)
        collisionBehavior.addItem(iv)
        dynamicItemBehavior.addItem(iv)
    }
    /// 上升动画
    ///
    /// - Parameters:
    ///   - start: 起点
    ///   - isAuto:
    fileprivate func bubbleAnimation(start: CGPoint, isAuto: Bool,bubble: UIImageView ) {
        let path = UIBezierPath()
        path.move(to: start)
        let endPointX: CGFloat = bounds.width/2+CGFloat(arc4random_uniform(80))-40
        let endPointY: CGFloat = -400
        let endPoint = CGPoint(x: endPointX, y: endPointY)
        if isAuto {
            path.addCurve(to: endPoint, controlPoint1: CGPoint(x: CGFloat(arc4random_uniform(80))-40, y: endPointY/3.0), controlPoint2: CGPoint(x: 0, y: endPointY*2/3.0))
        } else {
            path.addCurve(to: endPoint, controlPoint1: CGPoint(x: start.x, y: endPointY/3.0), controlPoint2: CGPoint(x: 0, y: endPointY*2/3.0))
        }
        if isAuto {
            bubble.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
            UIView.animate(withDuration: 0.1, animations: {
                bubble.transform = CGAffineTransform(scaleX: 6, y: 6)
            }) { (_) in
            }
        }
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        anim.duration = 2
        anim.repeatCount = 1
        anim.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)]
        anim.isRemovedOnCompletion = true
        bubble.layer.add(anim, forKey: nil)
        layer.addSublayer(bubble.layer)
        
        UIView.animate(withDuration: 1, delay: 1, options: UIView.AnimationOptions.curveLinear, animations: {
            bubble.alpha = 0
        }) { (finished) in
            if finished {
                bubble.removeFromSuperview()
            }
        }
    }
    private func jlArc4random(min: Int = 0, max: Int) -> Int {
        var cha = max-min
        if cha <= 0 {
            cha = 1
        }
        let random = (Int(arc4random()) % cha) + min
        
        return random
    }
    
}
public extension UIViewController{
    //MARK: - 查找顶层控制器、
    /// 获取顶层控制器 根据window
   static func getTopVC() -> UIViewController? {
        let window = UIApplication.shared.keyWindow
        let vc = window?.rootViewController
        return getTopVC(withCurrentVC: vc)
    }
    
    ///根据控制器获取 顶层控制器
   private static func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
        
        if VC == nil {
            print("🌶： 找不到顶层控制器")
            return nil
        }
        
        if let presentVC = VC?.presentedViewController {
            //modal出来的 控制器
            return getTopVC(withCurrentVC: presentVC)
        }
        else if let tabVC = VC as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return getTopVC(withCurrentVC: selectVC)
            }
            return nil
        } else if let naiVC = VC as? UINavigationController {
            // 控制器是 nav
            return getTopVC(withCurrentVC:naiVC.visibleViewController)
        }
        else {
            // 返回顶控制器
            return VC
        }
    }
}
