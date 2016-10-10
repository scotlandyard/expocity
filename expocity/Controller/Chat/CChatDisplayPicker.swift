import UIKit

class CChatDisplayPicker:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    weak var controller:CChat!
    
    convenience init(controller:CChat)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.photoLibrary
        delegate = self
        allowsEditing = false
        self.controller = controller
    }
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        controller.dismiss(animated:true)
        { [weak self] in
            
            self?.controller.viewChat.display.displayImage(image:image)
        }
    }
}
