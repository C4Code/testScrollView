//
//  C4WorkSpace.m
//  testScrollView
//
//  Created by moi on 12-11-12.
//  Copyright (c) 2012 moi. All rights reserved.
//

#import "C4WorkSpace.h"
#import "C4TiledView.h"


#pragma mark Single Scrollview
/* uncomment this block and comment out the next
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
 */

#pragma mark 3 Scrollviews
/* comment everything out from here onwards, including the @end */
@implementation C4WorkSpace {
    UIScrollView *backScrollview, *middleScrollview, *frontScrollview;
}

-(void)setup {
    C4TiledView *front, *middle, *back;
    
    frontScrollview = [[UIScrollView alloc] initWithFrame:self.canvas.bounds];
    front = [C4TiledView tiledViewWithName:@"front"];
    [frontScrollview addSubview:front];
    frontScrollview.contentSize = front.frame.size;
    
    middleScrollview = [[UIScrollView alloc] initWithFrame:self.canvas.bounds];
    middle = [C4TiledView tiledViewWithName:@"middle"];
    [middleScrollview addSubview:middle];
    middleScrollview.contentSize = middle.frame.size;
    
    backScrollview = [[UIScrollView alloc] initWithFrame:self.canvas.bounds];
    back = [C4TiledView tiledViewWithName:@"back.png"];
    [backScrollview addSubview:back];
    backScrollview.contentSize = back.frame.size;
    
    [self.canvas addSubview:backScrollview];
    [self.canvas addSubview:middleScrollview];
    [self.canvas addSubview:frontScrollview];
    
    [frontScrollview addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    back = nil;
    middle = nil;
    front = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if((UIScrollView *)object == frontScrollview) {
        middleScrollview.contentOffset = CGPointMake(frontScrollview.contentOffset.x/2,0);
        backScrollview.contentOffset = CGPointMake(frontScrollview.contentOffset.x/4,0);
    }
}

@end
/* until here */