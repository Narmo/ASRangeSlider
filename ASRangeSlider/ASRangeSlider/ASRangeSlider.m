//
//  ASRangeSlider.m
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
//

#import "ASRangeSlider.h"
#import "SliderThumbView.h"

#ifdef RGB
#undef RGB
#endif

#ifdef RGBA
#undef RGBA
#endif

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]


FloatRange FloatRangeMake(float min, float max) {
	FloatRange toReturn;
	toReturn.min = min;
	toReturn.max = max;
	return toReturn;
}

@interface ASRangeSlider()

@property (nonatomic) FloatRange spectrum;
@property (nonatomic, strong) UIImageView *trackBackgroundView;
@property (nonatomic, strong) UIImageView *activeAreaView;
@property (nonatomic, strong) SliderThumbView *thumbOne;
@property (nonatomic, strong) SliderThumbView *thumbTwo;

@property (nonatomic) float valueOfSliderThumbOne;
@property (nonatomic) float valueOfSliderThumbTwo;

@property (nonatomic, readonly) float rightmostPointOnTrack;
@property (nonatomic, readonly) float leftmostPointOnTrack;

@end


@implementation ASRangeSlider

@synthesize leftmostPointOnTrack;
@synthesize rightmostPointOnTrack;

#pragma - Properties

- (FloatRange)value {
	float one = self.valueOfSliderThumbOne;
	float two = self.valueOfSliderThumbTwo;
	return FloatRangeMake(MIN(one, two), MAX(one, two));
}

- (void)setValue:(FloatRange)value {
	self.valueOfSliderThumbOne = value.min;
	self.valueOfSliderThumbTwo = value.max;
}

- (float)minimumValue {
	return self.spectrum.min;
}

- (float)maximumValue {
	return self.spectrum.max;
}

- (SliderThumbView *) leftmostThumb {
	if (self.valueOfSliderThumbOne <= self.valueOfSliderThumbTwo) {
		return self.thumbOne;
	}
	else {
		return self.thumbTwo;
	}
}

- (SliderThumbView *)rightmostThumb {
	if (self.valueOfSliderThumbOne >= self.valueOfSliderThumbTwo) {
		return self.thumbOne;
	}
	else {
		return self.thumbTwo;
	}
}

- (float)leftmostPointOnTrack {
	return leftmostPointOnTrack = self.trackBackgroundView.frame.origin.x;
}

- (float)rightmostPointOnTrack {
	return self.trackBackgroundView.frame.origin.x + self.trackBackgroundView.frame.size.width;
}

- (float)valueForThumb:(SliderThumbView *)thumb {
	float trackLength = self.trackBackgroundView.frame.size.width;
	float currentPoint = thumb.center.x;
    float locationPercentage = (currentPoint - self.leftmostPointOnTrack) / trackLength;
	float value = locationPercentage * (self.maximumValue - self.minimumValue) + self.minimumValue;
	return value;
}

- (void)setValue:(float)value forThumb:(SliderThumbView *)thumb {
	float toSet = MIN(self.maximumValue, value);
	toSet = MAX(self.minimumValue, value);

	if (toSet != [self valueForThumb:thumb]) {
		float valuePrecentage = (toSet - self.minimumValue) / (self.maximumValue - self.minimumValue);
		float relativePosition = valuePrecentage * (self.rightmostPointOnTrack - self.leftmostPointOnTrack);
		float newPosition = relativePosition + self.leftmostPointOnTrack;
		thumb.center = CGPointMake(newPosition, thumb.center.y);
		[self updateSubviews];
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

- (float)valueOfSliderThumbOne {
	return [self valueForThumb:self.thumbOne];
}

- (float)valueOfSliderThumbTwo {
	return [self valueForThumb:self.thumbTwo];
}

- (void)setValueOfSliderThumbOne:(float)valueOfSliderThumbOne {
	[self setValue:valueOfSliderThumbOne forThumb:self.thumbOne];
}

- (void)setValueOfSliderThumbTwo:(float)valueOfSliderThumbTwo {
	[self setValue:valueOfSliderThumbTwo forThumb:self.thumbTwo];
}

- (void)setFrame:(CGRect)aframe {
	if (!CGRectEqualToRect(self.frame, aframe)) {
		FloatRange valueNow = self.value;
		[super setFrame:aframe];
		CGRect frame = self.trackBackgroundView.frame;
		frame.size.width = aframe.size.width - (self.thumbOne.frame.size.width);
		frame.origin.x = floorf((self.bounds.size.width - frame.size.width) * 0.5f);
		frame.origin.y = floorf((self.bounds.size.height - frame.size.height) * 0.5f);
		self.trackBackgroundView.frame = frame;
		
		frame = self.activeAreaView.frame;
		frame.origin.x = floorf((self.bounds.size.width - frame.size.width) * 0.5f);
		frame.origin.y = floorf((self.bounds.size.height - frame.size.height) * 0.5f);
		self.activeAreaView.frame = frame;

		CGPoint thumbCenter = self.thumbOne.center;
		thumbCenter.y = self.bounds.size.height * 0.5f;
		self.thumbOne.center = thumbCenter;
		self.thumbOne.frame = CGRectIntegral(self.thumbOne.frame);

		thumbCenter.x = self.thumbTwo.center.x;
		self.thumbTwo.center = thumbCenter;
		self.thumbTwo.frame = CGRectIntegral(self.thumbTwo.frame);
		
		self.value = valueNow;
	}
}

#pragma - Initialization

- (id)initWithSpectrum:(FloatRange)aSpectrum {
    if ((self = [super init]) != nil) {
		self.spectrum = aSpectrum;
		
		self.trackBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"rangeslider-default"] stretchableImageWithLeftCapWidth:6 topCapHeight:0]];
		self.activeAreaView = [[UIImageView alloc] initWithFrame:_trackBackgroundView.frame];
		self.thumbOne = [[SliderThumbView alloc] init];
		self.thumbTwo = [[SliderThumbView alloc] init];
		
		[self createGestureRecognizers];
		
		[self addSubview:_trackBackgroundView];
		CGRect frame;
		frame.origin = CGPointZero;
		frame.size = _trackBackgroundView.frame.size;
		frame.size.width += self.rightmostThumb.frame.size.width;
		self.frame = frame;

		_activeAreaView.backgroundColor = RGBA(93, 177, 255, 0.5f);
		[self addSubview:_activeAreaView];
		
		frame = _activeAreaView.frame;
		frame.origin.x = floorf((_trackBackgroundView.bounds.size.width - frame.size.width) * 0.5f);
		frame.origin.y = floorf((_trackBackgroundView.bounds.size.height - frame.size.height) * 0.5f);
		_activeAreaView.frame = frame;


		[self addSubview:_thumbOne];
		self.thumbOne.center = CGPointMake(self.thumbOne.frame.size.width * 0.5f, self.frame.size.height * 0.5f);
		self.thumbOne.frame = CGRectIntegral(self.thumbOne.frame);
		
		[self addSubview:_thumbTwo];
		self.thumbTwo.center = CGPointMake(self.frame.size.width - self.thumbTwo.frame.size.width * 0.5f, self.frame.size.height * 0.5f);
		self.thumbTwo.frame = CGRectIntegral(self.thumbTwo.frame);

		self.value = FloatRangeMake(self.minimumValue, self.maximumValue);
    }
    return self;
}

- (void)createGestureRecognizers {
	UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.thumbOne addGestureRecognizer:pgr];

	pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.thumbTwo addGestureRecognizer:pgr];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
	SliderThumbView *sender = (SliderThumbView *)recognizer.view;
	if ((recognizer.state == UIGestureRecognizerStateChanged) || (recognizer.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [recognizer translationInView:self];
		// New location before limitations
        CGFloat newXPoint = sender.center.x + translation.x;
		
		// Applying the limitations
        newXPoint = MIN(newXPoint, self.rightmostPointOnTrack);
        newXPoint = MAX(newXPoint, self.leftmostPointOnTrack);

		float relativePosition = (newXPoint - self.leftmostPointOnTrack) / (self.rightmostPointOnTrack - self.leftmostPointOnTrack);
		float value = (relativePosition * (self.maximumValue - self.minimumValue) + self.minimumValue);

		[self setValue:value forThumb:sender];
		// Resetting
        [recognizer setTranslation:CGPointZero inView:self];
    }
}

- (void)updateSubviews {
	self.activeAreaView.frame = CGRectMake(
										   floorf(self.rightmostThumb.center.x),
										   floorf(_activeAreaView.frame.origin.y),
										   floorf(self.leftmostThumb.center.x - self.rightmostThumb.center.x),
										   floorf(self.activeAreaView.frame.size.height)
										   );
}

- (void)setTrackBackgroundImage:(UIImage *)image {
	self.trackBackgroundView.image = image;
}

- (void)setThumbBackgroundImage:(UIImage *)image {
	[self.thumbOne setBackgroundImage:image];
	[self.thumbTwo setBackgroundImage:image];
}

- (void)setActiveAreaBackgroundImage:(UIImage *)image {
	self.activeAreaView.image = image;
}

- (void)dealloc {
	self.trackBackgroundView = nil;
	self.activeAreaView = nil;
	self.thumbOne = nil;
	self.thumbTwo = nil;
}

@end
