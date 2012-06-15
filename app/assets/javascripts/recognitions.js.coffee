jQuery ($) ->
  $("#image_file").change ->
    $("form").submit()

  setTimeout ->
    $(".original, .next").fadeIn()
  , 500

  $(".original").live "click", ->
    $(".saturated").fadeOut()
    $(".original").fadeIn ->
      $(".control").removeClass("original")
      $(".previous").hide().attr("class", "previous control")
      $(".next").show().text("Saturação >>").attr("class", "next control saturate")
    false

  $(".saturate").live "click", ->
    $(".original, .binarized").fadeOut()
    $(".saturated").fadeIn ->
      $(".control").removeClass("saturate")
      $(".previous").show().text("<< Original").attr("class", "previous control original")
      $(".next").show().text("Binarizar >>").attr("class", "next control binarize")
    false

  $(".binarize").live "click", ->
    $(".saturated").fadeOut()
    $(".binarized").fadeIn ->
      $(".control").removeClass("binarize")
      $(".previous").show().text("<< Saturação").attr("class", "previous control saturate")
      $(".next").hide().attr("class", "next control")
    false
