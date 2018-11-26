//
//  ModulePullRefresh.m
//  MODULEPULLREFRESH
//
//  CREATED BY LUO YU ON 2016-10-12.
//  COPYRIGHT (C) 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "ModulePullRefresh.h"


NSString *const LIB_PULL_REFRESH_BUNDLE_ID = @"org.cocoapods.ModulePullRefresh";

NSString *const NAME_CONF_PULL_REFRESH = @"conf-pull-refresh";

// MARK: - ModulePullRefresh

@implementation ModulePullRefresh

+ (NSDictionary *)readConfigurationFile {
	
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:NAME_CONF_PULL_REFRESH ofType:@"plist"];
	
	if (confpath == nil ||
		[confpath isEqualToString:@""] == YES ||
		[[NSFileManager defaultManager] fileExistsAtPath:confpath] == NO) {
		
		NSLog(@"PullRefresh WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:LIB_PULL_REFRESH_BUNDLE_ID] pathForResource:NAME_CONF_PULL_REFRESH ofType:@"plist"];
	}
	
	// TRY TO READ APP CONFIGURATION
	
	NSDictionary *conf = [NSDictionary dictionaryWithContentsOfFile:confpath];
	
	if (conf == nil) {
		NSLog(@"PullRefresh ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
	return conf;
}

@end

// MARK: - MJRefreshHeader

@implementation MJRefreshHeader (PullRefresh)

- (void)setupAppStyle {
	
	if ([self isKindOfClass:[MJRefreshGifHeader class]]) {
		__weak MJRefreshGifHeader *header = (MJRefreshGifHeader *)self;
		[header setupAppStyle];
	} else {
		NSLog(@"ERROR {ModulePullRefresh}\n\tapp style setter\n");
	}
	
}

@end

// MARK: - MJRefreshGifHeader

@implementation MJRefreshGifHeader (PullRefresh)

- (void)setupAppStyle {
	
	CGFloat rate = 0.2;
	
	{
		// CONFIGURE TITLE
		
		NSDictionary *conf = [ModulePullRefresh readConfigurationFile];
		NSString *confValue = @"conf-value";
		
		self.stateLabel.hidden = ![conf[@"title-visibility"][confValue] boolValue];
		self.lastUpdatedTimeLabel.hidden = YES;
		
		if ([conf[@"title-visibility"][confValue] boolValue]) {
			[self setTitle:conf[@"title-idle"][confValue] forState:MJRefreshStateIdle];
			[self setTitle:conf[@"title-pulling"][confValue] forState:MJRefreshStatePulling];
			[self setTitle:conf[@"title-refreshing"][confValue] forState:MJRefreshStateRefreshing];
		}
		
		rate = [conf[@"animate-rate"][confValue] floatValue];
	}
	
	{
		// CONFIGURE IMAGE
		
		NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"pullrefresh" ofType:@"bundle"];
		
		if (bundlePath == nil) {
			NSLog(@"\n\nERROR {ModulePullRefresh}\n\tNEED \"pullrefresh.bundle\" FILE IN PROJECT\n\n");
			return;
		}
		
		NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:bundlePath];
		NSArray *files = [enumerator.allObjects sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
		
		NSMutableArray *images = [NSMutableArray arrayWithCapacity:1];
		for (NSString *image in files) {
			[images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"pullrefresh.bundle/%@", image]]];
		}
		
		if ([images count] == 0) {
			NSLog(@"\n\nERROR {ModulePullRefresh}\n\t\"pullrefresh.bundle\" IS EMPTY\n\n");
			return;
		}
		
		// STATIC
		[self setImages:@[images.firstObject,] forState:MJRefreshStateIdle];
		
		// ANIMATE
		[self setImages:images duration:[files count] * rate forState:MJRefreshStateRefreshing];
		[self setImages:images duration:[files count] * rate forState:MJRefreshStatePulling];
		[self setImages:images duration:[files count] * rate forState:MJRefreshStateWillRefresh];
	}
}

@end
