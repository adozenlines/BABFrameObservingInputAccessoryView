BABFrameObservingInputAccessoryView
===================================

A simple view which allows for an iOS Messages style keyboard input view and panning behavior. 

![Sample Project](http://www.brynbodayle.com/Files/BABFrameObservingInputAccessoryView.gif)

Supports iOS 7.0+

* Free of method swizzling
* No associated objects or other runtime hacks
* Works easily with or without Auto Layout

This is a UIView subclass which allows for observing the frame of a UITextView or UITextField's inputAcessoryView. This allows your to keep the text field above the keyboard as it moves. Also this allows for interactive keyboard dismissal using UIScrollView's keyboardDismissMode property.

### Sample Code & Usage

Here is a sample viewDidLoad implementation.
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        
    BABFrameObservingInputAccessoryView *inputView = [[BABFrameObservingInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    inputView.userInteractionEnabled = NO;
    
    self.textField.inputAccessoryView = inputView;
    
    __weak typeof(self)weakSelf = self;
    
    inputView.inputAcessoryViewFrameChangedBlock = ^(CGRect frame){
        
        CGFloat value = CGRectGetHeight(weakSelf.view.frame) - CGRectGetMinY(weakSelf.textField.inputAccessoryView.superview.frame) - CGRectGetHeight(weakSelf.textField.inputAccessoryView.frame);
        
        weakSelf.toolbarContainerVerticalSpacingConstraint.constant = MAX(0, value);
        
        [weakSelf.view layoutIfNeeded];

    };
}
```
