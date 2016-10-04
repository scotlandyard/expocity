import XCTest
@testable import expocity

class TFDatabaseModelUser:XCTestCase
{
    //MARK: -
    
    func testModelJson()
    {
        let name:String = "John Test"
        
        let firebaseUser:FDatabaseModelUser = FDatabaseModelUser(
            name:name)
        
        let json:[String:Any] = firebaseUser.modelJson()
    }
}
