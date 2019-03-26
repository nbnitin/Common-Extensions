//
//  ViewController.swift
//  PhotoChooseExtension
//
//  Created by Nitin Bhatia on 24/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,removeDelegate  {
    var cp : ChoosePicture!
    var apiHandeler : ApiHandler!
    var isImageRemoved : Bool!
    var base64String : String!
    @IBOutlet weak var imgProfile: UIImageView!

    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cp = ChoosePicture()
        apiHandeler = ApiHandler()
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        } else {
            print("No! internet is not available.")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func btnChooseImage(_ sender: Any) {
        let vc : UIViewController = self
        
        cp.openActions(vc: vc,target: self)
        
        //If you want remove photo option
        cp.openActions(vc: self, target: self,removePictureOption: true)
    }
    
    func isRemovePressed(success: Bool) {
        if( success ){
            isImageRemoved = true
            base64String = ""
            self.imgProfile.image = #imageLiteral(resourceName: "ic_profile")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,                           didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.view.showLoad()
            dismiss(animated:true, completion: { (finished)  in
                
                self.profileImageView.image = pickedImage
                                                
                 //Mark:- Making image round, to do this make sure image view has equal width and height here in my case its width and height = 100 and make it to clipToBounds true from story board also make it aspect fill
                let square = self.profileImageView.frame.size.width < self.profileImageView.frame.height ? CGSize(width: self.profileImageView.frame.size.width, height: self.profileImageView.frame.size.width) : CGSize(width: self.profileImageView.frame.size.height, height:  self.profileImageView.frame.size.height)

                self.profileImageView.layer.borderWidth = 1
                self.profileImageView.layer.masksToBounds = true
                self.profileImageView.layer.borderColor = UIColor.white.cgColor
                self.profileImageView.layer.cornerRadius = square.width/2
                self.profileImageView.clipsToBounds = true
                
                
                self.view.layoutIfNeeded()
                self.view.hideLoad()
                
            })
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
        
    }
    
    func callApi(){
        //usage of api calling
//        apiHandeler.sendPostRequest(url: <#T##String#>, parameters: <#T##Parameters#>, completionHandler: <#T##([String : AnyObject], Error?) -> Void#>)
    }

}

