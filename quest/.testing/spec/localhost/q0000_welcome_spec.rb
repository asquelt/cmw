require 'spec_helper'

describe "task 1:" do
  it 'check the puppet version - where is it?' do 
    file('/root/.bash_history').content.should match /puppet\s+(-V|--version)/
    file('/root/.bash_history').content.should match /which\s+puppet/
  end
end

describe "task 2:" do
  it 'check ruby version bundled with puppet - where is it?' do 
    file('/root/.bash_history').content.should match /ruby\s+--version/
    file('/root/.bash_history').content.should match /which\s+ruby/
    file('/root/.bash_history').content.should match /dpkg\s+-L\s+puppet-agent/
  end
end

describe "task 3:" do
  it 'view the options for the quest tool' do
    file('/root/.bash_history').content.should match /quest\s+(-h|--help)/
  end
end

describe "task 4:" do
  it 'check the quest progress' do 
    file('/root/.bash_history').content.should match /quest\s+(-p|--progress)/
  end
end
