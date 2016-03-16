//
//  ScorllToZoomView.h
//  ScrollToZoom
//
//  Created by robot on 3/9/16.
//  Copyright © 2016 MikeHung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollToZoomDelegete <NSObject>

@optional

- (void)scrollToZoomViewSelectedIndex:(NSInteger)selectIndex;
- (void)scrollToZoomViewClickedIndex:(NSInteger)clickedIndex;

@end
@interface ScorllToZoomView : UIView
@property (nonatomic,strong) NSArray *zoomViewDataSourceArray;

- (instancetype)initScorllToomViewWithFrame:(CGRect)frame andDelegete:(id <ScrollToZoomDelegete>)delegate;

@end
