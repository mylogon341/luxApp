//
//  APPDetailViewController.h
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface APPDetailViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD * hud;
}
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
