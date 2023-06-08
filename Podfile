# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

target 'NYTimes-App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NYTimes-App
  pod 'SwiftLint'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'Kingfisher', '~> 7.0'

  target 'NYTimes-AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NYTimes-AppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end
end
