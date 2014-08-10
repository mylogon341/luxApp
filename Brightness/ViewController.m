//
//  ViewController.m
//  Brightness
//
//  Created by Jonas Martinsson on 25/05/14.
//
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import "LocationFinder.h"

@interface ViewController ()
{
    AVCaptureSession *_session;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [_finalAverage setFont:[UIFont fontWithName:@"Digital-7" size:65]];
    [email.titleLabel setFont:[UIFont fontWithName:@"Digital-7" size:15]];
    email.alpha = 0.2;
    _finalAverage.text = @"888 LX";
    _finalAverage.alpha = 0.2;

    [super viewDidLoad];
    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.allowsEditing = YES;
    
    email.enabled = NO;
    buttonInt =1;
    self.navigationController.navigationBar.hidden = YES;
    
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    AVCaptureDevice *device = [self frontCamera];
    //[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    
    if (!input) {
        // Handle the error appropriately.
    }
    [_session addInput:input];
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [_session addOutput:output];
    output.videoSettings = @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    //    [device setActiveVideoMinFrameDuration:CMTimeMake(1, 15)];
    
    dispatch_queue_t queue = dispatch_queue_create("MyQueue", NULL);
    [output setSampleBufferDelegate:self queue:queue];
    
}



- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)measureButtonTapped:(id)sender
{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    });
    
    if ([_session isRunning]) {
        [_session stopRunning];
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    } else {
        [_session startRunning];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_measureButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [self performSelectorInBackground:@selector(progress) withObject:nil];
          
            [self performSelector:@selector(measure3) withObject:nil afterDelay:5];
        });
    }
    
}

-(void)progress{
    CGRect hudRect = CGRectMake(_finalAverage.frame.origin.x + _finalAverage.frame.size.width/2 - 100, _finalAverage.frame.origin.y, 200, 150);
    
    hudview = [[UIView alloc]initWithFrame:hudRect];
    [self.view addSubview:hudview];
    
    hud = [MBProgressHUD showHUDAddedTo:hudview animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud setAnimationType:MBProgressHUDAnimationFade];
    hud.labelText = @"Reading..";
    hud.labelFont = [UIFont fontWithName:@"Digital-7" size:20];
   // _measureButton.alpha = 0;
    _measureButton.enabled = NO;

}


-(void)measure3{
    level3Float = brightnessValue;
    [_session stopRunning];
    [self final];
}

-(void)final{
    
    finalFloat = level3Float;
    
    float luxTemp = (level3Float + 5.789170);
    
    float luxFloat = (luxTemp * luxTemp) + (luxTemp* luxTemp);
    
    luxFinal = luxFloat;
    
    
    if (luxFinal < 100) {
        luxFinal = luxFinal/2;
    }else{
        if (luxFinal >= 101 && luxFinal < 200) {
            luxFinal = luxFinal +20;
        }else{
            if (luxFinal > 201 && luxFinal < 300) {
                luxFinal = luxFinal *2;
            }else{
                if (luxFinal >= 301 && luxFinal < 400) {
                    luxFinal = luxFinal * 3;
                }else{
                    if (luxFinal >= 401 && luxFinal < 500) {
                        luxFinal = luxFinal * 4;
                    }
                }}}}
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finalAverage.text = [NSString stringWithFormat:@" %d lx",luxFinal];
        [hud hide:YES];
        done = YES;
        [hudview removeFromSuperview];
        email.enabled = YES;
        email.alpha = 1;
        _measureButton.alpha = 0.5;
        _finalAverage.alpha = 1;
        
    });
    //[self label];
}


#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,
                                                                 sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc]
                              initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata
                                   objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    brightnessValue = [[exifMetadata
                        objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        self.brightnessLabel.text = [NSString stringWithFormat:@"Brightness: %f", brightnessValue];
    });
}

-(IBAction)resetButton{
    _finalAverage.text = @"888 LX";
    _measureButton.enabled = YES;
    _measureButton.alpha = 1;
    email.alpha = 0.2;
    email.enabled = NO;
    _finalAverage.alpha = 0.2;
    
}


@end
