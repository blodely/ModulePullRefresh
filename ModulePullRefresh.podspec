#
# Be sure to run `pod lib lint ModulePullRefresh.podspec' to ensure this
# CREATED BY LUO YU
#

Pod::Spec.new do |s|
	s.name             = 'ModulePullRefresh'
	s.version          = '1.13.0'
	s.summary          = 'Module PullRefresh.'

	s.description      = <<-DESC
Pull to refresh wrapper.
1. app style pre-configured.
2. read configuration file for titles.
3. min-os-version iOS 11.0 since v1.13.
4. update lib for iOS 11 and iPhone X.
5. Xcode13 iOS11=1.13; Xcode12 iOS9=1.12; Xcode11=1.11.
							DESC

	s.homepage         = 'https://github.com/blodely/ModulePullRefresh'

	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.author           = { 'Luo Yu' => 'indie.luo@gmail.com' }
	s.source           = { :git => 'https://github.com/blodely/ModulePullRefresh.git', :tag => s.version.to_s }

	s.social_media_url = 'https://weibo.com/blodely'

	s.ios.deployment_target = '11.0'

	s.source_files = 'ModulePullRefresh/Classes/**/*'

	s.resources = 'ModulePullRefresh/Configurations/*.plist'
	
	# s.resource_bundles = {
	#   'ModulePullRefresh' => ['ModulePullRefresh/Assets/*.png']
	# }

	# s.public_header_files = 'Pod/Classes/**/*.h'

	s.frameworks = 'UIKit'
	s.dependency 'MJRefresh', '~> 3.7.5'

end
