
Pod::Spec.new do |s|
s.name        = "LGFSwiftPT"
s.version     = "0.0.5"
s.summary     = "LGFSwiftPT"
s.homepage    = "https://github.com/aiononhiii/LGFSwiftPT.git"
s.license     = { :type => 'MIT', :file => 'LICENSE' }
s.authors     = { "aiononhiii" => "452354033@qq.com" }
s.requires_arc = true
s.platform     = :ios, "8.0"
s.source   = { :git => "https://github.com/aiononhiii/LGFSwiftPT.git", :tag => s.version }
s.framework  = "UIKit"
s.source_files = 'LGFSwiftPT/*.swift'
s.resource_bundles = {
  'LGFSwiftPT' => ['LGFSwiftPT/*.xib']
}
s.swift_version = "4.2"
s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end
