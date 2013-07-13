$(document).ready ->
  $("#keywords").tokenInput(window.tags,theme:"facebook", preventDuplicates:true)
  $("#keywords").change () ->
    $("#keywords").trigger('input');
  
