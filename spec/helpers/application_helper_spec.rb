require 'rails_helper'

class SomeModel; end
class SomeModelPresenter < SimpleDelegator; end

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#normalize_flash_keys" do
    it "return 'success' if key is notice" do
      expect(helper.normalize_flash_keys('notice')).to eq('success')
    end

    it "return 'error' if key is alert" do
      expect(helper.normalize_flash_keys('alert')).to eq('error')
    end

    it "return the key itself by default" do
      expect(helper.normalize_flash_keys('success')).to eq('success')
    end
  end

  describe "#present" do
    it "return a model presenter" do
      expect(helper.present(SomeModel.new)).to be_a(SomeModelPresenter)
    end
  end
end
