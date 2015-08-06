//
//  MessageTableViewCell.h
//  e-Model
//
//  Created by 魏众 on 15/8/4.
//  Copyright (c) 2015年 EMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
