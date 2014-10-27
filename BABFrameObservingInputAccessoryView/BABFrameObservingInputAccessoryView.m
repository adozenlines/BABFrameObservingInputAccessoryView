//
//  BABFrameObservingInputAccessoryView.m
//
//  Created by Bryn Bodayle on October/21/2014.
//  Copyright (c) 2014 Bryn Bodayle. All rights reserved.
//

#import "BABFrameObservingInputAccessoryView.h"

@interface BABFrameObservingInputAccessoryView()

@property (nonatomic, assign, getter=isObserverAdded) BOOL observerAdded;

@end

@implementation BABFrameObservingInputAccessoryView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)dealloc {
    
    if(_observerAdded) {
        
        NSString *observationKeyPath = [self observationKeyPath];
        [self.superview removeObserver:self forKeyPath:observationKeyPath];
    }
}

#pragma mark - Setters & Getters

- (CGRect)inputAcesssorySuperviewFrame {
    
    return self.superview.frame;
}

#pragma mark - Overwritten Methods

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    NSString *keyPath = [self observationKeyPath];
    
    if(self.isObserverAdded) {
        
        [self.superview removeObserver:self forKeyPath:keyPath];
    }
    
    [newSuperview addObserver:self forKeyPath:keyPath options:0 context:NULL];
    self.observerAdded = YES;
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - Observation

- (NSString *)observationKeyPath {
    
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? @"center" : @"frame";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSString *observationKeyPath = [self observationKeyPath];
    
    if (object == self.superview && [keyPath isEqualToString:observationKeyPath]) {
        
        if(self.inputAcessoryViewFrameChangedBlock) {
            
            CGRect frame = self.superview.frame;
            self.inputAcessoryViewFrameChangedBlock(frame);
        }
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.superview.frame;
    self.inputAcessoryViewFrameChangedBlock(frame);
}

@end
