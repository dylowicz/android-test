class ReminderPage
  include PageObject

  button(:ok, name: 'OK')
  button(:done, id: 'it.feio.android.omninotes:id/done')

  def set
    ok
    ok
    done
  end
end
