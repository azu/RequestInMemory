Pod::Spec.new do |s|
  s.name             = "RequestInMemory"
  s.version          = "1.0.0"
  s.summary          = "[CoreData] Once a fetch, does query request as many times as you wants."
  s.homepage         = "https://github.com/azu/RequestInMemory"
  s.license          = 'MIT'
  s.author           = {"azu" => "azuciao@gmail.com"}
  s.source           = {:git => "https://github.com/azu/RequestInMemory.git", :tag => s.version.to_s}
  s.social_media_url = 'https://twitter.com/azu_re'

  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes'
  s.framework = 'CoreData'
end
