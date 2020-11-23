platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

def shared_pods

  # Tools
  pod 'SwiftGen'

  # RX
  pod 'RxSwift'
  pod 'RxCocoa'

  # UI
  pod 'SnapKit'

end

target 'Worksmile-app' do

  shared_pods

  target 'Worksmile-appTests' do
    inherit! :search_paths

    pod 'iOSSnapshotTestCase'
  end

  target 'Worksmile-appUITests' do

  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Xcode 12 deployment target fix
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
