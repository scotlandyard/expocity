import Foundation

class MMenuItem
{
    let title:String
    let iconImageOn:String
    let iconImageOff:String
    let index:Int
    
    init(title:String, iconImage:String, index:Int)
    {
        self.title = title
        self.index = index
        iconImageOn = String(format:"%@On", iconImage)
        iconImageOff = String(format:"%@Off", iconImage)
    }
}