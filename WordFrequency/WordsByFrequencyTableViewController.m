//
//  WordsByFrequencyTableViewController.m
//  WordFrequency
//
//  Created by Pallavi Keskar on 2/25/15.
//  Copyright (c) 2015 Pallavi Keskar. All rights reserved.
//

#import "WordsByFrequencyTableViewController.h"

@interface WordsByFrequencyTableViewController ()
@property (strong, nonatomic) NSArray *blockSortedKeys;
@end

@implementation WordsByFrequencyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sortWordsByFrequency:self.wordsWithFrequency];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper method

- (void)sortWordsByFrequency: (NSMutableDictionary *)dictionary
{
    self.blockSortedKeys = [[NSArray alloc] init];
    self.blockSortedKeys = [dictionary keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSLog(@"sorted words, @%@", self.blockSortedKeys);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (self.noOfWordsToReturn > [self.wordsWithFrequency count]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"word count" message:[NSString stringWithFormat:@"No. of words requested is too large, returning %i words", self.noOfWordsToReturn] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return [self.wordsWithFrequency count];
    }
    else
    {
        return self.noOfWordsToReturn;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *word = self.blockSortedKeys[indexPath.row];
    cell.textLabel.text = word;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Frequency :%@",[[self.wordsWithFrequency objectForKey:word] stringValue]];
    
    return cell;
}

@end
