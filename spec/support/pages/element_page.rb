class ElementPage
  include PageObject

  # Action bar
  button(:add, name: 'drawer open')
  button(:attachment, id: 'it.feio.android.omninotes:id/menu_attachment')
  button(:category, id: 'it.feio.android.omninotes:id/menu_category')
  button(:tag, id: 'it.feio.android.omninotes:id/tag_marker')
  button(:share, id: 'it.feio.android.omninotes:id/menu_share')
  button(:more_options, name: 'More options')
  button(:discard, name: 'Discard changes')

  module MoreOptions
    include PageObject
    paragraph(:delete, name: 'Trash')
    paragraph(:archive, name: 'Archive')
  end

  # Content
  text_field(:title, id: 'it.feio.android.omninotes:id/detail_title')
  button(:reminder, name: 'Add reminder')
  paragraph(:reminder_info, id: 'it.feio.android.omninotes:id/datetime')

  include MoreOptions
  def delete
    more_options
    delete_element.click
  end

  def archive
    more_options
    archive_element.click
  end

  def discard_changes
    more_options_element.when_present.click
    discard_element.when_present.click
  end

  def change_title(title)
    title_element.when_present.clear
    title_element.when_present.send_keys title
    add
  end

  def set_reminder
    reminder
  end

  def update
    add
  end

  def add_empty
    add
  end
end
