import XCTest
@testable import expocity

class TFDatabaseModelUser:XCTestCase
{
    private let kSnapshot:[String:Any] = [
        "created":1475541121.581116,
        "name":"John Test",
        "rooms":[
            "12345",
            "67890",
            "34567"
        ]
    ]
    
    //MARK: -
    
    func testModelJson()
    {
        let name:String = kSnapshot["name"] as! String
        let nameKey:String = FDatabaseModelUser.Property.name.rawValue
        let createdKey:String = FDatabaseModelUser.Property.created.rawValue
        let roomsKey:String = FDatabaseModelUser.Property.rooms.rawValue
        
        let firebaseUser:FDatabaseModelUser = FDatabaseModelUser(
            name:name)
        
        let json:[String:Any] = firebaseUser.modelJson()
        let userName:String? = json[nameKey] as? String
        let userCreated:TimeInterval? = json[createdKey] as? TimeInterval
        let userRooms:[String]? = json[roomsKey] as? [String]
        
        XCTAssertTrue(name == userName, "Invalid name")
        XCTAssertNotNil(userCreated, "Not storing user creation timestamp")
        XCTAssertGreaterThan(userCreated!, 1, "Invalid timestamp")
        XCTAssertNotNil(userRooms, "Invalid user rooms")
    }
    
    func testSnapshot()
    {
        let snapshotName:String = kSnapshot["name"] as! String
        let snapshotCreated:TimeInterval = kSnapshot["created"] as! TimeInterval
        let snapshotRooms:[String] = kSnapshot["rooms"] as! [String]
        let snapshotCountRooms:Int = snapshotRooms.count
        let snapshotLastRoomId:String = snapshotRooms.last!
        
        let firebaseUser:FDatabaseModelUser = FDatabaseModelUser(
            snapshot:kSnapshot)

        let userName:String = firebaseUser.name
        let userCreated:TimeInterval = firebaseUser.created
        let userRooms:[String] = firebaseUser.rooms
        let userCountRooms:Int = userRooms.count
        let userLastRoomId:String = userRooms.last!
        
        XCTAssertTrue(userName == snapshotName, "Invalid name")
        XCTAssertTrue(userCreated == snapshotCreated, "Invalid created timestamp")
        XCTAssertTrue(snapshotCountRooms == userCountRooms, "Invalid rooms")
        XCTAssertEqual(snapshotLastRoomId, userLastRoomId, "Invalid room id")
    }
}
