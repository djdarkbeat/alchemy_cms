require 'spec_helper'

module Alchemy
  describe Admin::ClipboardController do
    let(:public_page)     { build_stubbed(:public_page) }
    let(:element)         { build_stubbed(:element, page: public_page) }
    let(:another_element) { build_stubbed(:element, page: public_page) }

    before do
      sign_in(admin_user)
      session[:clipboard] = Clipboard.new
      Element.stub(find: element)
    end

    describe "#insert" do
      it "should hold element ids" do
        post(:insert, {remarkable_type: :elements, remarkable_id: element.id, format: :js})
        session[:clipboard][:elements].should == [{id: element.id, action: 'copy'}]
      end

      it "should not have the same element twice" do
        session[:clipboard][:elements] = {id: element.id, action: 'copy'}
        post(:insert, {remarkable_type: :elements, remarkable_id: element.id, format: :js})
        session[:clipboard][:elements].collect { |e| e[:id] }.should_not == [element.id, element.id]
      end
    end

    describe "#delete" do
      it "should remove element ids from clipboard" do
        session[:clipboard][:elements] = {id: element.id, action: 'copy'}
        session[:clipboard][:elements] << {id: another_element.id, action: 'copy'}
        delete(:remove, {remarkable_type: :elements, remarkable_id: another_element.id, format: :js})
        session[:clipboard][:elements].should == [{id: element.id, action: 'copy'}]
      end
    end

    describe "#clear" do

      context "with elements as remarkable_type" do
        it "should clear the elements clipboard" do
          session[:clipboard][:elements] = {id: element.id}
          delete(:clear, {remarkable_type: :elements, format: :js})
          session[:clipboard].should be_empty
        end
      end

      context "with pages as remarkable_type" do
        it "should clear the pages clipboard" do
          session[:clipboard][:pages] = {id: public_page.id}
          delete(:clear, {remarkable_type: :pages, format: :js})
          session[:clipboard].should be_empty
        end
      end

    end

  end
end
