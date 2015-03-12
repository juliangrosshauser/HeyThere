//
//  JGHAppDelegate.h
//  HeyThere
//
//  Created by Julian Grosshauser on 25/02/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>

@interface JGHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) LYRClient *layerClient;

@end

