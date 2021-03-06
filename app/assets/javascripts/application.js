// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require cocoon
//= require_tree .

$(document).on('page:fetch', function() {
  $('#content').fadeOut('fast');
});

$(document).on('page:restore', function() {
  $('#content').fadeIn('slow');
});

$(document).on('click', '.dec-sort-vert', function() {
  $.getScript(this.href);
  return false;
});

$(function() {
  $(".alert-dismissible").fadeTo(4000, 500).animate({
    right: -parseInt($(this).width())
  }, 1500, function(){
    $(".alert-dismissible").alert('close');
  });
});
