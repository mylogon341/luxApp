//
//  LocationFinder.h
//  Brightness
//
//  Created by Luke Sadler on 26/05/2014.
//
//

NSString *address;

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationFinder : UIViewController <MBProgressHUDDelegate, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate>
{
    MBProgressHUD *hud;
    
    BOOL done;
}

@end
