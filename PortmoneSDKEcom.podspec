Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "PortmoneSDKEcom"
s.summary = "Provides an opportunity for merchants to accept payments in their mobile app."
s.requires_arc = true
s.version = "1.0.0"
s.license = { :type => "GPL 3.0", :file => "LICENSE" }
s.author = { "Portmone" => "support@portmone.com" }
s.homepage = "https://github.com/Portmone/IOS-e-Commerce-SDK"
s.source = { :git => "https://github.com/Portmone/IOS-e-Commerce-SDK.git", :tag => "#{s.version}" }
s.vendored_frameworks = "PortmoneSDKEcom.framework"
s.swift_version = "5.0"

end
