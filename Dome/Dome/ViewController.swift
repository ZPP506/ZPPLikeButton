//
//  ViewController.swift
//  Dome
//
//  Created by admin on 2021/9/15.
//

import UIKit

class ViewController: UIViewController {
    private lazy var loveBt: JQEmitterButton = {
        let v = JQEmitterButton()
        v.setTitle("0", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 12)
        v.backgroundColor = .red
        v.sizeToFit()
        return  v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(loveBt)
        loveBt.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        
    }


}

