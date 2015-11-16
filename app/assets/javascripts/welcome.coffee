$ ->
  $(".ajax").on "ajax:success", (data) ->
    console.log data
    # alert "saADSAD"
  .on "ajax:error", (error, status, e, data) ->
    # alert "111"
    console.log error
    console.log status
    console.log e
    # console.log data
