//
//  ScrollToZoomFlowLayout.m
//  ScrollToZoom
//
//  Created by robot on 3/8/16.
//  Copyright © 2016 MikeHung. All rights reserved.
//

#import "ScrollToZoomFlowLayout.h"

#define Screen_W [[UIScreen mainScreen] bounds].size.width
#define Screen_H [[UIScreen mainScreen] bounds].size.height
#define isIphone4 (Screen_W == 320 && Screen_H == 480)
#define isIphone5 (Screen_W == 320 && Screen_H == 568)
#define isIphone6 (Screen_W == 375 && Screen_H == 667)
#define isIphone6p (Screen_W == 414 && Screen_H == 736)

@implementation ScrollToZoomFlowLayout

- (void)prepareLayout{

    [super prepareLayout];

}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    CGFloat itemX = self.collectionView.contentOffset.x;
    CGFloat itemY = 0;
    CGFloat itemW = self.collectionView.frame.size.width;
    CGFloat itemH = self.collectionView.frame.size.height;
    CGRect  visiableRect = CGRectMake(itemX, itemY, itemW, itemH);
    
    NSArray *layoutAttributeArray = [super layoutAttributesForElementsInRect:visiableRect];
    
    int i = 0;
    for (UICollectionViewLayoutAttributes *layoutAttribute in layoutAttributeArray) {
        
        // 在这里改变图片的fram属性;
        // 1.获取图片中心点到CollectionView左侧的距离
        CGFloat itemLeftX = layoutAttribute.center.x - self.collectionView.contentOffset.x;
        // 2.获取CollectionView中心点的距离
        CGFloat collecionViewCenterX = self.collectionView.frame.size.width * 0.5 ;
        // 3.两者相减得到item距离中心的距离
        CGFloat deltaLength = fabs(itemLeftX - collecionViewCenterX);
        // 4.获取之间的比例,左右的小于1,中间的等于1.
        CGFloat scaleFactor = 1 - deltaLength / collecionViewCenterX;
        NSInteger changeIndex = layoutAttributeArray.count / 2 ;
        CGFloat resultScale = 1;
        
        if (i == changeIndex && layoutAttributeArray.count % 2) {
            
            resultScale  = scaleFactor * 0.2 + 1;
            
        }else if (i == (changeIndex - 1) && layoutAttributeArray.count %2 == 0)
        {
            resultScale = scaleFactor * 0.2 + 1;
            
        }
        
        layoutAttribute.transform = CGAffineTransformMakeScale(resultScale , resultScale);
        i ++;
    }
    return layoutAttributeArray;

}

// 在滑动结束时候会调用的
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    CGFloat itemX = self.collectionView.contentOffset.x;
    CGFloat itemY = 0;
    CGFloat itemW = self.collectionView.frame.size.width;
    CGFloat itemH = self.collectionView.frame.size.height;
    CGRect  visiableRect = CGRectMake(itemX, itemY, itemW, itemH);
    
    NSArray *layoutAttributeArray = [super layoutAttributesForElementsInRect:visiableRect];
    CGFloat proposedContentX = MAXFLOAT ;
    for (UICollectionViewLayoutAttributes *layoutAttribute in layoutAttributeArray) {
        
        // 1.获取图片中心点到CollectionView左侧的距离
        CGFloat itemLeftX = layoutAttribute.center.x - proposedContentOffset.x;
        // 2.获取CollectionView中心点的距离
        CGFloat collecionViewCenterX = 375 * 0.5;
        // 3. 获取距离中心的距离
        CGFloat distanceDelat = fabs(collecionViewCenterX - itemLeftX);
        // 4.获取之间的比例,左右的小于1,中间的等于1.
        if (distanceDelat < proposedContentX) {
            
            proposedContentX = collecionViewCenterX - itemLeftX;
        }
        
    }
    CGFloat appendingDis = 0; // Bigger to left.
    if (isIphone5 | isIphone4) appendingDis = - 35;
    if (isIphone6p) appendingDis = - 18;
    proposedContentOffset.x = proposedContentOffset.x - proposedContentX + appendingDis;
    return proposedContentOffset;

}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds // return YES to cause the collection view to requery the layout for geometry information
{
    [super shouldInvalidateLayoutForBoundsChange:newBounds];
    return YES;
}
- (CGSize)collectionViewContentSize{

    return [super collectionViewContentSize];
}

@end
