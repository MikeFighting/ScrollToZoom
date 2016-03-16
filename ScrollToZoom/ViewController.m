//
//  ViewController.m
//  ScrollToZoom
//
//  Created by robot on 3/8/16.
//  Copyright © 2016 MikeHung. All rights reserved.
//

#import "ViewController.h"
#import "ScorllToZoomView.h"

@interface ViewController ()<ScrollToZoomDelegete>
@property (nonatomic,strong) UILabel *indicatorLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.view addSubview:self.viewControlCollectionView];
    
    CGRect zoomRect = CGRectMake(0, 100, self.view.frame.size.width, 70);
    ScorllToZoomView *scrollToZoomView = [[ScorllToZoomView alloc]initScorllToomViewWithFrame:zoomRect andDelegete:self];
    // Inorder to scroll all the items, you should add two nil itmes to front and three items in the end
    scrollToZoomView.zoomViewDataSourceArray = @[@"",@"",@"http://img.popoho.com/allimg/130603/1601105450-5.jpg",@"http://tupian.qqjay.com/tou3/2016/0221/5d3228bf6e4dfb03f80c180da062cc06.png",@"http://img.name2012.com/uploads/allimg/2015-09/10-010850_870.jpg",@"http://img1.hao661.com/uploads/allimg/c141030/1414634122SR0-123J64.jpg",@"http://img.popoho.com/allimg/130603/1601105450-5.jpg",@"http://tupian.qqjay.com/tou3/2016/0221/5d3228bf6e4dfb03f80c180da062cc06.png",@"",@"",@""];
    [self.view addSubview:scrollToZoomView];
    
    CGFloat indicatorW = 2;
    CGFloat indicatorX = (self.view.frame.size.width - indicatorW) * 0.5;
    CGFloat indicatorH = 30;
    CGFloat indicatorY = scrollToZoomView.frame.origin.y + scrollToZoomView.frame.size.height;
    
    UIView *indicatorView = [[UIView alloc]initWithFrame:CGRectMake(indicatorX, indicatorY, indicatorW, indicatorH)];
    indicatorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:indicatorView];
    
    self.indicatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, scrollToZoomView.frame.origin.y + scrollToZoomView.frame.size.height + 30, self.view.frame.size.width, 20)];
    self.indicatorLabel.backgroundColor = [UIColor cyanColor];
    self.indicatorLabel.text = @"SELECTED 0";
    self.indicatorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.indicatorLabel];
}
- (void)scrollToZoomViewClickedIndex:(NSInteger)clickedIndex{

    NSString *alertString = [NSString stringWithFormat:@"click at index == %ld",clickedIndex - 2];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    

    
}
- (void)scrollToZoomViewSelectedIndex:(NSInteger)selectIndex{
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"SELECTED %ld",selectIndex + 1]];
    NSRange range = NSMakeRange(mutableString.length - 1, 1);
    [mutableString addAttributes:@{NSForegroundColorAttributeName :[UIColor redColor]} range:range];
    
    self.indicatorLabel.attributedText = mutableString;

}
- (void)didReceiveMemoryWarning {
    
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
