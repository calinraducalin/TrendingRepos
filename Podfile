# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'TrendingRepos' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TrendingRepos
  pod 'StanwoodCore'
  pod 'RealmSwift'
  pod 'Kingfisher'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '5.0'
          end
      end
  end

end
