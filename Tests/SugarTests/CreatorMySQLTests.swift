import XCTest
import Fluent

@testable import Sugar

class CreatorMySQLTests: XCTestCase {
   
    // MARK: DATETIME
    func testDateTime() {
        let builder = Schema.Creator("table")
        builder.datetime("column")
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeOptional() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeUnique() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME)") // TODO UNIQUE is not added??
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeDefaultValue() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true, defaultValue: "2000-01-01 00:00:00")
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME DEFAULT 2000-01-01 00:00:00)") // TOOD this SQL is not valid
        XCTAssertEqual(values.count, 0)
    }
    
    func testTimestamps() {
        let builder = Schema.Creator("table")
        builder.timestamps()
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        print(statement)
        XCTAssertEqual(statement, "CREATE TABLE `table` (`created_at` DATETIME, `updated_at` DATETIME)")
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
            ("testDateTime", testDateTime),
            ("testDateTimeOptional", testDateTimeOptional),
            ("testDateTimeDefaultValue", testDateTimeDefaultValue),
            ("testDateTimeUnique", testDateTimeUnique),
            ("testTimestamps", testTimestamps),
            ("testString", testString),
        ]
    }
}
