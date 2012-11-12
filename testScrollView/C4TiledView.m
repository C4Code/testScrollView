//
//  C4TiledView.m
//  scrolling
//
//  Created by moi on 12-11-12.
//  Copyright (c) 2012 moi. All rights reserved.
//

#import "C4TiledView.h"

@implementation C4TiledView {
    C4Image *bigImage;
}

@synthesize tilePrefix = _tilePrefix;
@synthesize tileDirectory = _tileDirectory;

+ layerClass {
    return [CATiledLayer class];
}

+(C4TiledView *)tiledViewWithName:(NSString *)imageName {
    C4TiledView *t = [[C4TiledView alloc] initWithImageName:imageName];
    return t;
}

-(id)initWithImageName:(NSString *)imageName {
    bigImage = [C4Image imageNamed:imageName];
    self = [super initWithFrame:bigImage.frame];
    if(self != nil) {
        _tilePrefix = [[imageName stringByDeletingPathExtension] stringByAppendingString:@"_"];

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *directoryPath = [paths objectAtIndex:0];
        _tileDirectory = directoryPath;
        
        [self saveTilesOfSize:(CGSize){256, 768} forImage:bigImage.UIImage toDirectory:self.tileDirectory usingPrefix:self.tilePrefix];
    }
    return self;
}

-(void)setup {
    self.backgroundColor = [UIColor clearColor];
}

- (void)saveTilesOfSize:(CGSize)size
               forImage:(UIImage*)image
            toDirectory:(NSString*)directoryPath
            usingPrefix:(NSString*)prefix {
    CGFloat cols = [image size].width / size.width;
    CGFloat rows = [image size].height / size.height;
    
    int fullColumns = floorf(cols);
    int fullRows = floorf(rows);
    
    CGFloat remainderWidth = [image size].width -
    (fullColumns * size.width);
    CGFloat remainderHeight = [image size].height -
    (fullRows * size.height);
    
    
    if (cols > fullColumns) fullColumns++;
    if (rows > fullRows) fullRows++;
    
    CGImageRef fullImage = [image CGImage];
    
    for (int y = 0; y < fullRows; ++y) {
        for (int x = 0; x < fullColumns; ++x) {
            CGSize tileSize = size;
            if (x + 1 == fullColumns && remainderWidth > 0) {
                // Last column
                tileSize.width = remainderWidth;
            }
            if (y + 1 == fullRows && remainderHeight > 0) {
                // Last row
                tileSize.height = remainderHeight;
            }
            
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage,
                                                                (CGRect){{x*size.width, y*size.height},
                                                                    tileSize});
            NSData *imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:tileImage]);
            NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png",
                              directoryPath, prefix, x, y];
            [imageData writeToFile:path atomically:NO];
        }
    }
}

- (void)drawRect:(CGRect)rect {
 	CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, self.frame);
    CGSize tileSize = (CGSize){256, 768};
    
    int firstCol = floorf(CGRectGetMinX(rect) / tileSize.width);
    int lastCol = floorf((CGRectGetMaxX(rect)-1) / tileSize.width);
    int firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    int lastRow = floorf((CGRectGetMaxY(rect)-1) / tileSize.height);
    
    for (int row = firstRow; row <= lastRow; row++) {
        for (int col = firstCol; col <= lastCol; col++) {
            UIImage *tile = [self tileAtCol:col row:row];
            
            CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row,
                                         tileSize.width, tileSize.height);
            
            tileRect = CGRectIntersection(self.bounds, tileRect);
            
            [tile drawInRect:tileRect];
        }
    }
}

- (UIImage*)tileAtCol:(int)col row:(int)row
{
    NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png", self.tileDirectory, self.tilePrefix, col, row];
    return [UIImage imageWithContentsOfFile:path];
}

@end
