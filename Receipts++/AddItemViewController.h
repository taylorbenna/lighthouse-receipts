//
//  AddItemViewController.h
//  Receipts++
//
//  Created by Taylor Benna on 2016-05-26.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewItemMessenger <NSObject>

-(void)receiveMessage:(NSString *)note andAmount:(NSDecimalNumber *)amount andDate:(NSDate *)date andCats:(NSSet *)cats;

@end

@interface AddItemViewController : UIViewController

@property (nonatomic, weak) id<NewItemMessenger> delegate;

@end
