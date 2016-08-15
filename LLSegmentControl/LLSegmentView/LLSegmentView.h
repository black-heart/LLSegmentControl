//
//  LLSegmentView.h
//  LLSegmentControl
//
//  Created by lll on 16/8/13.
//  Copyright © 2016年 llliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLSegmentViewDelegate <NSObject>

- (void)segmentViewButtonPress:(int)index;

@end


@interface LLSegmentView : UIView

@property (nonatomic, strong) id<LLSegmentViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selected;
@property (nonatomic, assign) CGFloat top;

- (instancetype)initWithButtonTitles:(NSArray*)titles;

- (void)setButtonTitle:(NSString*)title tag:(NSInteger)tag;

- (void)updateButtonTitles:(NSArray*)titles;

@end
