require 'spec_helper'

describe Lobstr::Base do

  before do
    @deploy = Lobstr::Base.new
  end

  describe "parse_target" do
    it "can parse deployment target (full): branch@env" do
      @deploy.parse_target('branch@env').must_equal ['branch','env']
    end

    it "can parse deployment target (branch only): branch@" do
      @deploy.parse_target('branch@').must_equal ['branch','production']
    end

    it "can parse deployment target (env only): @environment" do
      @deploy.parse_target('@environment').must_equal ['master','environment']
    end
    
    it "can parse deployment target (env only) - alt syntax: environment" do
      @deploy.parse_target('@environment').must_equal ['master','environment']
    end
  end

end
