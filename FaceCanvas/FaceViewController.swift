//
//  FaceViewController.swift
//  FaceCanvas
//
//  Created by Dang Quoc Huy on 8/2/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        switch sender.state {
        case .Began:
            trayOriginalCenter = trayView.center
            
        case .Changed:
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        case .Ended:
            break
            
        default:
            break
        }
    }
}
