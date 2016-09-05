import Foundation

class MMenuItem
{
    let iconImageOn:String
    let iconImageOff:String
    let index:Int
    
    init(iconImage:String, index:Int)
    {
        self.index = index
        iconImageOn = String(format:"%@On", iconImage)
        iconImageOff = String(format:"%@Off", iconImage)
    }
}