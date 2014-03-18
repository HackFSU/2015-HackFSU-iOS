//
//  TimelineViewController.m
//  hackfsu
//
//  Created by Michelle Rojas on 2/7/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "TimelineViewController.h"
#import "TimelineCell.h"

@implementation TimelineViewController
@synthesize sections = _sections;
@synthesize sectionToDateMap = _sectionToDateMap;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.parseClassName = @"Schedule";
        self.textKey = @"description";
        self.title = @"Timeline";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 20;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sections = [[NSMutableDictionary alloc] init];
    _sectionToDateMap = [[NSMutableDictionary alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    [self.sections removeAllObjects];
    [self.sectionToDateMap removeAllObjects];
    
    NSInteger section = 0;
    NSInteger rowIndex = 0;
    for (PFObject *object in self.objects)
    {
        NSDate *date = [object objectForKey:@"eventTime"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMMM dd, yyyy"];
        NSString *dateStr = [dateFormat stringFromDate:date];
        
        NSMutableArray *objectsInSection = [self.sections objectForKey:dateStr];
        if (!objectsInSection)
        {
            objectsInSection = [NSMutableArray array];
            [self.sectionToDateMap setObject:dateStr forKey:[NSNumber numberWithInt:section++]];
        }
        
        [objectsInSection addObject:[NSNumber numberWithInt:rowIndex++]];
        [self.sections setObject:objectsInSection forKey:dateStr];
    }
}

- (void)objectsWillLoad
{
    [super objectsWillLoad];
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    if (self.pullToRefreshEnabled)
    {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    if ([self.objects count] == 0)
    {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"eventTime"];
    
    return query;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect f = CGRectMake(0, 0, tableView.frame.size.width, tableView.sectionHeaderHeight);
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:f];
    
    [dateLabel setText:[self dateForSection:section]];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [dateLabel setBackgroundColor:[UIColor whiteColor]];
    
    return dateLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    TimelineCell *cell = (TimelineCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDate *date = [object objectForKey:@"eventTime"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"ha"];
    NSString *timeStr = [dateFormat stringFromDate:date];
    
    cell.timeLabel.text = timeStr;
    cell.descriptionView.text = [object objectForKey:@"description"];
    
    return cell;
}

- (NSString *) dateForSection:(NSInteger)section
{
    return [self.sectionToDateMap objectForKey:[NSNumber numberWithInt:section]];
}

-(PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dateType = [self dateForSection:indexPath.section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:dateType];
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
    return [self.objects objectAtIndex:[rowIndex intValue]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *dateType = [self dateForSection:section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:dateType];
    return rowIndecesInSection.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *dateType = [self dateForSection:section];
    return dateType;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end