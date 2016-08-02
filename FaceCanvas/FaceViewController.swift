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
    var trayOpenPoint: CGPoint!
    var trayClosedPoint: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()

        trayOpenPoint = trayView.center
        trayClosedPoint = CGPoint(x: trayOpenPoint.x, y: trayOpenPoint.y + trayView.frame.height - 25)
        trayView.center = trayClosedPoint
    }

    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            trayOriginalCenter = trayView.center
            
        case .Changed:
            let translation = sender.translationInView(view)
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        case .Ended:
            let velocity = sender.velocityInView(view)
            var point: CGPoint
            // go down
            if velocity.y > 0 {
                point = trayClosedPoint
            // go up
            } else {
                point = trayOpenPoint
            }
            UIView.animateWithDuration(0.6, animations: {
                self.trayView.center = point
            })
            
        default:
            break
        }
    }
    
    @IBAction func onFacePanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.x += trayView.frame.origin.x
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        case .Changed:
            let translation = sender.translationInView(view)
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x,
                                              y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        default:
            break
        }
    }
    
}
