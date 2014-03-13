//
//  FLXViewController.m
//  MySafari
//
//  Created by Administrator on 3/13/14.
//  Copyright (c) 2014 FileLogix. All rights reserved.
//

#import "FLXViewController.h"

@interface FLXViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UITextField *myURLTextField;
@property (strong, nonatomic) IBOutlet UILabel *forwardLabel;
@property (strong, nonatomic) IBOutlet UILabel *backLabel;
@property (strong, nonatomic) IBOutlet UIButton *reloadButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation FLXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
    [self.backLabel setEnabled:NO];
    [self.forwardLabel setEnabled:NO];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSString *urlString = @"http://www.mobilemakers.co";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myWebView loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSLog(@"URL: %@", textField.text);

    NSString *urlString = textField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.myWebView loadRequest:request];
    [self updateButtonStatus];
    
    return YES;
    
}

- (void) updateButtonStatus {
    NSLog(@"Can Go Back? %@", [self.myWebView canGoBack] ? @"YES" : @"NO");
    
    [self.backButton setEnabled:[self.myWebView canGoBack]];
    [self.backLabel setEnabled:[self.myWebView canGoBack]];
    [self.forwardButton setEnabled:[self.myWebView canGoForward]];
    [self.forwardLabel setEnabled:[self.myWebView canGoForward]];
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [self updateButtonStatus];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self updateButtonStatus];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self updateButtonStatus];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)onBackButtonPressed:(id)sender {
    NSLog(@"Back Button");
    [self.myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    NSLog(@"Forward Button");
    [self.myWebView goForward];
}

- (IBAction)onStopButtonPressed:(id)sender {
    NSLog(@"Stop Button");
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    NSLog(@"Reload Button");
    [self.myWebView reload];
}


@end
