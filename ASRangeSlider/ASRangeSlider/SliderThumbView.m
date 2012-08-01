//
//  SliderThumbView.m
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
//

#import "SliderThumbView.h"

@interface SliderThumbView()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *backgroundView;

@end


@implementation SliderThumbView

- (id)initWithBackgroundImage:(UIImage *)background {
    if ((self = [super init]) != nil) {
        [self setBackgroundImage:background];
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:self.frame];
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.textColor = [UIColor whiteColor];
		textLabel.adjustsFontSizeToFitWidth = YES;
		textLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:textLabel];
		self.textLabel = textLabel;
	}
    return self;
}

- (id)init {
	self = [self initWithBackgroundImage:[UIImage imageNamed:@"rangeslider-pin"]];
	return self;
}

- (void)setBackgroundImage:(UIImage *)image {
	UIImageView *newOne = [[UIImageView alloc] initWithImage:image];

	CGPoint center = self.center;
	self.frame = newOne.frame;
	self.center = center;
	self.frame = CGRectIntegral(self.frame);
	[self.backgroundView removeFromSuperview];
	self.backgroundView = newOne;
	
	[self addSubview:self.backgroundView];

	
	CGRect frame = self.backgroundView.frame;
	frame.origin.x = floorf((self.bounds.size.width - frame.size.width) * 0.5f);
	frame.origin.y = floorf((self.bounds.size.height - frame.size.height) * 0.5f);
	self.backgroundView.frame = frame;
	self.textLabel.frame = frame;
	[self bringSubviewToFront:self.textLabel];
}

- (void)dealloc {
	self.textLabel = nil;
	self.backgroundView = nil;
}

@end
