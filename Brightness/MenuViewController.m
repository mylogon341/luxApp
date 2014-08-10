//
//  MenuViewController.m
//  Brightness
//
//  Created by Luke Sadler on 26/05/2014.
//
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)blogButton:(id)sender{
    //dispatch_async(dispatch_get_main_queue(), ^{

    [self performSegueWithIdentifier:@"blog" sender:self];
   
    }

-(IBAction)aboutButton:(id)sender
{
    [self performSegueWithIdentifier:@"about" sender:self];

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
