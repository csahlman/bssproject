$(document).ready(function() {
  
  var zipCodeJson = $('#zip_code').html(); 
  var zipCode = $.parseJSON(zipCodeJson); 

  var idiomIdJson = $('#idiom_id').html(),
      idiomId = $.parseJSON(idiomIdJson);


  $('#new_report').hide();
  $('#meetups').hide();

  $('#report_abuse').toggle(function() {
    $(this).text('HIDE THIS FORM');
    $('#new_report').fadeIn('fast');
  }, function() {
    $(this).text('REPORT IT');
    $('#new_report').fadeOut('fast');
  });


  var meetupRequest = $.ajax({
    type: 'POST',
    url: '/meetups',
    data: { zip_code: zipCode, 
            idiom_id: idiomId 
    },
    dataType: 'json'
  });

  meetupRequest.done(function(link_urls) {
    $.each(link_urls, function(index, value) {
      console.log(index + ":" + value);
    });
  }); 

});