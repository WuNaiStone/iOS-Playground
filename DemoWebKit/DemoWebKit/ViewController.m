//
//  ViewController.m
//  DemoWebKit
//
//  Created by Chris Hu on 30/01/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <
    WKNavigationDelegate,
    WKUIDelegate
>

@property (nonatomic, strong) WKWebView *webView;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"loading" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.progressView.progressTintColor = [UIColor blueColor];
    self.progressView.trackTintColor = [UIColor whiteColor];
    
    [self.view insertSubview:self.webView atIndex:0];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
//    [self loadImg];
//    [self loadGif];
//    [self loadPDF];
//    [self loadHTML];
    [self loadURL:@"https://www.baidu.com"];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
    }
    return _webView;
}

- (void)loadImg {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Model" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"image/jpg" characterEncodingName:@"UTF-8" baseURL:[[NSURL alloc] init]];
}

- (void)loadHTML {
    [self.webView loadHTMLString:@"<html><body><p>this is baidu!</p></body></html>" baseURL: [NSURL URLWithString:@"https://www.baidu.com"]];
}

- (void)loadPDF {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"isa" ofType:@"pdf"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:[[NSURL alloc] init]];
}

- (void)loadGif {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"image/gif" characterEncodingName:@"UTF-8" baseURL:[[NSURL alloc] init]];
}

- (void)loadURL:(NSString *)urlString {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:urlRequest];
}

// MARK: - actions

- (IBAction)actionBtnClose:(UIButton *)sender {
}

- (IBAction)actionBtnBackward:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (IBAction)actionBtnForward:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (IBAction)actionBtnRefresh:(UIButton *)sender {
    [self.webView reloadFromOrigin];
}

// MARK: - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading: %d", _webView.isLoading);
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"estimatedProgress: %f", _webView.estimatedProgress);
        self.progressView.progress = _webView.estimatedProgress;
        if (self.progressView.progress >= 1.f) {
            self.progressView.progress = 0.f;
        }
    }
}

// MARK: - WKNavigationDelegate

/*! A class conforming to the WKNavigationDelegate protocol can provide
 methods for tracking progress for main frame navigations and for deciding
 policy for main frame and subframe navigations.
 */

/*! @abstract Decides whether to allow or cancel a navigation.
 @param webView The web view invoking the delegate method.
 @param navigationAction Descriptive information about the action
 triggering the navigation request.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
//}

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
//}

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
    NSLog(@"error: %@", error);
}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
//}

/*! @abstract Invoked when the web view's web content process is terminated.
 @param webView The web view whose underlying web content process was terminated.
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

// MARK: - WKUIDelegate

/*! A class conforming to the WKUIDelegate protocol provides methods for
 presenting native UI on behalf of a webpage.
 */

/*! @abstract Creates a new web view.
 @param webView The web view invoking the delegate method.
 @param configuration The configuration to use when creating the new web
 view.
 @param navigationAction The navigation action causing the new web view to
 be created.
 @param windowFeatures Window features requested by the webpage.
 @result A new web view or nil.
 @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
 
 If you do not implement this method, the web view will cancel the navigation.
 */
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

/*! @abstract Notifies your app that the DOM window object's close() method completed successfully.
 @param webView The web view invoking the delegate method.
 @discussion Your app should remove the web view from the view hierarchy and update
 the UI as needed, such as by closing the containing browser tab or window.
 */
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Displays a JavaScript alert panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this
 call.
 @param completionHandler The completion handler to call after the alert
 panel has been dismissed.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have a single OK button.
 
 If you do not implement this method, the web view will behave as if the user selected the OK button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Displays a JavaScript confirm panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the confirm
 panel has been dismissed. Pass YES if the user chose OK, NO if the user
 chose Cancel.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

/*! @abstract Displays a JavaScript text input panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param defaultText The initial text to display in the text entry field.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the text
 input panel has been dismissed. Pass the entered text if the user chose
 OK, otherwise nil.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel, and a field in
 which to enter text.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

#if TARGET_OS_IPHONE

/*! @abstract Allows your app to determine whether or not the given element should show a preview.
 @param webView The web view invoking the delegate method.
 @param elementInfo The elementInfo for the element the user has started touching.
 @discussion To disable previews entirely for the given element, return NO. Returning NO will prevent
 webView:previewingViewControllerForElement:defaultActions: and webView:commitPreviewingViewController:
 from being invoked.
 
 This method will only be invoked for elements that have default preview in WebKit, which is
 limited to links. In the future, it could be invoked for additional elements.
 */
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
    return YES;
}

/*! @abstract Allows your app to provide a custom view controller to show when the given element is peeked.
 @param webView The web view invoking the delegate method.
 @param elementInfo The elementInfo for the element the user is peeking.
 @param defaultActions An array of the actions that WebKit would use as previewActionItems for this element by
 default. These actions would be used if allowsLinkPreview is YES but these delegate methods have not been
 implemented, or if this delegate method returns nil.
 @discussion Returning a view controller will result in that view controller being displayed as a peek preview.
 To use the defaultActions, your app is responsible for returning whichever of those actions it wants in your
 view controller's implementation of -previewActionItems.
 
 Returning nil will result in WebKit's default preview behavior. webView:commitPreviewingViewController: will only be invoked
 if a non-nil view controller was returned.
 */
//- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0))

/*! @abstract Allows your app to pop to the view controller it created.
 @param webView The web view invoking the delegate method.
 @param previewingViewController The view controller that is being popped.
 */
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
    NSLog(@">>>>>>>>>> %s", __FUNCTION__);
}

#endif // TARGET_OS_IPHONE

#if !TARGET_OS_IPHONE

/*! @abstract Displays a file upload panel.
 @param webView The web view invoking the delegate method.
 @param parameters Parameters describing the file upload control.
 @param frame Information about the frame whose file upload control initiated this call.
 @param completionHandler The completion handler to call after open panel has been dismissed. Pass the selected URLs if the user chose OK, otherwise nil.
 
 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
//- (void)webView:(WKWebView *)webView runOpenPanelWithParameters:(WKOpenPanelParameters *)parameters initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSArray<NSURL *> * _Nullable URLs))completionHandler API_AVAILABLE(macosx(10.12));

#endif

@end
