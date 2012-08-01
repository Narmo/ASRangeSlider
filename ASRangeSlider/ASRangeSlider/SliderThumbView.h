//
//  SliderThumbView.h
//  Diamond App
//
//  Created by Avraham Shukron on 5/29/11.
//

#import <UIKit/UIKit.h>

@interface SliderThumbView : UIView

@property (nonatomic, readonly, strong) UIImageView *backgroundView;
@property (nonatomic, readonly, strong) UILabel *textLabel;

- (id)init;
- (id)initWithBackgroundImage:(UIImage *)background;
- (void)setBackgroundImage:(UIImage *)image;

@end
