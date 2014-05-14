//
//  CEKImage.m
//  CEKBundleCreatorCLI
//
//  Created by Cihan Emre Kisakurek on 14/05/14.
//  Copyright (c) 2014 Cihan Emre Kisakurek. All rights reserved.
//

#import "CEKImage.h"
#import <Cocoa/Cocoa.h>
@implementation CEKImage

+(void)createImagePairsFromRetinaImagePath:(NSURL*)imagePath outputPath:(NSURL*)outputPath error:(NSError **)errorPtr{
    
    NSData *imageData=[NSData dataWithContentsOfURL:imagePath];
    
    
    NSBitmapImageRep *retinaImage=[[NSBitmapImageRep alloc]initWithData:imageData];
    
    
    CGSize normalImageSize=CGSizeMake(retinaImage.size.width/2.0, retinaImage.size.height/2.0);
    
    NSBitmapImageRep *normalImage=[[NSBitmapImageRep alloc]initWithBitmapDataPlanes:nil pixelsWide:normalImageSize.width pixelsHigh:normalImageSize.height bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSCalibratedRGBColorSpace bitmapFormat:NSAlphaFirstBitmapFormat bytesPerRow:0 bitsPerPixel:32];
    
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:normalImage];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:g];
    
    [retinaImage drawInRect:NSMakeRect(0, 0, normalImageSize.width, normalImageSize.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
    [NSGraphicsContext restoreGraphicsState];
    
    NSError *error;
    
    NSString *path=[[outputPath path] stringByDeletingLastPathComponent];
    NSString *lastPathComponent=[[outputPath path] lastPathComponent];
    NSRange extentionRange=[lastPathComponent rangeOfString:[[outputPath path] pathExtension]];
    NSString *fileName=[lastPathComponent substringToIndex:extentionRange.location-1];
    NSURL *retinaWriteURL=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@@2x.png",path,fileName]];
    NSURL *normalWriteURL=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.png",path,fileName]];
    
    [[retinaImage representationUsingType:NSPNGFileType properties:nil] writeToURL:retinaWriteURL options:NSDataWritingAtomic error:&error];
    [[normalImage representationUsingType:NSPNGFileType properties:nil] writeToURL:normalWriteURL options:NSDataWritingAtomic error:&error];
}

@end
