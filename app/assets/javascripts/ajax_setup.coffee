jQuery.ajaxSetup
  beforeSend: (_, settings) -> settings.async = true
  statusCode:
    401: -> alert "Your session has expired. Please log in again."
    403: -> alert "Sorry, You are not authorised to access this page."