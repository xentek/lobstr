require 'spec_helper'

describe Lobstr::Deploy do

  before do
    @config_file = 'spec/config/lobstr.yml'
    @config = Lobstr::Config.new(@config_file)
    @config.reset
    @config = @config.parse('lobstr')
    Net::SSH = MiniTest::Mock.new
    Net::SSH.expect(:start, @ssh, ['localhost','xentek',{:keys=>['~/.ssh/id_rsa']}])    
    @ssh = MiniTest::Mock.new
  end


  after do
    clean_up_config_file @config_file
  end
  
  it "can connect" do
    @ssh.expect(:exec!,nil,['echo "yo"'])
    lobstr '@lobstr', @config_file do
      connect do
        @ssh.exec! 'echo "yo"'
      end
    end
  end
  
  it "can update" do
    @ssh.expect(:exec!, nil, ["cd #{@config['path']}"])
    @ssh.expect(:exec!, nil, ["git fetch origin"])
    @ssh.expect(:exec!, nil, ["git reset --hard #{@branch}"])
    @ssh.expect(:exec!, nil, ["cd #{@config['path']}"])
    @ssh.expect(:exec!, nil, ["git reflog delete --rewrite HEAD@{1}"])
    @ssh.expect(:exec!, nil, ["git reflog delete --rewrite HEAD@{1}"])
    lobstr '@lobstr', @config_file do
      connect do
        update
      end
    end
  end

  it "can deploy" do
    @ssh.expect(:exec!, nil, ["cd #{@config['path']}"])
    @ssh.expect(:exec!, nil, ["git fetch origin"])
    @ssh.expect(:exec!, nil, ["git reset --hard #{@branch}"])
    @ssh.expect(:exec!, nil, ["cd #{@config['path']}"])
    @ssh.expect(:exec!, nil, ["git reflog delete --rewrite HEAD@{1}"])
    @ssh.expect(:exec!, nil, ["git reflog delete --rewrite HEAD@{1}"])
    lobstr '@lobstr', @config_file do
      connect do
        deploy
      end
    end
  end

  it "can rollback" do
    @ssh.expect(:exec!, nil, ["cd #{@config['path']}"])
    @ssh.expect(:exec!, nil, ["git fetch origin"])
    @ssh.expect(:exec!, nil, ["git reset --hard HEAD@{1}"])
    lobstr '@lobstr', @config_file do
      connect do
        rollback
      end
    end
  end

  it "can notify" do
    skip "until this method does something, there is nothing to test"
  end

end
