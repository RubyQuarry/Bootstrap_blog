require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BlogsHelper. For example:
#
# describe BlogsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BlogsHelper, :type => :helper do

  describe "date helper" do
    it "should return formatted date" do
      expect(helper.date_format(FactoryGirl.create(:blog))).to eq("Sunday, August 3rd 2014")
    end

    it "should return formatted month" do
      expect(helper.month_year_convertor([1, 2014])).to eq("January 2014")
    end
  end
end
