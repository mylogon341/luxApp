//
//  ChartView.m
//  Brightness
//
//  Created by Luke Sadler on 26/05/2014.
//
//

#import "ChartView.h"
#import "ViewController.h"

@interface ChartView ()

@end

@implementation ChartView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad
{
    NSLog(@"%d",luxFinal);
    
    previous.text = [NSString stringWithFormat:@"Previous reading: %d lx",luxFinal];
    if (luxFinal == 0) {
        previous.text = [NSString stringWithFormat:@""];
   
    }
    
    
    webView.scalesPageToFit = YES;
    [[webView scrollView] setContentInset:UIEdgeInsetsMake(30, 0, 0, 0)];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"guide" ofType:@"png"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
