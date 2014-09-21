//
//  MasterViewController.m
//  iOSNorthwind
//
//  Created by Tony on 24/05/2014.
//  Copyright (c) 2014 com.dobrev.iosnorthwind. All rights reserved.
//

#import "MasterViewController.h"
#import <EverliveSDK/EverliveSDK.h>
#import "Categories.h"

#import "DetailViewController.h"

@interface MasterViewController () {
}
@property(strong, nonatomic) NSMutableArray *_categories;

@end



@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.navigationItem.title = @"Categories";
    
    self._categories = [[NSMutableArray alloc]init];
    
    
    
        self.categoriesTableView.dataSource = self;
        
    self.tableView.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    [dataStore fetchAll:[Categories class] block:^(NSArray *result, NSError *error) {
        if(error) {
            NSLog(@"Error occured %@", error);
        }
        else {
            [self._categories addObjectsFromArray:result];
            [self.categoriesTableView reloadData];
        }
    }];
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!__categories) {
        __categories = [[NSMutableArray alloc] init];
    }
    
    Categories *categoryToAdd = [[Categories alloc] init];
    categoryToAdd.description = @"iOSSDKdesc";
    categoryToAdd.categoryName = @"iOSSDKentry";
    
    [__categories insertObject: categoryToAdd atIndex:0];
    
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    [dataStore create:categoryToAdd block:^(BOOL success, NSError *error) {
        if(error) {
            NSLog(@"Failed to create item: %@", error.domain);
        }
        else {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];

    
   }

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return __categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   	
    NSString *postIdentifier = @"Category";
    
    // NSLog(@"Title in array: %@", [[self.posts objectAtIndex:indexPath.item] title]);
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:postIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postIdentifier];
    
    Categories *categoryEntity = [self._categories objectAtIndex:indexPath.item];
    cell.textLabel.text = categoryEntity.description;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [__categories removeObjectAtIndex:indexPath.row];
        Categories *categoryToRemove = (Categories*)[__categories objectAtIndex:indexPath.row];
        EVDataStore *dataStore = [EVDataStore sharedInstance];
        [dataStore remove:categoryToRemove block:^(BOOL success, NSError *error) {
            if(error) {
                NSLog(@"Failed to remove object %@", error.domain);
                
            }
            else {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = __categories[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
