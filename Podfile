platform :ios, '10.0'
use_frameworks!

target 'C7FIT' do
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'

  target 'C7FITTests' do
    inherit! :search_paths
    pod 'Firebase/Core'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
