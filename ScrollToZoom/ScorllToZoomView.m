//
//  ScorllToZoomView.m
//  ScrollToZoom
//
//  Created by robot on 3/9/16.
//  Copyright © 2016 MikeHung. All rights reserved.
//

#import "ScorllToZoomView.h"
#import "ScrollToZoomFlowLayout.h"
#import "AlbumCollectionViewCell.h"

#define Screen_W [[UIScreen mainScreen] bounds].size.width
#define Screen_H [[UIScreen mainScreen] bounds].size.height
#define isIphone4 (Screen_W == 320 && Screen_H == 480)
#define isIphone5 (Screen_W == 320 && Screen_H == 568)
#define isIphone6 (Screen_W == 375 && Screen_H == 667)
#define isIphone6p (Screen_W == 414 && Screen_H == 736)

#define kSCROLL_TOZOOM_CELLIDENTIFIER @"AlbumCollectionViewCell"
@interface ScorllToZoomView() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak)  id <ScrollToZoomDelegete> scollToZommDelegete;
@property (nonatomic,strong) UICollectionView *viewControlCollectionView;
@property (nonatomic,strong) ScrollToZoomFlowLayout *viewControllCollectionViewFlowLaout;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) NSInteger clickAtIndex;
@property (nonatomic,assign) CGFloat zoomViewItemGap;

@end

@implementation ScorllToZoomView

- (instancetype)initScorllToomViewWithFrame:(CGRect)frame andDelegete:(id<ScrollToZoomDelegete>)delegate{

    ScorllToZoomView *scrollView = [[ScorllToZoomView alloc]init];
    scrollView.frame = frame;
    scrollView.scollToZommDelegete = delegate;
    if (isIphone6)  scrollView.zoomViewItemGap = 11.0f;
    if (isIphone4 | isIphone5) scrollView.zoomViewItemGap = 11.0f;
    if (isIphone6p) scrollView.zoomViewItemGap = 15.0f;
    [scrollView setUpContentView];
    return scrollView;

}

- (void)setUpContentView{

   [self addSubview:self.viewControlCollectionView];

}
- (void)setZoomViewDataSourceArray:(NSArray *)zoomViewDataSourceArray{
    
    _zoomViewDataSourceArray = zoomViewDataSourceArray;
    [self.viewControlCollectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.zoomViewDataSourceArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AlbumCollectionViewCell *albumCell = [collectionView dequeueReusableCellWithReuseIdentifier:kSCROLL_TOZOOM_CELLIDENTIFIER forIndexPath:indexPath];
    albumCell.imagePath = self.zoomViewDataSourceArray[indexPath.item];
    return albumCell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.scollToZommDelegete respondsToSelector:@selector(scrollToZoomViewClickedIndex:)]) {
        
        [self.scollToZommDelegete scrollToZoomViewClickedIndex:indexPath.item];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGSize itemSize = self.viewControllCollectionViewFlowLaout.itemSize;
    NSInteger index = ( scrollView.contentOffset.x + self.zoomViewItemGap )/ (itemSize.width + self.zoomViewItemGap);
    if ([self.scollToZommDelegete respondsToSelector:@selector(scrollToZoomViewSelectedIndex:)]) {
        
        [self.scollToZommDelegete scrollToZoomViewSelectedIndex:index];
        
    }
}
#pragma mark -getter setter
- (ScrollToZoomFlowLayout *)viewControllCollectionViewFlowLaout{
    
    if (!_viewControllCollectionViewFlowLaout) {
        
        _viewControllCollectionViewFlowLaout = [[ScrollToZoomFlowLayout alloc]init];
        _viewControllCollectionViewFlowLaout.minimumLineSpacing = self.zoomViewItemGap;
        _viewControllCollectionViewFlowLaout.itemSize = CGSizeMake(50, 50); // 61 * 61
        CGFloat oneX = 40.0f;
        if (isIphone6) oneX = 40.0f;
        if (isIphone4 | isIphone5) oneX = 20.0f;
        if (isIphone6p) oneX = 57.0f;
        _viewControllCollectionViewFlowLaout.sectionInset = UIEdgeInsetsMake(0, oneX, 0, 0);
        _viewControllCollectionViewFlowLaout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        
    }
    return _viewControllCollectionViewFlowLaout;
    
}
- (UICollectionView *)viewControlCollectionView{
    
    if (!_viewControlCollectionView) {
        
        _viewControlCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.viewControllCollectionViewFlowLaout];
        _viewControlCollectionView.dataSource = self;
        _viewControlCollectionView.delegate = self;
        _viewControlCollectionView.backgroundColor = [UIColor whiteColor];
        [_viewControlCollectionView registerNib:[UINib nibWithNibName:kSCROLL_TOZOOM_CELLIDENTIFIER bundle:nil] forCellWithReuseIdentifier:kSCROLL_TOZOOM_CELLIDENTIFIER];
    }
    return _viewControlCollectionView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
