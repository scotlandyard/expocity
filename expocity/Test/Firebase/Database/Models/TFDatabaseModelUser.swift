import XCTest
@testable import expocity

class TFDatabaseModelUser:XCTestCase
{
    //MARK: -
    
    func testModelJson()
    {
        let name:String = "John Test"
        let nameKey:String = FDatabaseModelUser.Property.name.rawValue
        let createdKey:String = FDatabaseModelUser.Property.created.rawValue
        let roomsKey:String = FDatabaseModelUser.Property.rooms.rawValue
        
        let firebaseUser:FDatabaseModelUser = FDatabaseModelUser(
            name:name)
        
        let json:[String:Any] = firebaseUser.modelJson()
        let userName:String? = json[nameKey] as? String
        let userCreated:Int? = json[createdKey] as? Int
        let userRooms:[String]? = json[roomsKey] as? [String]
        
        XCTAssertTrue(name == userName, "Invalid name")
        XCTAssertNotNil(userCreated, "Not storing user creation timestamp")
        XCTAssertGreaterThan(userCreated!, 1, "Invalid timestamp")
        XCTAssertNotNil(userRooms, "Invalid user rooms")
    }
}
