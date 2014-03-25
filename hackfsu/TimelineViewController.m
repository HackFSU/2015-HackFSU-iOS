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
            [self.sectionToDateMap setObject:dateStr forKey:[NSNumber numberWithInt:(int)section++]];
        }
        
        [objectsInSection addObject:[NSNumber numberWithInt:(int)rowIndex++]];
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
    [dateLabel setFont:FONT16];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [dateLabel setBackgroundColor:[UIColor whiteColor]];
    
//    CALayer *line = [CALayer layer];
//    line.frame = CGRectMake(25.0f, CGRectGetMaxY(f) - 2.0f, 5.0f, 5.0f);
//    line.cornerRadius = 2.5f;
//    line.backgroundColor = [BLACK CGColor];
//    
//    [dateLabel.layer insertSublayer:line atIndex:0];
    
    return dateLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    TimelineCell *cell = (TimelineCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDate *date = [object objectForKey:@"eventTime"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h.mma"];
    NSString *timeStr = [dateFormat stringFromDate:date];

    
    cell.timeLabel.text = [[timeStr substringToIndex:timeStr.length-1] lowercaseString];//timeStr;
    cell.descriptionView.text = [object objectForKey:@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell layoutIfNeeded];
}

- (NSString *) dateForSection:(NSInteger)section
{
    return [self.sectionToDateMap objectForKey:[NSNumber numberWithInt:(int)section]];
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
    UITextView *tView = [[UITextView alloc] initWithFrame:CGRectMake(179.0f, 40.0f, 242.0f, 30.0f)];
    
    NSString *tString = [[self objectAtIndexPath:indexPath] objectForKey:@"title"];
    
    return [self heightForTextView:tView containingString:tString];
}

#pragma mark - Helper Methods

- (CGFloat)heightForTextView:(UITextView*)textView containingString:(NSString*)string
{
    float horizontalPadding = 14;
    float verticalPadding = 32;
    float widthOfTextView = textView.contentSize.width - horizontalPadding;
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;

    NSDictionary * attributes = @{NSFontAttributeName : FONT14,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(widthOfTextView, 999999.0f)
                                      options:NSStringDrawingUsesFontLeading
            |NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributes
                                      context:nil].size;
    
    float height = size.height + verticalPadding;
    
    return height;
}

@end