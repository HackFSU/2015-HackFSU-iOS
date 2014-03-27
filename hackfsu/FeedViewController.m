//
//  FeedViewController.m
//  hackfsu
//
//  Created by Michelle Rojas on 2/7/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCell.h"

@implementation FeedViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.title = @"News Feed";
        self.parseClassName = @"Updates";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 100;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"News Feed"];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
}

- (void)objectsWillLoad
{
    [super objectsWillLoad];
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];

    if ([self.objects count] == 0)
    {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"updatedAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    FeedCell *cell = (FeedCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = (FeedCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:@"Cell"];
    }

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy h:mmaa"];
    [df setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *date = [df stringFromDate:object.createdAt];
    
    
    cell.title.text = [object objectForKey:@"title"];
    cell.updateView.text = [object objectForKey:@"msg"];
    cell.timeLabel.text = date;

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell layoutIfNeeded];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITextView *tView = [[UITextView alloc] initWithFrame:CGRectMake(300.0f, 40.0f, 280.0f, 41.0f)];
    
    NSString *tString = [[self objectAtIndexPath:indexPath] objectForKey:@"msg"];
    
    return [self heightForTextView:tView containingString:tString];
}

#pragma mark - Helper Methods

- (CGFloat)heightForTextView:(UITextView*)textView containingString:(NSString*)string
{
    float horizontalPadding = 14;
    float verticalPadding = 44;
    float widthOfTextView = textView.contentSize.width - horizontalPadding;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary * attributes = @{NSFontAttributeName :FONT14,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(widthOfTextView, 999999.0f)
                                       options:NSStringDrawingUsesFontLeading
                   |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil].size;
        
    return size.height + verticalPadding;
}

@end