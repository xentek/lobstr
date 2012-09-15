require 'spec_helper'

describe Lobstr::Config do
  before do
    @config_file = 'spec/config/lobstr.yml'
    @config = Lobstr::Config.new(@config_file)
  end

  after do
    clean_up_config_file @config_file
  end
  
  describe "template" do
    it "has a config template" do
      @config.create
      @config.template.wont_equal nil
    end
  end

  describe "create" do
    before do
      clean_up_config_file @config_file
    end

    it "can create a config file" do
      @config.create
      File.exist?(@config_file).must_equal true
    end

    it "won't create a config file if it exists already" do
      @config.create
      lambda { @config.create }.must_raise Lobstr::Error::ConfigFileExists
    end
  end
  
  describe "reset" do
    it "can reset the configuration" do
      @config.create
      @config.reset
      File.exist?(@config_file).must_equal true
    end
  end

  describe "parse" do
    before do
      @config.create
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
      @config.create
      @config.print.wont_equal nil
    end
  end

  describe "config_file_exists?" do
    it "will return true if config file exists" do
      @config.create
      @config.send(:config_file_exists?).must_equal true
    end

    it "will return false if config file does not exist" do
      @config.send(:config_file_exists?).must_equal false 
    end
  end

  describe "check_config_file" do
    it "will throw an error if config file does not exist" do
      check = lambda { @config.send(:check_config_file) }
      check.must_raise Lobstr::Error::ConfigFileMissing
    end
  end
end
