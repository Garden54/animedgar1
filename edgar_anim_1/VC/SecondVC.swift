//
//  SecondVC.swift
//  edgar_anim_1
//
//  Created by Ludovic Jardiné on 10/01/2021.
//

import UIKit

class SecondVC: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var loadingBar: UIProgressView!
    @IBOutlet weak var superMamanTitle: UILabel!  // to hide
    @IBOutlet weak var btn1: UIButton! // to hide
    @IBOutlet weak var btn2: UIButton! // to hide
    @IBOutlet weak var scrollV: UIScrollView!
    @IBOutlet weak var addComment: UILabel!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var operateurLabel: UILabel!
    @IBOutlet weak var contourView: UIView!
    @IBOutlet weak var webBar: UIView!
    
    var timeTextBeforeSetting: String!
    
    
    deinit {
        print("deinit VC2")
    }
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollV.delegate = self
        timeText.text = timeTextBeforeSetting
        setupToolBar()
        setupTouchGesture()
        setupLayout()
        
        operateurLabel.text = "Orange"
        contourView.layer.cornerRadius = 10
        
    }
    
    
    //
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: K.firstDurationLoadingBar) {
            self.loadingBar.setProgress(K.firstPercentLoadingBar, animated: true)
        } completion: { _ in
            UIView.animate(withDuration: K.secondDurationLoadingBar) {
                self.loadingBar.setProgress(1, animated: true)
            } completion: { _ in
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + K.firstDurationLoadingBar, execute: {
            self.btn1.isHidden = false
            self.btn2.isHidden = false
            self.superMamanTitle.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + K.secondDurationLoadingBar, execute: {
            self.scrollV.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + K.firstDurationLoadingBar + K.secondDurationLoadingBar, execute: {
        //    self.loadingBar.isHidden = true
            self.loadingBar.setProgress(0, animated: false)
        })
    }
    
    //
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    //
    func setupToolBar() {
     //   let btn1 = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: nil)
//        let btn2 = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: self, action: nil)
//        let btn3 = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
//        let btn4 = UIBarButtonItem(image: UIImage(systemName: "book"), style: .plain, target: self, action: nil)
//        let btn5 = UIBarButtonItem(image: UIImage(systemName: "square.on.square"), style: .plain, target: self, action: nil)
        let btn1 = UIBarButtonItem(image: UIImage(named: "SF_chevron_left_square_fill"), style: .plain, target: self, action: nil)
        let btn2 = UIBarButtonItem(image: UIImage(named: "SF_chevron_right_square_fill"), style: .plain, target: self, action: nil)
        let btn3 = UIBarButtonItem(image: UIImage(named: "SF_square_and_arrow_up_on_square"), style: .plain, target: self, action: nil)
        let btn4 = UIBarButtonItem(image: UIImage(named: "SF_book_fill"), style: .plain, target: self, action: nil)
        let btn5 = UIBarButtonItem(image: UIImage(named: "SF_square_on_square"), style: .plain, target: self, action: nil)
        
        let array = [btn1, btn2, btn3, btn4, btn5]
        array.forEach { (btn) in
            btn.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -5, right: 0)
        }
        let blankSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        btn1.isEnabled = false
        btn2.isEnabled = false
        self.toolbarItems = [btn1, blankSpace, btn2, blankSpace, btn3, blankSpace, btn4, blankSpace, btn5]
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    //
    func setupTouchGesture() {
        let resetTaps = UITapGestureRecognizer(target: self, action: #selector(didResetTaps))
        resetTaps.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(resetTaps)
    }
    
    //
    @objc func didResetTaps() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setupLayout() {
        addComment.layer.cornerRadius = 5
        addComment.clipsToBounds = true
    }
    
    //
    @IBAction func backToTop(_ sender: UIButton) {
        scrollV.setContentOffset(.zero, animated: true)
    }
    
    // To show / hide toolbar on scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            navigationController?.setToolbarHidden(false, animated: true)
        } else {
            navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    
    
} // ---
