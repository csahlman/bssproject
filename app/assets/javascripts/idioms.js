$(document).ready(function() {
  $('#new_report').hide()

  $('#report_abuse').toggle(function() {
    $(this).text('HIDE THIS FORM')
    $('#new_report').fadeIn('fast')
  }, function() {
    $(this).text('REPORT IT')
    $('#new_report').fadeOut('fast')
  });
});