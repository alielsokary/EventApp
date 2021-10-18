# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'EventApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for EventApp
  
	pod 'Alamofire', '5.4.1'
	pod 'AlamofireNetworkActivityLogger', '3.4.0', :configurations => ['Debug']

	pod 'Kingfisher', '~> 6.0'
  
	pod 'RxSwift', '6.2.0'
	pod 'RxCocoa', '6.2.0'
	
	pod 'RealmSwift', '~>10'
	
	pod 'R.swift'
	
	pod 'PKHUD'

  target 'EventAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'EventAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
	target.build_configurations.each do |config|
	 config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
	end
 end
end
