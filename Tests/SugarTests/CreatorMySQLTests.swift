import XCTest
import Fluent
import FluentMySQL

@testable import Sugar

class CreatorMySQLTests: XCTestCase {
   
    // MARK: DATETIME
    func testDateTime() {
        let builder = Schema.Creator("table")
        builder.datetime("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeOptional() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeUnique() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME)") // TODO UNIQUE is not added??
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeDefaultValue() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true, defaultValue: "2000-01-01 00:00:00")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME DEFAULT 2000-01-01 00:00:00)") // Waiting for PR to add '2000-01-01 00:00:00'
        XCTAssertEqual(values.count, 0)
    }
    
    func testTimestamps() {
        let builder = Schema.Creator("table")
        builder.timestamps()
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`created_at` DATETIME, `updated_at` DATETIME)")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: TEMP TEST
    func test() {
        let builder = Schema.Creator("table")
        builder.string("column", default: "test")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        print("")
        print("")
        print(statement)
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` VARCHAR(255) NOT NULL DEFAULT test)") // Waiting for PR to add 'test'
        XCTAssertEqual(values.count, 0)
    }
    
    static var allTests : [(String, (CreatorMySQLTests) -> () throws -> Void)] {
        return [
            ("testDateTime", testDateTime),
            ("testDateTimeOptional", testDateTimeOptional),
            ("testDateTimeDefaultValue", testDateTimeDefaultValue),
            ("testDateTimeUnique", testDateTimeUnique),
            ("testTimestamps", testTimestamps),
            ("test", test),
        ]
    }
}
