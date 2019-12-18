Pod::Spec.new do |spec|
  spec.name         = "LBItemsSelectViewController"
  spec.version      = "1.0.0"
  spec.summary      = "下拉框/下拉菜单"
  spec.description  = "一个可以快速设置icon和title的选择下拉框/下拉菜单，集成自系统的PopoverVC。"
  spec.homepage     = "https://github.com/A1129434577/LBItemsSelectViewController"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBItemsSelectViewController.git', :tag => spec.version.to_s }
  spec.source_files = "LBItemsSelectViewController/**/*.{h,m}"
  spec.requires_arc = true
end
