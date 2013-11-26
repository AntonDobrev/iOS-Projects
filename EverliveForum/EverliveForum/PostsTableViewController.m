//
//  PostsTableViewController.m
//  EverliveForum
//
//  Created by Tony on 26.11.13.
//  Copyright (c) 2013 com.none. All rights reserved.
//

#import "PostsTableViewController.h"
#import "EverliveSDK/EverliveSDK.h"
#import "Posts.h"
#import "PostDetailsViewController.h"

@interface PostsTableViewController ()

@property (nonatomic, strong) NSMutableArray *posts;
@property BOOL skipReload;

@end

@implementation PostsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.posts = [[NSMutableArray alloc]init];
    
    self.postsTableView.dataSource = self;
    self.postsTableView.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    if (self.skipReload)
        return;
    
    [self.posts removeAllObjects];
    [self.postsTableView reloadData];
    //   self.posts = [[NSMutableArray alloc]init];
    
    
    if ([[EVUser currentUser] isAuthenticated]){
        
        [Posts fetchAll:^(NSArray *result, NSError *error) {
            
            __block int addedPostsCount = 1;
            
            for (int index = 0; index < [result count]; index++)
            {
                Posts *post = [result objectAtIndex:index];
                [self.posts addObject:post];
                //   NSLog(@"Title is: %@", post.title);
                
                if (addedPostsCount == [result count]){
                    NSSortDescriptor *createdDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
                    [self.posts sortUsingDescriptors:@[createdDateDescriptor]];
                    [self.postsTableView reloadData];
                }
                addedPostsCount++;
            }
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.skipReload = NO;
}

- (IBAction)logoutTap:(id)sender {
    [EVUser logOut];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addPostButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"AddPost" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *postIdentifier = @"Post";
    Posts *postEntity = [self.posts objectAtIndex:indexPath.item];
    
   // NSLog(@"Title in array: %@", [[self.posts objectAtIndex:indexPath.item] title]);
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:postIdentifier];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postIdentifier];
    
  // cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.textLabel.text = postEntity.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowPostDetails" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"addCourse"]) {
//        AddCourseViewController *addCourseController = (AddCourseViewController*)[segue destinationViewController];
//        addCourseController.delegate = self;
//        
//        Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
//        addCourseController.currentCourse = course;
//    }
    
    if ([[segue identifier] isEqualToString:@"ShowPostDetails"]) {
        PostDetailsViewController *pdvc = (PostDetailsViewController *) [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Posts *selectedPost = (Posts *) [self.posts objectAtIndex:indexPath.item];
        pdvc.currentPost = selectedPost;
    }
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
