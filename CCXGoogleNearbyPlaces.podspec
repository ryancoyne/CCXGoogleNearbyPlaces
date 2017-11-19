#
# Be sure to run `pod lib lint CCXGoogleNearbyPlaces.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CCXGoogleNearbyPlaces'
  s.version          = '1.0.1'
  s.summary          = 'CCXGoogleNearbyPlaces is a wrapper around the Google Places API.  All you do is set your API Key and you are good to go!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'The CCXGoogleNearbyPlaces is a wrapper around the Google Places API.  It is super easy to use, you just generate an API key from URL and you are good to go!'

  s.homepage         = 'https://github.com/ryancoyne/CCXGoogleNearbyPlaces'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ryancoyne_' => 'ryan@clearcodex.com' }
  s.source           = { :git => 'https://github.com/ryancoyne/CCXGoogleNearbyPlaces.git', :tag => '1.0.1' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.ios.deployment_target = '10.0'

###  s.source_files = 'CCXGoogleNearbyPlaces/Classes/**/*'
  s.source_files = 'CCXGoogleNearbyPlaces', 'CCXGoogleNearbyPlaces/**/*.{h,m,swift}', 'CCXGoogleNearByPlaces/Models/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'CCXGoogleNearbyPlaces' => ['CCXGoogleNearbyPlaces/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreLocation'
end
