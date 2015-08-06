//
//  MainViewController.h
//  e-Model
//
//  Created by 魏众 on 15/7/20.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate>
{
    UISegmentedControl *_segment;
    UIScrollView *_scrollView;
}

@property (nonatomic, retain)NSMutableArray *headerArray;
@property (nonatomic, retain)NSMutableArray *modelArray;
@end
