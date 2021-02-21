//
//  firstVC.swift
//  edgar_anim_1
//
//  Created by Ludovic Jardiné on 10/01/2021.
//

import UIKit
import Photos


class FirstVC: UIViewController {
    
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var viewForSelectionAnimation: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    enum State {
        case first, second
    }
    
    var currentState: State = .first

    var backgroundURL: String?
    var storedBG:  UIImage?
    var timeText: String!
    
    
    deinit {
        print("deinit VC1")
    }
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configBigView()
        setupBlur()
        setupTouchGesture()
      //  loadBackGround()//
        loadUIimage()
    }
    
    
    //
    func configBigView() {
        bigView.layer.cornerRadius = 20
        bigView.isHidden = true
    }

    //
    func setupBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bigView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        bigView.addSubview(blurEffectView)
        bigView.sendSubviewToBack(blurEffectView)
    }
    
    //
    func setupTouchGesture() {
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(didOneTap))
        oneTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(oneTap)
    }
    //
    @objc func didOneTap() {
        if currentState == .first {
            bigView.isHidden = false
            growAnimation()
            currentState = .second
        } else if currentState == .second {
            selectionAnimation()
        }
    }
    
    //
    func loadBackGround() {
        guard backgroundURL != nil else { return }
        guard let asset = Assets().getAssetsFromURL([backgroundURL!]).firstObject else { return }
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: backgroundImageView.layer.frame.size,
                                              contentMode: .aspectFit,
                                              options: PHImageRequestOptions()) { (image, _) in
            self.backgroundImageView.image = image
        }
    }
    func loadUIimage() {
        guard storedBG != nil else { return }
        backgroundImageView.image = storedBG
       
        }
    
    
    //
    func growAnimation() {
        self.bigView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: K.growAnimation, animations: {
            self.bigView.transform = CGAffineTransform.identity
        })
        
        self.bigView.transform = CGAffineTransform(translationX: 0, y: 1000)
        UIView.animate(withDuration: K.growAnimation, animations: {
            self.bigView.transform = CGAffineTransform.identity
        })
    }
    
    //
    func selectionAnimation() {
        UIView.animate(withDuration: K.selectionDuration) {
            self.viewForSelectionAnimation.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: K.selectionAlpha).cgColor
        } completion: { (true) in
            UIView.animate(withDuration: K.selectionDuration) {
                self.viewForSelectionAnimation.layer.backgroundColor = UIColor.clear.cgColor
            } completion: { (true) in
                self.performSegue(withIdentifier: "2to3", sender: self)
            }
        }
    }
    
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "2to3" {
            let destinationVC = segue.destination as! SecondVC
            destinationVC.timeTextBeforeSetting = timeText
        }
    }
    
    
    
} // ---



