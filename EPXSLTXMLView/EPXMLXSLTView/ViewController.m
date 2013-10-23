//
//  ViewController.m
//  EPXSLTXMLView
//
//  Created by Kelsey Regan on 2013-10-22.
//  Copyright (c) 2013 Elevated Pixels Software. All rights reserved.
//

#import "ViewController.h"
#import "EPXMLXSLTView.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet EPXMLXSLTView* XMLXSLTView;
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    NSString* xml = @"\
    <DataObjects>\
    <DataObject title='data object 1'/>\
    <DataObject title='data object 2'/>\
    <DataObject title='data object 3'/>\
    </DataObjects>";
    [self.XMLXSLTView loadWithXSLTFileName:@"test.xslt" withXML:xml];
}

@end
