//
//  EPXMLXSLTViewProtocol.h
//  FieldData
//
//  Created by Kelsey Regan on 2013-09-23.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EPXMLXSLTView;
@protocol EPXMLXSLTViewProtocol <NSObject>
@optional
-(void)XMLXSLTView:(EPXMLXSLTView*)XMLXSLTView receivedPost:(NSDictionary*)post;
-(void)XMLXSLTView:(EPXMLXSLTView*)XMLXSLTView loadedHTML:(NSString*)HTML;
-(void)didFinishLoadXMLXSLTView:(EPXMLXSLTView*)XMLXSLTView;
@end
