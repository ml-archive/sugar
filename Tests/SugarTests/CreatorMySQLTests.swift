import XCTest
import Fluent
import FluentMySQL

@testable import Sugar

class CreatorMySQLTests: XCTestCase {
   
    // MARK: DATE
    func testDate() {
        let builder = Schema.Creator("table")
        builder.date("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATE NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateOptional() {
        let builder = Schema.Creator("table")
        builder.date("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateUnique() {
        let builder = Schema.Creator("table")
        builder.date("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATE UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateDefaultValue() {
        let builder = Schema.Creator("table")
        builder.date("column", optional: true, defaultValue: "2000-01-01")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATE DEFAULT '2000-01-01')")
        XCTAssertEqual(values.count, 0)
    }
    
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
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDateTimeDefaultValue() {
        let builder = Schema.Creator("table")
        builder.datetime("column", optional: true, defaultValue: "2000-01-01 00:00:00")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DATETIME DEFAULT '2000-01-01 00:00:00')")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: Timestamps
    func testTimestamps() {
        let builder = Schema.Creator("table")
        builder.timestamps()
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`created_at` DATETIME, `updated_at` DATETIME)")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: INT
    func testInteger() {
        let builder = Schema.Creator("table")
        builder.integer("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` INTEGER(11) NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testIntegerSigned() {
        let builder = Schema.Creator("table")
        builder.integer("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` INTEGER(10) UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testIntegerOptional() {
        let builder = Schema.Creator("table")
        builder.integer("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` INTEGER(11))")
        XCTAssertEqual(values.count, 0)
    }
    
    func testIntegerUnique() {
        let builder = Schema.Creator("table")
        builder.integer("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` INTEGER(11) UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testIntegerDefault() {
        let builder = Schema.Creator("table")
        builder.integer("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` INTEGER(11) DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: TINYINT
    func testTinyInteger() {
        let builder = Schema.Creator("table")
        builder.tinyInteger("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` TINYINT NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testTinyIntegerSigned() {
        let builder = Schema.Creator("table")
        builder.tinyInteger("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` TINYINT UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testTinyIntegerOptional() {
        let builder = Schema.Creator("table")
        builder.tinyInteger("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` TINYINT)")
        XCTAssertEqual(values.count, 0)
    }
    
    
    func testTinyIntegerUnique() {
        let builder = Schema.Creator("table")
        builder.tinyInteger("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` TINYINT UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testTinyIntegerDefault() {
        let builder = Schema.Creator("table")
        builder.tinyInteger("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` TINYINT DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: SMALLINT
    func testSmallInteger() {
        let builder = Schema.Creator("table")
        builder.smallInteger("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` SMALLINT NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testSmallIntegerSigned() {
        let builder = Schema.Creator("table")
        builder.smallInteger("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` SMALLINT UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testSmallIntegerOptional() {
        let builder = Schema.Creator("table")
        builder.smallInteger("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` SMALLINT)")
        XCTAssertEqual(values.count, 0)
    }
    
    
    func testSmallIntegerUnique() {
        let builder = Schema.Creator("table")
        builder.smallInteger("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` SMALLINT UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testSmallIntegerDefault() {
        let builder = Schema.Creator("table")
        builder.smallInteger("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` SMALLINT DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: MEDIUMINT
    func testMediumInteger() {
        let builder = Schema.Creator("table")
        builder.mediumInteger("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` MEDIUMINT NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testMediumIntegerSigned() {
        let builder = Schema.Creator("table")
        builder.mediumInteger("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` MEDIUMINT UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testMediumIntegerOptional() {
        let builder = Schema.Creator("table")
        builder.mediumInteger("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` MEDIUMINT)")
        XCTAssertEqual(values.count, 0)
    }
    
    
    func testMediumIntegerUnique() {
        let builder = Schema.Creator("table")
        builder.mediumInteger("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` MEDIUMINT UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testMediumIntegerDefault() {
        let builder = Schema.Creator("table")
        builder.mediumInteger("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` MEDIUMINT DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: BIGINT
    func testBigInteger() {
        let builder = Schema.Creator("table")
        builder.bigInteger("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` BIGINT NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testBigIntegerSigned() {
        let builder = Schema.Creator("table")
        builder.bigInteger("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` BIGINT UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testBigIntegerOptional() {
        let builder = Schema.Creator("table")
        builder.bigInteger("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` BIGINT)")
        XCTAssertEqual(values.count, 0)
    }
    
    
    func testBigIntegerUnique() {
        let builder = Schema.Creator("table")
        builder.bigInteger("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` BIGINT UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testBigIntegerDefault() {
        let builder = Schema.Creator("table")
        builder.bigInteger("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` BIGINT DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: DECIMAL
    func testDecimal() {
        let builder = Schema.Creator("table")
        builder.decimal("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DECIMAL(4,2) NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDecimalSigned() {
        let builder = Schema.Creator("table")
        builder.decimal("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DECIMAL(4,2) UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDecimalOptional() {
        let builder = Schema.Creator("table")
        builder.decimal("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DECIMAL(4,2))")
        XCTAssertEqual(values.count, 0)
    }
    
    
    func testDecimalUnique() {
        let builder = Schema.Creator("table")
        builder.decimal("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DECIMAL(4,2) UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDecimalDefault() {
        let builder = Schema.Creator("table")
        builder.decimal("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DECIMAL(4,2) DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    func testDecimalPrecisionDigist() {
        let builder = Schema.Creator("table")
        builder.decimal("column", precision: 3, digits: 5, optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` DECIMAL(3,5))")
        XCTAssertEqual(values.count, 0)
    }
    
    // MARK: FLOAT
    func testFloat() {
        let builder = Schema.Creator("table")
        builder.float("column")
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` FLOAT(4,2) NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testFloatSigned() {
        let builder = Schema.Creator("table")
        builder.float("column", signed: false)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` FLOAT(4,2) UNSIGNED NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testFloatOptional() {
        let builder = Schema.Creator("table")
        builder.float("column", optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` FLOAT(4,2))")
        XCTAssertEqual(values.count, 0)
    }
    
    
    func testFloatUnique() {
        let builder = Schema.Creator("table")
        builder.float("column", optional: true, unique: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` FLOAT(4,2) UNIQUE)")
        XCTAssertEqual(values.count, 0)
    }
    
    func testFloatDefault() {
        let builder = Schema.Creator("table")
        builder.float("column", optional: true, defaultValue: 0)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` FLOAT(4,2) DEFAULT '0')")
        XCTAssertEqual(values.count, 0)
    }
    
    func testFloatPrecisionDigist() {
        let builder = Schema.Creator("table")
        builder.float("column", precision: 3, digits: 5, optional: true)
        
        let sql = builder.schema.sql
        let serializer = MySQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`column` FLOAT(3,5))")
        XCTAssertEqual(values.count, 0)
    }
    
    static var allTests : [(String, (CreatorMySQLTests) -> () throws -> Void)] {
        return [
            // DATE
            ("testDate", testDate),
            ("testDateOptional", testDateOptional),
            ("testDateDefaultValue", testDateDefaultValue),
            ("testDateUnique", testDateUnique),
            
            // DATETIME
            ("testDateTime", testDateTime),
            ("testDateTimeOptional", testDateTimeOptional),
            ("testDateTimeDefaultValue", testDateTimeDefaultValue),
            ("testDateTimeUnique", testDateTimeUnique),
            
            // TIMESTAMPS
            ("testTimestamps", testTimestamps),
            
            //INT
            ("testInteger", testInteger),
            ("testIntegerSigned", testIntegerSigned),
            ("testIntegerOptional", testIntegerOptional),
            ("testIntegerUnique", testIntegerUnique),
            ("testIntegerDefault", testIntegerDefault),
            
            //TINYINT
            ("testTinyInteger", testTinyInteger),
            ("testTinyIntegerSigned", testTinyIntegerSigned),
            ("testTinyIntegerOptional", testTinyIntegerOptional),
            ("testTinyIntegerUnique", testTinyIntegerUnique),
            ("testTinyIntegerDefault", testTinyIntegerDefault),
            
            //SMALLINT
            ("testSmallInteger", testSmallInteger),
            ("testSmallIntegerSigned", testSmallIntegerSigned),
            ("testSmallIntegerOptional", testSmallIntegerOptional),
            ("testSmallIntegerUnique", testSmallIntegerUnique),
            ("testSmallIntegerDefault", testSmallIntegerDefault),
            
            //MEDIUMINT
            ("testMediumInteger", testMediumInteger),
            ("testMediumIntegerSigned", testMediumIntegerSigned),
            ("testMediumIntegerOptional", testMediumIntegerOptional),
            ("testMediumIntegerUnique", testMediumIntegerUnique),
            ("testMediumIntegerDefault", testMediumIntegerDefault),
            
            //BIGINT
            ("testBigInteger", testBigInteger),
            ("testBigIntegerSigned", testBigIntegerSigned),
            ("testBigIntegerOptional", testBigIntegerOptional),
            ("testBigIntegerUnique", testBigIntegerUnique),
            ("testBigIntegerDefault", testBigIntegerDefault),
            
            //DECIMAL
            ("testDecimal", testDecimal),
            ("testDecimalSigned", testDecimalSigned),
            ("testDecimalOptional", testDecimalOptional),
            ("testDecimalUnique", testDecimalUnique),
            ("testDecimalDefault", testDecimalDefault),
            ("testDecimalPrecisionDigist", testDecimalPrecisionDigist),
            
            //DECIMAL
            ("testFloat", testFloat),
            ("testFloatSigned", testFloatSigned),
            ("testFloatOptional", testFloatOptional),
            ("testFloatUnique", testFloatUnique),
            ("testFloatDefault", testFloatDefault),
            ("testFloatPrecisionDigist", testFloatPrecisionDigist),
        ]
    }
}
