Pod::Spec.new do |s|
s.name             = 'BLUIKit'
s.version          = '0.1.0'
s.summary          = '自定义UI组件'

s.homepage         = 'https://github.com/bigL055/BLUIKit.git'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linger' => 'linhan.bigl055@outlook.com' }
s.source           = { :git => 'git@github.com:bigL055/BLUIKit.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'
s.public_header_files = 'Sources/*.h'
s.source_files = ['Sources/*/**','Sources/**']
s.frameworks = 'UIKit'

s.pod_target_xcconfig = {
'OTHER_SWIFT_FLAGS[config=Debug]' => '-enforce-exclusivity=unchecked',
'SWIFT_VERSION' => '4.0'
}
end

