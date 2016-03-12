c = console

BEACON_NEAR = false
PAID        = false

# PAID + BEACON_NEAR


countd = ->
  time = Number $("span.timer").html()
  time -= 1
  $("span.timer").html time
  if time < 0
    $(".timed_message").hide()
  else
    setTimeout countd, 1000

nearCb = ->
  $(".idle").hide()
  $(".near").show()   # animation appear
  pollPay()

nearCbThrott = _.throttle nearCb, 500


paidCb = ->
  $(".near").hide()
  $(".bought").show()   # animation appear
  countd()



doPollPay = ->
  $.getJSON "http://#{SERVER_HOST}:3000/payment_status", (resp) ->
    c.log "payment_status", resp
    if resp.success && resp.status == "paid"
      c.log "PAY"
      PAID = true
      paidCb()


    pollPay() unless PAID

doPollPayThrott = _.throttle doPollPay, 800

pollPay = ->
  _.delay doPollPayThrott, 1000



$("body").on "beacon_near", (evt) =>
  if !BEACON_NEAR
    c.log "BEACON NEAR: #{BEACON_NEAR}"
    nearCbThrott()

  BEACON_NEAR = true


$ ->
  $(".idle").show()

  if PAID

    $(".near").show()   # animation appear
    $(".bought").hide() # animation appear
