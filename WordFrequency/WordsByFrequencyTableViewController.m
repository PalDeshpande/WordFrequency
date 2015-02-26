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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
