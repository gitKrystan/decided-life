$(document).on('blur', '.dec-table-form input[type=number]', function() {
  $(this).parent('form').submit();
});

$(function() {
  $('.dec-table-form input[type=submit]').remove();
});
