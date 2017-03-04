class MainPage
  include PageObject

  # Action bar
  button(:menu, name: 'drawer open')
  button(:search, id: 'it.feio.android.omninotes:id/menu_search')

  # Information
  paragraph(:empty_list_info, id: 'it.feio.android.omninotes:id/empty_list')

  def elements_count
    find_elements(id: 'it.feio.android.omninotes:id/note_date').count
  end
end
