Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = 'PortmoneSDKEcom'
s.summary = 'Provides an opportunity for merchants to accept payments in their mobile app.'
s.requires_arc = true
s.version = '1.7.8'
s.license = { :type => 'GPL 3.0', :file => 'LICENSE.md' }
s.author = { 'Portmone' => 'support@portmone.com' }
s.homepage = 'https://github.com/Portmone/IOS-e-Commerce-SDK'
s.source = { :git => 'https://github.com/Portmone/IOS-e-Commerce-SDK.git', :tag => "v#{s.version}" }
s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
s.vendored_frameworks = 'PortmoneSDKEcom.xcframework'
s.swift_version = '5.0'

end
