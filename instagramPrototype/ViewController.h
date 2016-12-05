//
//  ViewController.h
//  instagramPrototype
//
//  Created by Flávio Marques on 03/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController <WKNavigationDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *mainButton;

- (IBAction)login:(id)sender;

@end

