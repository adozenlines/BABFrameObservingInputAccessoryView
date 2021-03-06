//
//  ViewController.m
//
//  Created by Bryn Bodayle on October/21/2014.
//  Copyright (c) 2014 Bryn Bodayle. All rights reserved.
//

#import "ViewController.h"
#import "BABFrameObservingInputAccessoryView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarContainerVerticalSpacingConstraint;

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        
    BABFrameObservingInputAccessoryView *inputView = [[BABFrameObservingInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    inputView.userInteractionEnabled = NO;
    
    self.textField.inputAccessoryView = inputView;
    
    __weak typeof(self)weakSelf = self;
    
    inputView.inputAcessoryViewFrameChangedBlock = ^(CGRect inputAccessoryViewFrame){
        
        CGFloat value = CGRectGetHeight(weakSelf.view.frame) - CGRectGetMinY(inputAccessoryViewFrame) - CGRectGetHeight(weakSelf.textField.inputAccessoryView.frame);
        
        weakSelf.toolbarContainerVerticalSpacingConstraint.constant = MAX(0, value);
        
        [weakSelf.view layoutIfNeeded];

    };
}

#pragma mark - Button Targets

- (IBAction)dismiss:(id)sender {
    
    [self.textField resignFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = @"Cell";
    
    return cell;
}

@end
