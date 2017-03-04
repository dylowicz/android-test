class NotesPage < MainPage
  include PageObject

  # Action bar
  paragraph(:header_info, name: 'Notes')

  # Floating Action Button
  button(:add, id: 'it.feio.android.omninotes:id/fab_expand_menu_button')
  button(:note, id: 'it.feio.android.omninotes:id/fab_note')
  button(:checklist, id: 'it.feio.android.omninotes:id/fab_checklist')
  button(:note_with_photo, id: 'it.feio.android.omninotes:id/fab_camera')

  # Information
  paragraph(:cant_save_empty_info, name: 'Can\'t save an empty note')
  paragraph(:note_updated_info, name: 'Note updated!')

  def add_note
    add note_element
  end

  def add_checklist
    add checklist_element
  end

  def add_note_with_photo
    add note_with_photo_element
  end

  def add(element)
    add_element.when_present.click
    element.when_present.click
  end

  def notes_by_title
    find_elements(id: 'it.feio.android.omninotes:id/note_title').map{|e| e.name}
  end

  def notes_by_content
    find_elements(id: 'it.feio.android.omninotes:id/note_content').map{|e| e.name}
  end

  def notes_by_date
    find_elements(id: 'it.feio.android.omninotes:id/note_date')
  end

  def edit_note(number)
    notes_by_date[number].click
  end

  def notes
    # TODO return list of hashes of notes (hashes too) in following format:
    # [ "1": {
    #  title: notes_by_title,
    #  content: notes_by_content,
    #  date: notes_by_date,
    # }, ... ]
  end
end
