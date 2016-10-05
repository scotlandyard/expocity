import Foundation
import Firebase

class FMain
{
    static let sharedInstance:FMain = FMain()
    let database:FDatabase
    
    private init()
    {
        FIRApp.configure()
        database = FDatabase()
    }
    
    //MARK: public
    
    func load()
    {
    }
}
