//
//  ViewController.swift
//  edgar_anim_1
//
//  Created by Ludovic Jardiné on 10/01/2021.
//

import UIKit
import PhotosUI

class MenuViewController: UIViewController,
                          UIImagePickerControllerDelegate, UINavigationControllerDelegate
                       //   PHPickerViewControllerDelegate
{
    
    
    @IBOutlet weak var addBackgroundBtn: UIButton!
    @IBOutlet weak var timeText: UILabel!
    
    private var backgroundURL: String?
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
    }


//    // Button to make user choose a background
//    @IBAction func addBackgroundBtnPressed(_ sender: UIButton) {
//        let photoLibrary = PHPhotoLibrary.shared()
//        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
//        configuration.filter = .images
//        let picker = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true, completion: nil)
//    }
    
//    // Photo picker
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        dismiss(animated: true, completion: nil)
//        guard let newPix = results.compactMap(\.assetIdentifier).first else { return }
//        backgroundURL = newPix
//        checkBackgroundStatus()
//    }
    
    
    
    // Button to make user choose a background
    @IBAction func addBackgroundBtnPressed(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // Photo picker
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        dismiss(animated: true, completion: nil)
//        guard let newPix = results.compactMap(\.assetIdentifier).first else { return }
//        backgroundURL = newPix
//        checkBackgroundStatus()
//    }
    
    
    

    let imagePicker = UIImagePickerController()
    let picker = UIImagePickerController()



    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    var storedBG: UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
          //  self.imagePreview.image = image
            storedBG = image
            if storedBG == nil {
                print("no")
            } else {
                print("yes")
            }
        }

        self.picker.dismiss(animated: true, completion: nil)
    }
    
    // Button to make user set time for SecondVC
    @IBAction func setTimeButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Réglage de l'heure", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in textfield.placeholder = "format HH:MM" }
        let okButton = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let tf = alert.textFields?.first else { return }
            guard let text = tf.text, !text.isEmpty else { return }
            self.timeText.text = tf.text
        }
        alert.addAction(UIAlertAction(title: "Annuler", style: .default, handler: nil))
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // To launch animation
    @IBAction func beginAnimation(_ sender: UIButton) {
        performSegue(withIdentifier: "1to2", sender: self)
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "1to2" {
            let destinationVC = segue.destination as! FirstVC
            destinationVC.backgroundURL = backgroundURL
            destinationVC.storedBG = storedBG
            destinationVC.timeText = timeText.text
        }
    }
    
    // Checking Authorizations
    func checkAuth() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: break
        case .denied: break
        case .notDetermined: PHPhotoLibrary.requestAuthorization { (_) in
            DispatchQueue.main.async {
                self.checkAuth()
            }
        }
        case .restricted: break
        default: break
        }
    }
    
    

} // ---
