//
//  ViewController.swift
//  DraggableView
//
//  Created by Samira Ekrami on 11/16/20.
//

import UIKit
class ViewController : UIViewController {
    
    let actionButton: UIButton = {
        let view = UIButton()
        view.setTitle("Add", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    @IBAction func filterButtonTapped() {
         let filterVC = AddViewController()
         filterVC.modalPresentationStyle = .custom
         filterVC.transitioningDelegate = self
         self.present(filterVC, animated: true, completion: nil)
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        actionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterButtonTapped)))
       
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
