//= require_tree ./vendor
//= require_self
//= require nighthawks

window.NAIVE =
  initialize: (game) ->
    console.log("hi", game)


$ ->
  NAIVE.initialize(Nighthawks)