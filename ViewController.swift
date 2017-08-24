//
//  ViewController.swift
//  PhotoChooseExtension
//
//  Created by Nitin Bhatia on 24/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate  {
    var cp : ChoosePicture!
    var apiHandeler : ApiHandler!

    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cp = ChoosePicture()
        apiHandeler = ApiHandler()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnChooseImage(_ sender: Any) {
        let vc : UIViewController = self
        
        cp.openActions(vc: vc,target: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,                           didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.view.showLoad()
            dismiss(animated:true, completion: { (finished)  in
                
                self.profileImageView.image = pickedImage
                
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

