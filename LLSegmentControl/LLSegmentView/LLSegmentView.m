//
//  LLSegmentView.m
//  LLSegmentControl
//
//  Created by lll on 16/8/13.
//  Copyright © 2016年 llliu. All rights reserved.
//

#import "LLSegmentView.h"
#define HighLightedColor  [UIColor blackColor]
#define CommonColor       [UIColor lightGrayColor]
@interface LLSegmentView ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, strong) NSMutableArray* buttons;
@property (nonatomic, strong) UIView *highLightedLine;
@property (nonatomic, strong) UIView *commonLine;

@end

@implementation LLSegmentView

- (instancetype)initWithButtonTitles:(NSArray*)titles {
    self = [super init];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    _width       = CGRectGetWidth(frame);
    _scale       = _width/320.;
    _top         = 64;
    _selected    = 0;
    
    self.frame = CGRectMake(0, 64, _width, 40*_scale);
    
    self.backgroundColor = [UIColor whiteColor];
    
    int n = (int)titles.count;
    
    _buttons = [NSMutableArray new];
    
    UIButton* button = nil;
    
    for (int i = 0; i < titles.count; i++) {
        button = [[UIButton alloc] initWithFrame:CGRectMake(i*_width/n,
                                                            6*_scale,
                                                            _width/n,
                                                            30*_scale)];
        button.tag = i;
        
        if (i == 0) {
            [button setTitleColor:HighLightedColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        } else {
            [button setTitleColor:CommonColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        }
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [_buttons addObject:button];
    }
    [self highLightedLine];
    [self commonLine];
    return self;
}

- (void)setSelected:(NSInteger)selected {
    _selected = selected;
    
    CGRect frame         = self.highLightedLine.frame;
    frame.origin.x       = selected*_width/_buttons.count;
    self.highLightedLine.frame = frame;

    int i = 0;
    for (UIButton* button in _buttons) {
        if (i == selected) {
            [button setTitleColor:HighLightedColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        } else {
            [button setTitleColor:CommonColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        }
        i++;
    }
}

- (void)setTop:(CGFloat)top {
    _top           = top;
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}

- (UIView*)highLightedLine {
    if (_highLightedLine == nil) {
        _highLightedLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   37*_scale,
                                                                   _width/_buttons.count,
                                                                   3*_scale)];
        _highLightedLine.backgroundColor = HighLightedColor;
        [self addSubview:_highLightedLine];
    }
    return _highLightedLine;
}

- (UIView*)commonLine {
    if (_commonLine == nil) {
        _commonLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  40*_scale-0.5,
                                                                  _width,
                                                                  0.5)];
        _commonLine.backgroundColor = CommonColor;
        [self addSubview:_commonLine];
    }
    return _commonLine;
}


- (void)buttonPress:(id)sender {
    NSInteger tag = [sender tag];
    self.selected = tag;
    
    if (_delegate) {
        [_delegate segmentViewButtonPress:(int)tag];
    }
}

- (void)setButtonTitle:(NSString*)title tag:(NSInteger)tag {
    if (_buttons && _buttons.count > 0 && tag < _buttons.count) {
        UIButton* button = [_buttons objectAtIndex:tag];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)updateButtonTitles:(NSArray *)titles {
    for (int i = 0; i < _buttons.count && i < titles.count; i++) {
        UIButton* button = [_buttons objectAtIndex:i];
        NSString* title  = [titles objectAtIndex:i];
        [button setTitle:title forState:UIControlStateNormal];
    }
}


@end
