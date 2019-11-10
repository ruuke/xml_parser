require 'rails_helper'

feature 'User can upload file', %q{
  In order to create batch, invoices
  As any user
  I'd like to be able to create page
} do
  describe 'User' do
    background do
      visit root_path
    end

    scenario 'create a page' do
      attach_file 'File', "#{Rails.root}/spec/support/assets/sales_data.xml"
      click_on 'Create'

      expect(page).to have_content 'OK'
    end

    scenario 'creates batch with errors' do
      click_on 'Create'

      expect(page).to have_content "Прикрепите файл."
    end
  end
end
