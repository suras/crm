  $(document).ready ->
    checked = true
    $("#keywords").tokenInput(window.tags,
      theme: "facebook")
    $("#selectAll").click () ->
      if(checked)
        $("#search_result input[type=checkbox]").attr("checked","checked")
      else
        $("#search_result input[type=checkbox]:checked").removeAttr("checked")
      checked= !checked
    false