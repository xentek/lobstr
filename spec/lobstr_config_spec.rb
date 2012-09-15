require 'spec_helper'

describe Lobstr::Config do
  before do
    @config = Lobstr::Config.new
  end

  after do
    clean_up_config_file
  end
  
  describe "template" do
    it "has a config template" do
      @config.init
      @config.template.wont_equal nil
    end
  end

  describe "init" do
    before do
      clean_up_config_file 
    end

    it "can create a config file" do
      @config.init.must_equal true
      File.exist?('config/lobstr.yml').must_equal true
    end

    it "won't create a config file if it exists already" do
      @config.init
      lambda { @config.init }.must_raise Lobstr::Error::ConfigFileExists
    end
  end
  
  describe "reset" do
    it "can reset the configuration" do
      @config.init
      @config.reset.must_equal true
    end
  end

  describe "parse" do
    before do
      @config.init
    end

    it "has a class" do
      @config.parse['class'].must_equal 'Lobstr::Deploy'
    end

    it "has a repos" do
      @config.parse['repos'].must_equal 'git://github.com/xentek/lobstr.git'
    end

    it "has a path" do
      @config.parse['path'].must_equal '/app'
    end
    
    it "has an ssh host" do
      @config.parse['ssh_host'].must_equal 'localhost'
    end

    it "has an ssh user" do
      @config.parse['ssh_user'].must_equal 'lobstr'
    end

    it "has an ssh key" do
      @config.parse['ssh_key'].must_equal '~/.ssh/id_rsa'
    end

    it "has a branch" do
      @config.parse['branch'].must_equal 'master'
    end
    
    it "has an environment" do
      @config.parse['environment'].must_equal 'production'
    end
  end

  describe "print" do
    it "can print the contents of the config file" do
      @config.init
      @config.print.wont_equal nil
    end
  end
end
