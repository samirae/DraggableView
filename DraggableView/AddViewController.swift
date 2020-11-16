//
//  AddViewController.swift
//  DraggableView
//
//  Created by Samira Ekrami on 11/16/20.
//


import UIKit
import SnapKit

class AddViewController: UIViewController {
    
    var pointOrigin: CGPoint?
    
    let topView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    
    let dragLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3.0
        return view
    }()
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else {
        // ignore upward drags
        return }

        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state != .ended {
            return
        }
        
        let velocity = sender.velocity(in: view)
        if velocity.y >= 1000 {
            self.dismiss(animated: true, completion: nil)
        } else {
          // initial state
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 500)
            }
        }
        
      }
    
    override func viewDidLayoutSubviews() {
        if pointOrigin == nil{
            pointOrigin = self.view.frame.origin
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    func setupViews() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        topView.addGestureRecognizer(panGesture)
        
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(48)
        }
        topView.addSubview(dragLine)
        dragLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(5)
            make.width.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
}
