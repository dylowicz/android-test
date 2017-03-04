require 'spec_helper'

shared_examples 'Add Notes' do
  context 'when adding' do
    let(:title) { Faker::Commerce.product_name }
    let(:content) { Faker::Lorem.sentence }
    let(:tasks) { [Faker::Company.buzzword, Faker::Company.buzzword]}

    it 'does not create an empty note' do
      on(NotesPage).add_note
      on(NotePage).add_empty
      expect(on(NotesPage).elements_count).to eq(0)
    end

    it 'creates a note with title and content' do
      on(NotesPage).add_note
      on(NotePage).add_note(title, content)
      expect(on(NotesPage).notes_by_title).to include title
      expect(on(NotesPage).notes_by_content).to include content
    end

    it 'creates a note with content but no title' do
      on(NotesPage).add_note
      on(NotePage).add_note(nil, content)
      expect(on(NotesPage).notes_by_content).to include content
    end

    it 'creates a note with title but no content' do
      on(NotesPage).add_note
      set_wait(20)
      wait_true { on(ErrorPage).ok_element.enabled? }
      on(ErrorPage).ignore
      set_wait(0)
      on(NotePage).add_note(title)
      expect(on(NotesPage).notes_by_title).to include title
    end

    it 'creates a note as a checklist with 2 tasks' do
      on(NotesPage).add_checklist
      on(ChecklistPage).add_checklist(title, tasks)
      expect(on(NotesPage).notes_by_title).to include title
      expect(on(NotesPage).notes_by_content.find{|task| task.include? tasks.first}).to be_truthy
      expect(on(NotesPage).notes_by_content.find{|task| task.include? tasks.last}).to be_truthy
    end

    it 'creates a note with photo' do
      on(NotesPage).add_note_with_photo
      on(CameraPage).take_photo
      on(NotePage).add_note_with_photo(title, content)
      expect(on(NotesPage).notes_by_title).to include title
      expect(on(NotesPage).notes_by_content).to include content
    end
  end
end

shared_examples 'Edit Notes' do
  context 'when editing' do
    let(:title) { Faker::Commerce.product_name }
    let(:content) { Faker::Lorem.sentence }

    it 'updates a note with title' do
      on(NotesPage).edit_note(0)
      on(NotePage).change_title title
      expect(on(NotesPage).notes_by_title).to include title
    end

    it 'updates a note with content' do
      on(NotesPage).edit_note(0)
      on(NotePage).change_content content
      expect(on(NotesPage).notes_by_content).to include content
    end

    it 'updates a note with a reminder' do
      on(NotesPage).edit_note(0)
      on(NotePage).set_reminder
      on(ReminderPage).set
      expect(on(NotePage).reminder_info_element.text).to match 'Reminder set for [A-Z][a-z]{2} [0-3]?[0-9] [0-2]?[0-9]:[0-5][0-9] (A|P)M'
      on(NotePage).update
    end
  end
end

shared_examples 'Delete Notes' do
  context 'when deleting' do
    it 'deletes a note' do
      note_title = on(NotesPage).notes_by_title.first
      notes_count = on(NotesPage).elements_count
      on(NotesPage).edit_note(0)
      on(NotePage).delete
      expect(on(NotesPage).notes_by_title).to_not include note_title
      expect(on(NotesPage).elements_count).to eq(notes_count - 1)
    end

    it 'moves the note to Trash' do
      on(NotesPage).menu
      on(MenuPage).go_to 'Trash'
      expect(on(TrashPage).elements_count).to eq(1)
      on(TrashPage).menu
      on(MenuPage).go_to 'Notes'
    end
  end
end

shared_examples 'Archive Notes' do
  context 'when archiving' do
    it 'archives a note' do
      note_title = on(NotesPage).notes_by_title.first
      notes_count = on(NotesPage).elements_count
      on(NotesPage).edit_note(0)
      on(NotePage).archive
      expect(on(NotesPage).notes_by_title).to_not include note_title
      expect(on(NotesPage).elements_count).to eq(notes_count - 1)
    end

    it 'moves the note to Archive' do
      on(NotesPage).menu
      on(MenuPage).go_to 'Archive'
      expect(on(ArchivePage).elements_count).to eq(1)
      on(ArchivePage).menu
      on(MenuPage).go_to 'Notes'
    end
  end
end

shared_examples 'Search Notes' do
  context 'when searching' do
    it 'finds note containing title of last note' do
      notes = on(NotesPage).notes_by_title
      on(NotesPage).search
      on(SearchPage).search_for notes.last
      expect(on(NotesPage).notes_by_title).to include notes.last
      expect(on(NotesPage).elements_count).to eq(1)
    end
  end
end

describe 'Notes' do
  include_examples 'Initialize Settings'
  include_examples 'Add Notes'
  include_examples 'Edit Notes'
  include_examples 'Delete Notes'
  include_examples 'Archive Notes'
  include_examples 'Search Notes'
  # binding.pry
end
