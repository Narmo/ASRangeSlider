//
//  SliderThumbView.h
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
//

#import <UIKit/UIKit.h>

static inline CGPoint centerOfBounds(UIView *view) {
	return CGPointMake((view.bounds.size.width - view.bounds.origin.x) * 0.5f, (view.bounds.size.height - view.bounds.origin.y) * 0.5f);
}

@interface SliderThumbView : UIView

@property (nonatomic, readonly, strong) UIImageView *backgroundView;
@property (nonatomic, readonly, strong) UILabel *textLabel;

- (id)init;
- (id)initWithBackgroundImage:(UIImage *)background;
- (void)setBackgroundImage:(UIImage *)image;

@end
