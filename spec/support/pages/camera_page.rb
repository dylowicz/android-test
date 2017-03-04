class CameraPage
  include PageObject

  button(:shutter, id: 'com.android.camera:id/shutter_button')
  button(:accept, id: 'com.android.camera:id/btn_done')

  def take_photo
    shutter
    accept
  end
end
