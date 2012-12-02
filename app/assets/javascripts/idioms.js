$(document).ready(function() {
  $('#new_report').hide();
  $('#meetups').hide();

  $('#report_abuse').toggle(function() {
    $(this).text('HIDE THIS FORM');
    $('#new_report').fadeIn('fast');
  }, function() {
    $(this).text('REPORT IT');
    $('#new_report').fadeOut('fast');
  });

  $('#display_meetups').on("click", function(e) {
    e.preventDefault();
    $('#meetups').show();
  });
});