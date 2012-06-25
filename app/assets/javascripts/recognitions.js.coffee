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
    $(".saturated, .highlighted").fadeOut()
    $(".binarized").fadeIn ->
      $(".control").removeClass("binarize")
      $(".previous").show().text("<< Saturação").attr("class", "previous control saturate")
      $(".next").show().text("Destacar").attr("class", "next control highlight")
    false

  $(".highlight").live "click", ->
    $(".highlighted").fadeIn ->
      $(".binarized").hide()
      $(".control").removeClass("highlight")
      $(".previous").show().text("<< Binarizar").attr("class", "previous control binarize")
      $(".next").show().text("Reconhecer").attr("class", "next control recognize")

    $(".highlighted").animate
      top: 0
    , "fast", ->
      $(".characters").hide()

    false

  $(".recognize").live "click", ->
    $(".characters").show()
    $(".highlighted").animate
      top: $(".characters").height() + 30

    $(".control").removeClass("recognize")
    $(".previous").show().text("<< Binarizar").attr("class", "previous control highlight")
    $(".next").hide().attr("class", "next control")
    false

