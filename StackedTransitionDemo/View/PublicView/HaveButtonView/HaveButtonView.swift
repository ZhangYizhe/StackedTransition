//
//  HaveButtonView.swift
//  sandwichTransitionDemo
//
//  Created by 张艺哲 on 2019/5/31.
//  Copyright © 2019 张艺哲. All rights reserved.
//

import UIKit

class HaveButtonView: UIView {
    
    
    
    var button : UIButton? = nil
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if button == nil {
            button = UIButton(type: .system)
            self.addSubview(button ?? UIButton())
            button?.setTitle("点击转场", for: .normal)
            button?.addTarget(self, action: #selector(btnTap(_:)), for: .touchUpInside)
            setNeedsLayout()
        }
    }
    
    var btnTapCompletion = {() in}
    @objc func btnTap(_ sender: UIButton) {
        btnTapCompletion()
    }
    
    override func layoutSubviews() {
        
        button?.snp.remakeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        
        super.layoutSubviews()
    }
}
