$(document).ready(function() {
  $('#previous').hide()

  $('#old_announcements').toggle(function() {
    $('#previous').show()
    $(this).text("Hide old announcements")
  }, function() {
    $('#previous').hide()
    $(this).text("View all other announcements")
  })
});