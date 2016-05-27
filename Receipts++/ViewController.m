//
//  ViewController.m
//  Receipts++
//
//  Created by Taylor Benna on 2016-05-26.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "ViewController.h"
#import "AddItemViewController.h"
#import "ReceiptCell.h"
#import "Receipts+CoreDataProperties.h"
#import "Tag+CoreDataProperties.h"
#import <CoreData/CoreData.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NewItemMessenger>

@property (nonatomic) NSMutableArray *receipts;
@property (nonatomic) NSMutableArray *tags;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.receipts = [[NSMutableArray alloc] init];
    self.tags = [[NSMutableArray alloc] init];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipts"];
    
    NSError *error;
    self.receipts = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.tags = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (self.tags.count == 0) {
        Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
        tag.tagName = @"Personal";
        
        Tag *tag2 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
        tag2.tagName = @"Family";
        
        Tag *tag3 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
        tag3.tagName = @"Business";
        
        [self.managedObjectContext save:&error];
    }
}

-(void)receiveMessage:(NSString *)note andAmount:(NSDecimalNumber *)amount andDate:(NSDate *)date andCats:(NSSet *)cats{
    
    Receipts *newRec = [NSEntityDescription insertNewObjectForEntityForName:@"Receipts" inManagedObjectContext:self.managedObjectContext];
    newRec.note = note;
    newRec.amount = amount;
    newRec.timeStamp = date;

    [self.receipts addObject:newRec];
    
    for (NSNumber *num in cats) {
        Tag *tag = [self.tags objectAtIndex:[num integerValue]];
        [newRec addTagsObject:tag];
    }
    
    
    NSError *error;
    [self.managedObjectContext save:&error];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tags.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Tag *tag = self.tags[section];
    return tag.tagName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Tag *tag = self.tags[section];

    return tag.receipts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptCell * cell = [tableView dequeueReusableCellWithIdentifier:@"receiptCell"];
    
    Tag *tag = self.tags[indexPath.section];
    NSArray *recs = [tag.receipts allObjects];
    Receipts *rec = recs[indexPath.row];
    
    cell.noteLabel.text = rec.note;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAdd"]) {
        AddItemViewController *theController = segue.destinationViewController;
        theController.delegate = self;
    }
}

@end
