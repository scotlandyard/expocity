import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let database:FDatabase
    
    private init()
    {
        FIRApp.configure()
        FIRConfiguration.sharedInstance().logLevel = FIRLogLevel.error
        database = FDatabase()
    }
}
