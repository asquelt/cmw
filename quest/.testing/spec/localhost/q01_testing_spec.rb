require 'spec_helper'

describe "task 1:" do
  it 'check out how quest tool evaluates your work - try to add "task 2" with any contents' do 
    file('/root/.testing/spec/localhost/q01_testing_spec.rb').content.should match /^describe.*[Tt]ask\s+2/
    command('/opt/puppetlabs/puppet/bin/ruby -c /root/.testing/spec/localhost/q01_testing_spec.rb').stdout.should match /Syntax OK/
  end
end

#describe "task 2:" do
  # describe something, be creative ;)
  # this might help: http://serverspec.org/resource_types.html
#end
