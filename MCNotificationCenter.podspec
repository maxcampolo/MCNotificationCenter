Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "MCNotificationCenter"
  s.version      = "1.0.0"
  s.summary      = "NSNotificationCenter and KVO manager for iOS."
  s.homepage     = "https://github.com/maxcampolo/MCNotificationCenter"

  s.license      = 'MIT'

  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Max Campolo" => "https://github.com/maxcampolo" }

  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  #s.platform     = :ios
  s.platform     = :ios, "8.0"

  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/maxcampolo/MCNotificationCenter.git", :tag => s.version.to_s }

  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "MCNotificationCenter/Source"

  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.requires_arc = true

end
