Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "PlaybackControls-iOS"
  s.version      = "1.0.0"
  s.summary      = "NSNotificationCenter and KVO manager for iOS."
  s.homepage     = "https://github.com/maxcampolo/MCNotificationCenter"

  s.license      = 'MIT'

  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Max Campolo" => "https://github.com/maxcampolo" }

  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  #s.platform     = :ios
  s.platform     = :ios, "7.0"

  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://bitbucket.org/kiswe/playbackcontrols-ios.git", :tag => s.version.to_s }

  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "MCNotificationCenter/Source"

  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.requires_arc = true
