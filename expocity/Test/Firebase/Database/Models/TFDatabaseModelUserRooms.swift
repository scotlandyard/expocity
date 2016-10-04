import XCTest
@testable import expocity

class TFDatabaseModelUserRooms:XCTestCase
{
    private let kSnapshot:[String] = [
        "Room1",
        "Room2",
        "Room3",
        "Room4",
        "Room5"
    ]
    
    //MARK: -
    
    func testModelJson()
    {
        let snapshotCountRooms:Int = kSnapshot.count
        let snapshotLastRoom:String = kSnapshot.last!
        
        let firebaseUserRooms:FDatabaseModelUserRooms = FDatabaseModelUserRooms(
            rooms:kSnapshot)
        
        let json:Any = firebaseUserRooms.modelJson()
        let jsonArray:[String]? = json as? [String]
        let userCountRooms:Int? = jsonArray?.count
        let userLastRoom:String? = jsonArray?.last
        
        XCTAssertNotNil(jsonArray, "Couldn't parse rooms json")
        XCTAssertNotNil(userCountRooms, "Couldn't parse rooms count")
        XCTAssertNotNil(userLastRoom, "Couldn't parse last room name")
        XCTAssertEqual(snapshotCountRooms, userCountRooms, "Invalid number of rooms")
        XCTAssertEqual(snapshotLastRoom, userLastRoom, "Invalid last room name")
    }
    /*
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
        
        XCTAssertEqual(userName, snapshotName, "Invalid name")
        XCTAssertEqual(userCreated, snapshotCreated, "Invalid created timestamp")
        XCTAssertEqual(snapshotCountRooms, userCountRooms, "Invalid rooms")
        XCTAssertEqual(snapshotLastRoomId, userLastRoomId, "Invalid room id")
    }*/
}
