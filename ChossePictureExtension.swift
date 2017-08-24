//
//  ChooseImageExtension.swift
//  EazyCarCare
//
//  Created by Nitin Bhatia on 28/04/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import Foundation
import UIKit


enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}

class ChoosePicture :UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func openActions(vc : UIViewController,target : Any){
        
        
        let vc : UIViewController = vc
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openGallery(vc: vc,target: target)
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openCamera(vc: vc,target: target)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(galleryAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(cancelAction)
        
        
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: break
        // It's an iPhone
        case .pad:
            // It's an iPad
            optionMenu.popoverPresentationController?.sourceView = vc.view
            optionMenu.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
            optionMenu.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            break
        case .unspecified: break
        // Uh, oh! What could it be?
        default:break
        }
        
        // 5
        vc.present(optionMenu, animated: true, completion: nil)
        
        
        
    }
    
    func openGallery(vc : UIViewController,target : Any){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = target as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        imagePicker.allowsEditing = true
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(vc : UIViewController,target : Any){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = target as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            vc.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,                           didFinishPickingMediaWithInfo info: [String : Any])
    {
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func convertToBase64(image : UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 0.6)
        
        return (imageData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0)))!
    }
    
}

