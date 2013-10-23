//
//  EPXMLXSLTView.m
//  FieldData
//
//  Created by Kelsey Regan on 2013-09-23.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import "EPXMLXSLTView.h"

@interface EPXMLXSLTView() <UIWebViewDelegate>
@property(strong, nonatomic, readwrite) UIWebView* webView;
@property(nonatomic, readwrite) CGSize contentSize;
@property(nonatomic, strong) NSData* dataToLoad;
@property(nonatomic, strong) NSURL* baseURL;
@end

@implementation EPXMLXSLTView
static NSMutableArray* viewsToLoad;
+(void)load:(EPXMLXSLTView*)view
{
    if( !viewsToLoad ) viewsToLoad = [NSMutableArray array];
    [viewsToLoad addObject:view];
    if( viewsToLoad.count <= 1 )
    {
        [view.webView loadData:view.dataToLoad MIMEType:@"text/xml" textEncodingName:@"utf-8" baseURL:view.baseURL];
    }
}

+(void)loadNext
{
    [viewsToLoad removeObjectAtIndex:0];
    if( viewsToLoad.count > 0 )
    {
        EPXMLXSLTView* view = viewsToLoad[0];
        [view.webView loadData:view.dataToLoad MIMEType:@"text/xml" textEncodingName:@"utf-8" baseURL:view.baseURL];
    }
}


-(void)loadWithXSLTFileName:(NSString*)XSLTFileName withXML:(NSString*)XML
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self loadURL:baseURL XSLTPath:XSLTFileName withXML:XML];
}

-(void)loadWithXSLTFileName:(NSString*)XSLTFileName withXMLFileName:(NSString*)XMLFileName
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString* path2 = [[NSBundle mainBundle] pathForResource:XMLFileName ofType:@"xml"];
    [self loadURL:baseURL XSLTPath:XSLTFileName withXML:[NSString stringWithContentsOfFile:path2 encoding:NSASCIIStringEncoding error:nil]];
}

-(void)loadURL:(NSURL*)baseURL XSLTPath:(NSString*)XSLTRelativePath withXML:(NSString*)XML
{
    self.backgroundColor = [UIColor whiteColor];
    self.webView.alpha = 0;
    NSString* formattedXML = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><?xml-stylesheet type=\"text/xsl\" href=\"%@\"?>%@", XSLTRelativePath, XML];
    self.dataToLoad = [formattedXML dataUsingEncoding:NSUTF8StringEncoding];
    self.baseURL = baseURL;
    [EPXMLXSLTView load:self];
}

#pragma mark Properties

-(UIWebView *)webView
{
    if( !_webView )
    {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.autoresizingMask ^= UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _webView.delegate = self;
        _webView.opaque = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_webView];
    }
    return _webView;
}

#pragma mark Utilities

-(NSDictionary*)dictionaryWithPostHTTPBody:(NSString*)HTTPBody
{
    NSMutableDictionary* postData = [NSMutableDictionary dictionary];
    NSArray* keyValues = [HTTPBody componentsSeparatedByString:@"&"];
    for( NSString* keyValue in keyValues )
    {
        NSArray* pairing = [keyValue componentsSeparatedByString:@"="];
        if( pairing.count > 1 )
        {
            NSString* key = pairing[0];
            NSString* value = [pairing[1] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            [postData setValue:value forKey:key];
        }
    }
    
    return postData;
}

#pragma mark UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Disable user selection
    self.contentSize = webView.scrollView.contentSize;
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
//    if( [self.delegate respondsToSelector:@selector(XMLXSLTView:loadedHTML:)] )
    {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
//        [self.delegate XMLXSLTView:self loadedHTML:html];
    }
    
    if( [self.delegate respondsToSelector:@selector(didFinishLoadXMLXSLTView:)] )
    {
        [self.delegate didFinishLoadXMLXSLTView:self];
    }
    
    [UIView animateWithDuration:.5 animations:^
    {
        self.webView.alpha = 1;
    }];
    [EPXMLXSLTView loadNext];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* HTTPBody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    NSDictionary* postData = [self dictionaryWithPostHTTPBody:HTTPBody];
    if( [self.delegate respondsToSelector:@selector(XMLXSLTView:receivedPost:)] )
    {
        [self.delegate XMLXSLTView:self receivedPost:postData];
    }
    return YES;//navigationType != UIWebViewNavigationTypeFormSubmitted;
}

@end
