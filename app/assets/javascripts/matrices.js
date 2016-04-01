var tableFormInputs = '.dec-table-form input[type=text]';
var numberOnlyInputs = 'input.dec-numbers-only[type=text]';

$(document).on('blur', tableFormInputs, function() {
  $(this).parent('form').submit();
});

$(document).on('keypress', numberOnlyInputs, function(event) {
  if (!event.which) return true;
  character = String.fromCharCode(event.which);
  return (/[\d]/.test(character));
});

$(function() {
  $('.dec-table-form input[type=submit]').remove();
  $(tableFormInputs).first().focus();
});
