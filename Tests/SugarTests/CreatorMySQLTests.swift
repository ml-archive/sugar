import XCTest
import Fluent

@testable import Sugar

class CreatorMySQLTests: XCTestCase {
   
    // MARK: DATETIME
    func testDateTime1() {
        let builder = Schema.Creator("table")
        builder.datetime("column")
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTime2() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTime3() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true, defaultValue: "2000-01-01 00:00:00")
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME DEFAULT 2000-01-01 00:00:00)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testString() {
        let builder = Schema.Creator("table")
        builder.string("column")
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` STRING NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    
    
    static var allTests : [(String, (CreatorMySQLTests) -> () throws -> Void)] {
        return [
            ("testString", testString),
        ]
    }
}
