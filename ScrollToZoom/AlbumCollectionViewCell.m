//
//  AlbumCollectionViewCell.m
//  发现界面demo
//
//  Created by 谷志超 on 16/1/12.
//  Copyright © 2016年 MBM. All rights reserved.
//

#import "AlbumCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface AlbumCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@end
@implementation AlbumCollectionViewCell


- (void)awakeFromNib {
    
    //设置背景
    self.layer.cornerRadius = self.imageView1.frame.size.height * 0.5;
    self.layer.masksToBounds = YES;
    
}

- (void)setImagePath:(NSString *)imagePath{

    _imagePath = imagePath;
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    
}
@end
