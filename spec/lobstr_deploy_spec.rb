require 'spec_helper'

describe Lobstr::Deploy do
  
  before do
    @config_file = 'spec/config/lobstr.yml'
    @c = Lobstr::Config.new(@config_file)
    @c.reset
    @c = @c.parse('lobstr')
    @deploy = Lobstr::Deploy.new('@lobstr', @config_file)
    session = mock('Net::SSH::Connection::Session')
    $-w = nil
    Net::SSH = mock('Net::SSH')
    Net::SSH.expects(:start).with(@c['ssh_host'],@c['ssh_user'],{:keys=>[@c['ssh_key']]}).returns(session)
    $-w = false
  end

  after do
    clean_up_config_file @config_file
  end
  
  it "can connect" do
    @deploy.connect do
      @ssh.expects(:exec!).with('echo "yo"')
      @ssh.exec! 'echo "yo"'
    end
  end

  it "can set the app up" do
    @deploy.expects(:bundle_install)
    @deploy.expects(:foreman_export)    
    @deploy.connect do
      @ssh.expects(:exec!).with("git clone #{@config['repos']} #{@config['path']}")
      setup
    end
  end

  it "can deploy" do
    @deploy.expects(:update)
    @deploy.expects(:bundle_install)
    @deploy.expects(:notify)
    @deploy.deploy
  end
  
  it "can update" do
    @deploy.connect do
      @ssh.expects(:exec!).with("cd #{@config['path']}")
      @ssh.expects(:exec!).with("git fetch origin")
      @ssh.expects(:exec!).with("git reset --hard #{@branch}")
      @ssh.expects(:exec!).with("cd #{@config['path']}")
      @ssh.expects(:exec!).with("git reflog delete --rewrite HEAD@{1}")
      @ssh.expects(:exec!).with("git reflog delete --rewrite HEAD@{1}") 
      update  
    end
  end

  it "can rollback" do 
    @deploy.connect do
      @ssh.expects(:exec!).with("cd #{@config['path']}")
      @ssh.expects(:exec!).with("git fetch origin")
      @ssh.expects(:exec!).with("git reset --hard HEAD@{1}")
      rollback
    end
  end

  it "can notify" do
    skip "until this method does something, there is nothing to test"
  end

  it "can install bundled gems" do
    @deploy.connect do
      @ssh.expects(:exec!).with('bundle install --deployment  --path vendor/bundle --without development test ')
      bundle_install
    end
  end

  it "can export Procfiles with foreman" do
    @deploy.connect do
      @ssh.expects(:exec!).with("foreman export upstart /etc/init --app #{@config['app']} --log #{@config['path']}/log --user #{@config['ssh_user']} --procfile #{@config['path']}/Procfile ")
      export_foreman
    end
  end

end
