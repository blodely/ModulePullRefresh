//
//  LYTestViewController.m
//  MODULEPULLREFRESH
//
//  CREATED BY LUO YU ON 2016-10-12.
//  COPYRIGHT (C) 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYTestViewController.h"
#import <ModulePullRefresh/ModulePullRefresh.h>
#import <LYCategory/LYCategory.h>

NSString *const TestCellIdentifier = @"TestCellIdentifier";

@interface LYTestViewController () <UITableViewDelegate, UITableViewDataSource> {
	
	__weak IBOutlet UITableView *tbPull;
	
	NSMutableArray *datas;
}

@end

@implementation LYTestViewController

- (instancetype)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)loadView {
	[super loadView];
	
	{
		self.view.backgroundColor = [UIColor whiteColor];
	}
	
	{
		// MARK: DEFAULT TABLE VIEW
		UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		view.translatesAutoresizingMaskIntoConstraints = NO;
		view.delegate = self;
		view.dataSource = self;
		[self.view addSubview:view];
		tbPull = view;
		
		[view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
		[view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
		[view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
		[view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
		
		[tbPull registerClass:[UITableViewCell class] forCellReuseIdentifier:TestCellIdentifier];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
	
	// MARK: SAMPLE CODE HERE
	tbPull.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
		[self performSelector:@selector(loadData) withObject:nil afterDelay:1];
	}];
	[tbPull.mj_header setupAppStyle];
	
	[tbPull.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

- (void)loadData {
	if (datas == nil) {
		datas = [NSMutableArray arrayWithCapacity:1];
	} else {
		[datas removeAllObjects];
	}
	
	[datas addObject:[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"]];
	
	[datas addObject:[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"]];
	
	[datas addObject:[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"]];
	
	[datas addObject:[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"]];
	
	[tbPull reloadData];
	
	[tbPull.mj_header endRefreshing];
}

// MARK: - DELEGATE

// MARK: UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)idp {
	
	[tableView deselectRowAtIndexPath:idp animated:YES];
}

// MARK: UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TestCellIdentifier forIndexPath:idp];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", datas[idp.row], @(idp.row)];
	return cell;
}

@end
