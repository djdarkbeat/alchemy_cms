require 'spec_helper'

module Alchemy
  describe EssencePicture do

    it "should not store negative values for crop values" do
      essence = EssencePicture.new(:crop_from => '-1x100', :crop_size => '-20x30')
      essence.save!
      essence.crop_from.should == "0x100"
      essence.crop_size.should == "0x30"
    end

    it "should not store float values for crop values" do
      essence = EssencePicture.new(:crop_from => '0.05x104.5', :crop_size => '99.5x203.4')
      essence.save!
      essence.crop_from.should == "0x105"
      essence.crop_size.should == "100x203"
    end

    it "should convert newlines in caption into <br/>s" do
      essence = EssencePicture.new(:caption => "hello\nkitty")
      essence.save!
      essence.caption.should == "hello<br/>kitty"
    end

    describe '#preview_text' do
      let(:picture) { mock_model(Picture, name: 'Cute Cat Kittens')}
      let(:essence) { EssencePicture.new }

      it "should return the pictures name as preview text" do
        essence.stub(:picture).and_return(picture)
        essence.preview_text.should == 'Cute Cat Kittens'
      end

      context "with no picture assigned" do
        it "returns empty string" do
          essence.preview_text.should == ''
        end
      end
    end

    describe '#resize_url_options' do
      subject { essence.resize_url_options(options) }

      let(:essence) { EssencePicture.new(crop_from: '0x0', crop_size: '50x50') }
      let(:options) { {image_size: '100x100', crop: true, foo: nil, bar: ''} }

      it "converts image_size into size" do
        should include(size: '100x100')
      end

      it "converts boolean crop value into crop string" do
        should include(crop: 'crop')
      end

      it "removes pairs with blank values" do
        should_not include(foo: nil)
        should_not include(bar: '')
      end

      it "adds crop_from key and value" do
        should include(crop_from: '0x0')
      end

      it "adds crop_size key and value" do
        should include(crop_size: '50x50')
      end
    end

  end
end
