//
//  UIImage+Effects.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "UIImage+Effects.h"
#import <GPUImage/GPUImage.h>

@implementation UIImage (Effects)

- (UIImage *) imageWithBlur
{
	GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
	blurFilter.blurRadiusInPixels = 60.0;
	return [blurFilter imageByFilteringImage: self];
}

- (UIImage *) imageWithVignette
{
	GPUImageVignetteFilter *vigneeteFilter = [[GPUImageVignetteFilter alloc] init];
	return [vigneeteFilter imageByFilteringImage: self];
}

- (UIImage *) imageWithPolkaDotOfSize: (float) size
{
	GPUImagePolkaDotFilter *polkaDotFilter = [[GPUImagePolkaDotFilter alloc] init];
	polkaDotFilter.fractionalWidthOfAPixel = size;
	polkaDotFilter.dotScaling = 0.9f;
	return [polkaDotFilter imageByFilteringImage: self];
}

@end
