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
        [self createBgImage];
        [self createInfo];
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

- (void)createInfo
{
    UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, self.frame.size.width - 100, self.frame.size.height - 100)];
    lblInfo.font = [UIFont fontWithName:FONT_HELVETICANEUE size:16];
    lblInfo.textColor = [UIColor enrouteLightYellowColor];
    lblInfo.text = self.text;
    lblInfo.numberOfLines = 0;
    [self addSubview:lblInfo];
}


@end
