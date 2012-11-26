//
//  C4WorkSpace.m
//  testScrollView
//
//  Created by moi on 12-11-12.
//  Copyright (c) 2012 moi. All rights reserved.
//

#import "C4WorkSpace.h"
#import "C4TiledView.h"

@implementation C4WorkSpace {
    UIScrollView *scrollView;
    C4TiledView *tiledView;
}

-(void)setup {
    
    for(int i = 0 ; i < 30; i++) {
        NSString *imageName = [NSString stringWithFormat:@"myImage_%d.png",i];
        C4Image *newImage = [C4Image imageNamed:imageName];
        [self.canvas addImage:newImage];
        newImage.origin = CGPointMake(10, 10);
    }
}

//-(void)setup {
//	tiledView = [C4TiledView tiledViewWithName:@"scroll.png"];
//    
//    scrollView = [[UIScrollView alloc] initWithFrame:self.canvas.frame];
//    scrollView.contentSize = tiledView.frame.size;
//    [scrollView addSubview:tiledView];
//    
//    [self.canvas addSubview:scrollView];
//}
//					
@end
