//
//  UIImage+Effects.h
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Effects)

- (UIImage *) imageWithBlur;
- (UIImage *) imageWithVignette;
- (UIImage *) imageWithPolkaDotOfSize: (float) size;

@end
