//
//  CEKImage.h
//  CEKBundleCreatorCLI
//
//  Created by Cihan Emre Kisakurek on 14/05/14.
//  Copyright (c) 2014 Cihan Emre Kisakurek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEKImage : NSObject


+(void)createImagePairsFromRetinaImagePath:(NSURL*)imagePath outputPath:(NSURL*)outputPath error:(NSError **)errorPtr;


@end
