/*
 Copyright 2009-2014 Urban Airship Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UAUtils.h"
#import "UAUtilsTest.h"

@interface UAUtilsTest ()
@property(nonatomic, strong) NSCalendar *gregorianUTC;
@end

@implementation UAUtilsTest

- (void)setUp {
    [super setUp];
    self.gregorianUTC = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];

    self.gregorianUTC.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

- (void)tearDown {
    [super tearDown];
}

- (NSDateComponents *)componentsForDate:(NSDate *)date {
    return [self.gregorianUTC components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
}

- (void)validateDateFormatter:(NSDateFormatter *)dateFormatter withFormatString:(NSString *)formatString {
    NSDate *date = [dateFormatter dateFromString:formatString];

    NSDateComponents *components = [self componentsForDate:date];

    XCTAssertEqual(components.year, 2020);
    XCTAssertEqual(components.month, 12);
    XCTAssertEqual(components.day, 15);
    XCTAssertEqual(components.hour, 11);
    XCTAssertEqual(components.minute, 45);
    XCTAssertEqual(components.second, 22);

    XCTAssertEqualObjects(formatString, [dateFormatter stringFromDate:date]);

}

- (void)testISODateFormatterUTC {
    [self validateDateFormatter:[UAUtils ISODateFormatterUTC] withFormatString: @"2020-12-15 11:45:22"];
}

- (void)testISODateFormatterUTCWithDelimiter {
    [self validateDateFormatter:[UAUtils ISODateFormatterUTCWithDelimiter] withFormatString: @"2020-12-15T11:45:22"];
}

@end
