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
    var cloneFaceOriginalCenter: CGPoint!
    var cloneFaceOriginalTransform: CGAffineTransform!

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
            // duplicate face
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // add to view controller
            view.addSubview(newlyCreatedFace)
            
            // set position according to view controller
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.x += trayView.frame.origin.x
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            // keep original point for later calculation
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            // add pan gesture for new image
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FaceViewController.onCloneFacePanGesture(_:)))
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
        case .Changed:
            let translation = sender.translationInView(view)
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x,
                                              y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        default:
            break
        }
    }
    
    func onCloneFacePanGesture(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            cloneFaceOriginalCenter = sender.view!.center
            cloneFaceOriginalTransform = sender.view!.transform
            sender.view!.transform = CGAffineTransformScale(sender.view!.transform, 1.2, 1.2)
            
        case .Changed:
            let translation = sender.translationInView(view)
            sender.view!.center = CGPoint(x: cloneFaceOriginalCenter.x + translation.x,
                                          y: cloneFaceOriginalCenter.y + translation.y)
            
        case .Ended:
            sender.view!.transform = cloneFaceOriginalTransform
            
        default:
            break
        }
    }
}
