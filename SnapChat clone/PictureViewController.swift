//
//  PictureViewController.swift
//  SnapChat clone
//
//  Created by Andrei Palonski on 08.11.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var nextButton: UIButton!
  var imagePicker = UIImagePickerController()

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
    
  }
}
