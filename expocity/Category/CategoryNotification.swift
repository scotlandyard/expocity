import Foundation

extension Notification
{
    enum Notifications:String
    {
        case ChatDisplayOptionChanged = "ChatDisplayOptionChanged"
        
        var Value:Notification.Name
        {
            return Notification.Name(rawValue:self.rawValue)
        }
    }
}
