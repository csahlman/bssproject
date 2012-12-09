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
    if(link_urls.length === 0) {
      var source = $('#no-meetup-list').html();
      var template = Handlebars.compile(source);
      var html = template({
        zip : zipCode
      });
      $(html).insertAfter('#ajax-spinner');
    } else {
      console.log(link_urls);
      var source = $('#meetup-list').html();
      var template = Handlebars.compile(source);
      var html = template({
        zip : zipCode,
        urls : link_urls
      });
      $(html).insertAfter('#ajax-spinner');
    }
    $('#ajax-spinner').remove();
  }); 

  Handlebars.registerHelper('list', function(urls, options) {
    var out = "<ul id='meetups'>";

    for(var i=0, l=urls.length; i<l; i++) {
      out = out + "<li><a href='" + options.fn(urls[i]) + "'>Link</a></li>";
    }

    return out + "</ul>";
  });

});