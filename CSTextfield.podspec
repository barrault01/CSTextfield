Pod::Spec.new do |spec|
    spec.name         = 'CSTextfield'
    spec.version      = '0.1'
    spec.license      = 'MIT'
    spec.platform = :ios, '10'
    spec.summary      = 'Mutli features textfield (mask, allow characters, block callback)'
    spec.homepage     = 'https://github.com/barrault01/CSTextfield'
    spec.author       = 'Antoine Barrault'
    spec.source       = { :git => 'https://github.com/barrault01/CSTextfield.git', :tag => '0.1' }
    spec.source_files = 'Sources/*/*'
    spec.swift_versions = '5.0'
  end
  
