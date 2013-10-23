//
//  EPXMLXSLTView.h
//  FieldData
//
//  Created by Kelsey Regan on 2013-09-23.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPXMLXSLTViewProtocol.h"
@interface EPXMLXSLTView : UIView
-(void)loadWithXSLTFileName:(NSString*)XSLTFileName withXML:(NSString*)XML;
-(void)loadURL:(NSURL*)baseURL XSLTPath:(NSString*)XSLTRelativePath withXML:(NSString*)XML;
-(void)loadWithXSLTFileName:(NSString*)XSLTFileName withXMLFileName:(NSString*)XMLFileName;
@property(strong, nonatomic, readonly) UIWebView* webView;
@property(nonatomic, readonly) CGSize contentSize;
@property(weak, nonatomic) id<EPXMLXSLTViewProtocol>delegate;
@end
