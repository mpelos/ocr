jQuery ($) ->
  $("#image_file").change ->
    $("form").submit()

  setTimeout ->
    $(".original, .next").fadeIn()
  , 500

  $(".original").live "click", ->
    $(".saturated").fadeOut()
    $(".original").fadeIn ->
      $(".previous").hide()
      $(".next").show().text("Saturação >>").removeClass("binarize").addClass("saturate")

    return false

  $(".saturate").live "click", ->
    $(".original").fadeOut()
    $(".saturated").fadeIn ->
      $(".previous").show().text("<< Original").addClass("original")
      $(".next").hide()

    return false
