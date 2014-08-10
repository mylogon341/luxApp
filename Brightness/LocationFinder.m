//
//  LocationFinder.m
//  Brightness
//
//  Created by Luke Sadler on 26/05/2014.
//
//

#import "LocationFinder.h"
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationFinder () <CLLocationManagerDelegate>

@end

@implementation LocationFinder
{
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;

    [manager setDelegate:self];
    geocoder = [[CLGeocoder alloc] init];
    [self get];
}

-(void)get{
   
   
    done = YES;
    [manager startUpdatingLocation];
    [self isGeolocationAvailable];
    [self progress];

}

-(void)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud setAnimationType:MBProgressHUDAnimationFade];
        [hud setDimBackground:YES];
        
        hud.labelText = @"Generating email...";
        
        
      //  [CLLocationManager authorizationStatus]kCLAuthorizationStatusAuthorized

        
        NSLog(@"auth %d",[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized);

    });
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location! :(");
    
}

-(BOOL) isGeolocationAvailable {
    
    
    if(([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)||(![CLLocationManager locationServicesEnabled])){
        NSLog(@"NO");
        return NO;
    } else {
        NSLog(@"YES");
        return YES;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            
            placemark = [placemarks lastObject];
            
            address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            
            if (done) {
            [self email];
                done = NO;
            }
        } else {
            
            NSLog(@"%@", error.debugDescription);
            
        }
        
    } ];
    
}

-(void)email{
    
    [hud hide:YES];
    
    // Email Subject
    NSString *emailTitle = @"LEDified App Readings";
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Using the LEDified app I got a reading of %dlx at the address of:\n%@",luxFinal,address];
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self progresssecond];
    [self performSelector:@selector(returning) withObject:nil afterDelay:1.5];
}

-(void)progresssecond{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud setAnimationType:MBProgressHUDAnimationFade];
        [hud setDimBackground:YES];
        
        hud.labelText = @"Returning....";
        
    });
    
}

-(void)returning{
    
    [hud hide:YES];
    [self performSegueWithIdentifier:@"return" sender:nil];

}


@end
