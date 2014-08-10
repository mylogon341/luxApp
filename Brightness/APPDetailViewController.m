//
//  APPDetailViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPDetailViewController.h"

@implementation APPDetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
   
    NSString *urlString = [NSString stringWithFormat:@"%@",myURL];
    NSString *newString = [urlString substringToIndex:[urlString length]-9];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud setAnimationType:MBProgressHUDAnimationFade];
    
    [hud setDimBackground:NO];
    
    
    //hud.labelText = @"Loading...";

    myURL = [NSURL URLWithString:newString];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [hud hide:YES];
}


@end
