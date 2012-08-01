//
//  ASRangeSliderViewController.m
//  ASRangeSlider
//
//  Created by Avraham Shukron on 6/9/11.
//

#import "ASRangeSliderViewController.h"
#import "ASRangeSlider.h"

@implementation ASRangeSliderViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	CGRect frame;
	frame.origin = CGPointZero;
	
	// default slider
	slider0 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(0.0f, 5.0f)];
	slider0.frame = CGRectMake(10.0f, 20.0f, 300.0f, 30.0f);
	slider0.value = FloatRangeMake(1.0f, 3.9f);
	[self.view addSubview:slider0];
	
	// variants
	slider1 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(0.0f, 5.0f)];
	[slider1 setThumbBackgroundImage:[UIImage imageNamed:@"slider-handle"]];
	slider1.frame = CGRectMake(10.0f, 70.0f, 300.0f, 30.0f);
	slider1.value = FloatRangeMake(1.0f, 3.9f);
	[self.view addSubview:slider1];
	
	slider2 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(0.0f, 20.0f)];
	[slider2 setThumbBackgroundImage:[UIImage imageNamed:@"glass-round-red-green-button"]];
	slider2.frame = CGRectMake(10.0f, 120.0f, 300.0f, 30.0f);
	slider2.value = FloatRangeMake(5.0f, 15.0f);
	[slider2 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:slider2];
	[self sliderValueChanged:slider2];
	
	slider3 = [[ASRangeSlider alloc] initWithSpectrum:FloatRangeMake(1.0f, 10.0f)];
	[slider3 setThumbBackgroundImage:[UIImage imageNamed:@"blank-button-round-blue"]];
	slider3.frame = CGRectMake(10.0f, 170.0f, 300.0f, 30.0f);
	slider3.value = FloatRangeMake(1.0f, 10.0f);
	[slider3 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:slider3];
	[self sliderValueChanged:slider3];
}

- (void)sliderValueChanged:(ASRangeSlider *)sender {
	FloatRange r = sender.value;
	sender.leftmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.min];
	sender.rightmostThumb.textLabel.text = [NSString stringWithFormat:@"%.2f", r.max];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	slider0 = nil;
	slider1 = nil;
	slider2 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
