//
//  LoginViewController.swift
//  Worklist
//
//  Created by Reetesh Kumar on 10/22/18.
//  Copyright © 2018 Reetesh Kumar. All rights reserved.
//

import UIKit

extension UIView {
    func roundCornersWithLayerMask(cornerRadii: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    } }

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField?
    @IBOutlet weak var txtPassword: UITextField?
    @IBOutlet weak var topView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtUserName?.setBottomBorder()
        txtPassword?.setBottomBorder()
        
        topView?.roundCornersWithLayerMask(cornerRadii: 10,corners: [.topLeft,.topRight])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

