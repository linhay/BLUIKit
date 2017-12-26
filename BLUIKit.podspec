Pod::Spec.new do |s|
s.name             = 'BLUIKit'
s.version          = '0.1.0'
s.summary          = 'A short description of BLUIKit.'
s.description      = <<-DESC
自定义UI组件
DESC

s.homepage         = 'https://github.com/158179948@qq.com/BLUIKit'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '158179948@qq.com' => 'bigl@3pzs.com' }
s.source           = { :git => 'https://github.com/158179948@qq.com/BLUIKit.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'
s.public_header_files = 'Sources/*.h'
s.source_files = ['Sources/*/**','Sources/**']
s.frameworks = 'UIKit'

s.pod_target_xcconfig = {
'OTHER_SWIFT_FLAGS[config=Debug]' => '-enforce-exclusivity=unchecked',
'SWIFT_VERSION' => '4.0'
}
end

