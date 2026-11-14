//___FILEHEADER___

#import <XCTest/XCTest.h>

@interface ___FILEBASENAMEASIDENTIFIER___ : XCTestCase

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    
    // Toma una captura de la pantalla inicial y la guarda en los resultados
    XCUIScreenshot *screenshot = [[XCUIScreen mainScreen] screenshot];
    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:screenshot];
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
