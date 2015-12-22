// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.atwho
//= require bootstrap-sprockets
//= require bootstrap
//= require template/metisMenu
//= require template/metisMenu
//= require template/raphael
//= require template/morris
//= require template/flot/excanvas
//= require template/flot/jquery.flot
//= require template/flot/jquery.flot.pie
//= require template/flot/jquery.flot.resize
//= require template/flot/jquery.flot.time
//= require template/flot/jquery.flot.tooltip
//= require template/jquery.dataTables
//= require template/dataTables.bootstrap
//= require template/sb-admin-2
//= require jquery.steps.min
//= require jquery.validate.min
//= require froala_editor.min
//= require_tree .

$(function(){
    $('[data-behavior="autocomplete"]').atwho({at:"@", 'data':"/users"});
});
