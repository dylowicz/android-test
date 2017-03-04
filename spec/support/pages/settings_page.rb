class SettingsPage
  include PageObject

  button(:back, name: 'Navigate up')
  button(:interface, name: 'Interface')
  button(:navigation, name: 'Navigation')
  button(:behaviors, name: 'Behaviors')

  module Interface
    include PageObject
    button(:simple_calendar, name: 'Simple calendar and time')
  end

  module Navigation
    include PageObject
    button(:dynamic_menu, name: 'Dynamic menu')
  end

  module Behaviors
    include PageObject
    button(:instant_search, name: 'Instant search')
    button(:error_reporting, name: 'Error reporting')
  end

  include Interface
  include Navigation
  include Behaviors

  def setup_app
    # Interface
    interface
      # Simple calendar and time ON
      simple_calendar
    back

    # Navigation
    navigation
      # Dynamic menu OFF
      dynamic_menu
    back

    # Behaviors
    behaviors
      # Instant search ON
      instant_search
      # Error reporting OFF
      error_reporting
    back

    back
  end
end
