//
//  ViewController.m
//  instagramPrototype
//
//  Created by Flávio Marques on 03/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#define INSTA_CLIENT_ID @"ad06f93fd6894123aa941ea6a229dba5"
#define INSTA_REDIRECT_URL @"http://localhost"
//#define INSTA_REDIRECT_URL @"http://instagram-callback.com/coiso"

#define INSTA_RESPONSETYPE_TOKEN @"token"
#define KW_ACCESS_TOKEN @"#access_token="

#import "ViewController.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    //clean ALL cookies
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
//
//    //allow ALL cookies
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    //if the user has a valid authentication saved, open the 2nd screen
    if([Utils isLoggedIn])
    {
        [self.navigationController performSegueWithIdentifier:@"secondScreen" sender:self];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*!
 @brief Action called when the user presses the big (login) button
 
 @discussion This method attempts to delete all cookies from the webview, and then presents the Login view for Instagram.
 Should be assigned to the button's action
 @param  sender The button.
 */
- (IBAction)login:(id)sender {
    //delete ALL cookies in NSHTTPCookieStorage...
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    //delete ALL WKWebView cookies in iOS 8.0 ...
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
    NSError *errors;
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    
    //delete ALL WKWebView cookies in iOS 9.0 ...
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records)
                         {
                                                             [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                            
                         }
                     }];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    CGRect frame = CGRectMake(self.view.frame.origin.x+10, 85, self.view.frame.size.width-20, self.view.frame.size.height-10-85);
    
    
    self.webView = [[WKWebView alloc] initWithFrame:frame configuration:config];
    
    self.webView.navigationDelegate = self;
    
    [self.view addSubview:self.webView];
    [self.view bringSubviewToFront:self.webView];

    
    

    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=%@", INSTA_CLIENT_ID, INSTA_REDIRECT_URL, INSTA_RESPONSETYPE_TOKEN, nil];
//    NSString *url = [NSString stringWithFormat:@"", GOOGLE_CLIENT_ID, GOOGLE_REDIRECT_URL, nil];
    
    
    //NSLog(@"Auth URL: %@", url, nil);
    

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPShouldHandleCookies:YES];
    
    
    [self.webView loadRequest:request];
    
}




#pragma mark - WKWebView Delegate methods

//action to take when the user "successfully" authenticates.
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
    NSURL *url = [error.userInfo objectForKey:@"NSErrorFailingURLKey"];

    if([self validateLogin:url]){
        [self loggedIn:url];
    }else{
        //TODO: No internet? something else went wrong..
        
        NSLog(@"Error: %@", error);
    }
    
}

/*!
 @brief Checks if the login was successful
 
 @discussion This method accepts an NSURL and checks if the desired keyword is in it, making it a valid (or not) login.
 
 @param  url    the URL to validate as a successful forwarded URL
 
 @return BOOL Was it a successful login?
 */
-(BOOL) validateLogin:(NSURL *)url
{
    if([url.absoluteString hasPrefix:INSTA_REDIRECT_URL])
        return TRUE;
    return FALSE;
}


/*!
 @brief Method called when the user successfully logged in.
 
 @discussion This method saves the token inside the forwarded_url, removes the login webview, and presents the SecondScreen.
 
 @param  forwarded_url the URL to which the user was forwarded.
 
 
 */
-(void) loggedIn:(NSURL *) forwarded_url
{
    NSString *token = [[forwarded_url.absoluteString componentsSeparatedByString:KW_ACCESS_TOKEN] objectAtIndex:1];
    
    [Utils saveToken:token];
    
    [self.webView removeFromSuperview];
    self.webView = nil;
    
    //open next view controller
    [self.navigationController performSegueWithIdentifier:@"secondScreen" sender:self];

}

@end
