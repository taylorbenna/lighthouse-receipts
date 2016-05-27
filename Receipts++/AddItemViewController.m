//
//  AddItemViewController.m
//  Receipts++
//
//  Created by Taylor Benna on 2016-05-26.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSMutableSet *cats;

@property (weak, nonatomic) IBOutlet UITextField *amountText;
@property (weak, nonatomic) IBOutlet UITextField *noteText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = @[@"Personal",@"Family",@"Business"];
    self.cats = [[NSMutableSet alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"catCell"];
    cell.textLabel.text = self.categories[indexPath.row];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Categories";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.cats addObject:@(indexPath.row)];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.cats removeObject:@(indexPath.row)];
}

- (IBAction)doneButtonPressed:(UIButton *)sender {
    
    NSString *note = self.noteText.text;
    NSDecimalNumber *amount = [[NSDecimalNumber alloc] initWithFloat:[self.amountText.text floatValue]];
    NSDate *date = self.datePicker.date;

    [self.delegate receiveMessage:note andAmount:amount andDate:date andCats:self.cats];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


@end
