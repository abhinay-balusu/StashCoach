# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StashCoach' do
  # Pods for StashCoach
  pod 'Kingfisher', '~> 5.0'

  target 'StashCoachTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Kingfisher', '~> 5.0'
  end

  target 'StashCoachUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end
