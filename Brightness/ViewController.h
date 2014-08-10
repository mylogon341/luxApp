//
//  ViewController.h
//  Brightness
//
//  Created by Jonas Martinsson on 25/05/14.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"

int luxFinal;

@interface ViewController : UIViewController <MBProgressHUDDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate, UINavigationBarDelegate, UIImagePickerControllerDelegate>
{
    float level1Float;
    float level2Float;
    float level3Float;
    float finalFloat;
    float brightnessValue;
    IBOutlet UIButton *email;
    IBOutlet UIButton *resetButton;
    int buttonInt;
    UIView *hudview;
    MBProgressHUD * hud;
//    IBOutlet UIButton *measureButton;
    BOOL done;
}
@property (strong, nonatomic) IBOutlet UIButton *measureButton;

@property (weak, nonatomic) IBOutlet UILabel *finalAverage;




@end
