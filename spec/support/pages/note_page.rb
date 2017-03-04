class NotePage < ElementPage
  include PageObject

  text_field(:content, id: 'it.feio.android.omninotes:id/detail_content')

  def add_note(title=nil, content=nil)
    title_element.when_present.send_keys title if title
    content_element.when_present.send_keys content if content
    add
  end

  def add_note_with_photo(title=nil, content=nil)
    title_element.when_present.send_keys title if title
    hide_keyboard
    content_element.when_present.send_keys content if content
    add
  end

  def change_content(content=nil)
    content_element.when_present.clear
    content_element.when_present.send_keys content if content
    add
  end
end
