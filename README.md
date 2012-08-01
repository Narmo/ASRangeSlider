This project provides an implementation of a UI Control in iOS: DoubleValueSlider.

The Double Slider is similar to regular UISlider except that it has two thumbs you can slide instead of only one.

The purpose of this custom slider is to provide mechanism for getting input from the user that represents a range.

For example, if you want the user to specify a budget frame in order to search for products that their price is in the user's price range, you can use this slider. The leftmost thumb will represent the minimum value, and the rightmost thumb will represent the maximum value.

The DoubleValueSlider is a subclass of UIControl in order to provide the developer all the convinient methods that are part of UIControl, and also provide the ability to easily use this Slider inside Interface Builder. From the UI point of view, this class provides a very nice looking and highly customizable UI component that can be easily matched to any graphic theme.

![ASRangeSlider screenshot](https://raw.github.com/Narmo/ASRangeSlider/master/asrangeslider-example.png)