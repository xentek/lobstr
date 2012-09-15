require 'spec_helper'

describe Lobstr::Config do
  before do
    @config = Lobstr::Config.new
  end

  after do
    File.delete 'config/lobstr.yml'
    Dir.delete 'config'
  end
  
  describe "template" do
    it "has a config template" do
      @config.init
      @config.template.wont_equal nil
    end
  end

  describe "init" do
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

    it "has a default branch" do
      @config.parse['default']['branch'].must_equal 'master'
    end
    
    it "has a default environment" do
      @config.parse['default']['environment'].must_equal 'production'
    end
  end

  describe "print" do
    it "can print the contents of the config file" do
      @config.init
      @config.print.wont_equal nil
    end
  end
end
