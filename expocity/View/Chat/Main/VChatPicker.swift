import UIKit

class VChatPicker:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        controller.dismiss(animated:true)
        { [weak self] in
            
            self?.display.displayImage(image:image)
        }
    }
}
