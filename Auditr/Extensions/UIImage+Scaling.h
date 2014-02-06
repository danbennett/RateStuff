//
//  UIImage+Scaling.h
//  Auditr
//
//  Created by Daniel Bennett on 05/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scaling)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;

@end
