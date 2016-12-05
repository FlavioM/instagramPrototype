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
        NSLog(@"%@", cookie, nil);
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
//
//    //allow ALL cookies
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    if([Utils isLoggedIn])
    {
        [self.navigationController performSegueWithIdentifier:@"secondScreen" sender:self];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    //delete ALL cookies in NSHTTPCookieStorage...
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]){
        NSLog(@"%@", cookie, nil);
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

    
    NSLog(@"Button pressed.\n##########################################################");

    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=%@", INSTA_CLIENT_ID, INSTA_REDIRECT_URL, INSTA_RESPONSETYPE_TOKEN, nil];
//    NSString *url = [NSString stringWithFormat:@"", GOOGLE_CLIENT_ID, GOOGLE_REDIRECT_URL, nil];
    
    
    NSLog(@"Auth URL: %@", url, nil);
    

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPShouldHandleCookies:YES];
    
    
    [self.webView loadRequest:request];
    
}




#pragma mark - WKWebView Delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request       navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = [request mainDocumentURL].absoluteString;
    NSLog(@"Loading... %@", url, nil);
    return YES;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
    NSURL *myRequestedUrl= self.webView.URL;
    NSLog(@"didCommitNavigation url: %@", myRequestedUrl);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.webView setHidden:NO];
    NSURL *myLoadedUrl = self.webView.URL;
    NSLog(@"Loaded url: %@", myLoadedUrl);
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"Redirected url: %@", navigation);
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{

//    NSLog(@"Error!!!: %@", error);
    
    NSURL *err = [error.userInfo objectForKey:@"NSErrorFailingURLKey"];
//    NSLog(@"URL ##################################\n %@ ", err);
    if([err.absoluteString hasPrefix:INSTA_REDIRECT_URL]){
        NSString *token = [[err.absoluteString componentsSeparatedByString:@"#access_token="] objectAtIndex:1];
        
        [Utils saveToken:token];
        
        [self.webView removeFromSuperview];
        self.webView = nil;
        NSLog(@"\nToken: %@", token, nil);
        
        [self.navigationController performSegueWithIdentifier:@"secondScreen" sender:self];
        //open next view controller
    }else{
        //TODO: No internet? something else went wrong..
        
        NSLog(@"Error: %@", error);
    }
    
}



@end
