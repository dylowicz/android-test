class ErrorPage
  include PageObject

  paragraph(:message, id: 'android:id/message')
  button(:ok, id: 'android:id/button1')

  def ignore
    ok
  end
end
