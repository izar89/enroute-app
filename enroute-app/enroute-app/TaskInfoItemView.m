//
//  TaskInfoView.m
//  enroute-app
//
//  Created by Stijn Heylen on 14/06/14.
//  Copyright (c) 2014 Stijn Heylen. All rights reserved.
//

#import "TaskInfoItemView.h"

@interface TaskInfoItemView()
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imageName;
@end

@implementation TaskInfoItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if(self.imageName.length != 0){
            [self createBgImage];
            [self createSmallInfo];
            NSLog(@"small");
        } else {
            [self createBigInfo];
            NSLog(@"big");
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text imageName:(NSString *)imageName
{
    self.text = text;
    self.imageName = imageName;
    return [self initWithFrame:frame];
}

- (void)createBgImage
{
    UIImage *bgImage = [UIImage imageNamed:self.imageName];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    bgImageView.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    [self addSubview:bgImageView];
}

- (void)createSmallInfo
{
    UIFont *font = [UIFont fontWithName:FONT_HELVETICANEUE_MEDIUM size:18];
    CGRect textRect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width / 2, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    UILabel *lblInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(155, 50, textRect.size.width, textRect.size.height)];
    lblInfo1.font = font;
    lblInfo1.textColor = [UIColor enrouteLightYellowColor];
    lblInfo1.text = self.text;
    lblInfo1.numberOfLines = 0;
    [self addSubview:lblInfo1];
}

- (void)createBigInfo
{
    UIFont *font = [UIFont fontWithName:FONT_HELVETICANEUE_MEDIUM size:18];
    CGRect textRect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 96, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    UILabel *lblInfo2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 50, textRect.size.width, textRect.size.height)];
    lblInfo2.font = font;
    lblInfo2.textColor = [UIColor enrouteLightYellowColor];
    lblInfo2.text = self.text;
    lblInfo2.numberOfLines = 0;
    [self addSubview:lblInfo2];
}


@end
