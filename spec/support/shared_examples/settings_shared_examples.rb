require 'spec_helper'

shared_examples 'Initialize Settings' do
  context 'before running test' do
    it 'setups initial app settings' do
      wait_true { on(NotesPage).header_info_element.visible? }
      on(MainPage).menu
      on(MenuPage).settings
      on(SettingsPage).setup_app
      on(MenuPage).notes
      expect(on(NotesPage).header_info_element.when_present.visible?).to be_truthy
    end
  end
end
