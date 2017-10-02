#
#  Be sure to run `pod spec lint PHDiff.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PHDiff"
  s.version      = "1.1.0"
  s.summary      = "Lightning fast array diff implementation, works great with UITableView/UICollectionView updates."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  A diff algorithm implementend in pure Swift based on Paul Heckel's paper: "A technique for isolating differences between files".
  It's a very fast algorithm with linear complexity in both time and space. 
  Given two different arrays, A and B, what steps A has to make to become B?
  PHDiff can answer that by calculating the needed Inserts, Deletes, Moves and Updates!
  Works great with UITableView and UICollectionView and can be used right on the main queue.
                   DESC

  s.homepage     = "https://github.com/andre-alves/PHDiff"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "André Alves" => "andre.ver93@gmail.com" }

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source       = { :git => "https://github.com/andre-alves/PHDiff.git", :tag => s.version.to_s }

  s.source_files = 'Sources/*.swift'

end
