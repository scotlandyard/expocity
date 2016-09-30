import Foundation

extension Notification
{
    enum Notifications:String
    {
        case chatDisplayOptionChanged = "chatDisplayOptionChanged"
        case sessionLoaded = "sessionLoaded"
        
        var Value:Notification.Name
        {
            return Notification.Name(rawValue:self.rawValue)
        }
    }
}
