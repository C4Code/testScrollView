//
//  C4TiledView.h
//  scrolling
//
//  Created by moi on 12-11-12.
//  Copyright (c) 2012 moi. All rights reserved.
//

#import "C4View.h"

@interface C4TiledView : C4View
@property (readonly, nonatomic, strong) NSString *tilePrefix, *tileDirectory;
+(C4TiledView *)tiledViewWithName:(NSString *)imageName;
-(id)initWithImageName:(NSString *)imageName;
- (UIImage*)tileAtCol:(int)col row:(int)row;
@end
