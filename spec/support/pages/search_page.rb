class SearchPage
  include PageObject

  text_field(:input, id: 'it.feio.android.omninotes:id/search_src_text')
  button(:back, name: 'Collapse')

  def search_for(word)
    input_element.send_keys word
  end
end
