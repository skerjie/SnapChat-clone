//
//  PictureViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 08.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var nextButton: UIButton!
  var imagePicker = UIImagePickerController()
  var uuid = NSUUID().uuidString
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imagePicker.delegate = self
    descriptionTextField.delegate = self
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let image = [UIImagePickerControllerOriginalImage] as! UIImage
    
    imageView.image = image
    imageView.backgroundColor = UIColor.clear // делаем фон белым, чтобы не было видно серого фона после вставки фото
    imagePicker.dismiss(animated: true, completion: nil)
    
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)  // отпускаем клавиатуру тапом в любое мето
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    descriptionTextField.resignFirstResponder() // кнопкой return  клавиатуры можно ее отпустить
    return true
  }
  
  @IBAction func cameraTapped(_ sender: Any) {
    imagePicker.sourceType = .savedPhotosAlbum // нужно в конце заменить на .camera, пока для теста так
    imagePicker.allowsEditing = false // зарещаем редактирование
    present(imagePicker, animated: true, completion: nil)
    
  }
  
  @IBAction func nextTapped(_ sender: Any) {
    
    nextButton.isEnabled = false
    let imagesFolder = FIRStorage.storage().reference().child("images")
    let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)! //UIImagePNGRepresentation(imageView.image!)!
    // NSUUID().uuidString // позволяет получать уникальный ID для разных имен изображений
    
    imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
      print("We tryed to upload")
      if error != nil {
        print("We had an error \(error?.localizedDescription)")
      } else {
        
        print(metadata!.downloadURL()!)
        
        self.performSegue(withIdentifier: "selectUserSegue", sender: metadata!.downloadURL()!.absoluteString)
      }
    })
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let dvc = segue.destination as! SelectUserViewController
    dvc.descr = descriptionTextField.text!
    dvc.imageURL = sender as! String
    dvc.uuid = uuid
    
  }
}
