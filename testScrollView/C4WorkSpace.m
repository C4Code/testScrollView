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
	tiledView = [C4TiledView tiledViewWithName:@"scroll.png"];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.canvas.frame];
    scrollView.contentSize = tiledView.frame.size;
    [scrollView addSubview:tiledView];
    
    [self.canvas addSubview:scrollView];
}
					
@end
