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
	if (self = [super initWithNibName:@"LYTestViewController" bundle:[NSBundle mainBundle]]) {
	}
	return self;
}

- (void)loadView {
	[super loadView];
	
	[tbPull registerClass:[UITableViewCell class] forCellReuseIdentifier:TestCellIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
	
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
