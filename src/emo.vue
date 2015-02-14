<template lang='jade'>
div(v-component='finder', v-with='search: search')
div(v-component='current', v-with='emoji: current, tagSearch: tagSearch')
div(v-component='emojis', v-with='emojis: emojis.toArray(), show: show')
</template>

<script lang='coffee'>
aja = require 'aja'
Immutable = require 'immutable'
module.exports =
  components:
    finder: require './components/finder'
    current: require './components/current'
    emojis: require './components/emojis'
  data:
    original: Immutable.List()
    emojis: Immutable.List()
  ready: ->
    aja()
      .method 'get'
      .url '//cdn.rawgit.com/jgsme/emo/gh-pages/data/emojis.json'
      .on 'success', (emojis)=>
        emojis = emojis.map (emoji)->
          emoji.unicode = emoji.keywords[emoji.keywords.length - 1]
          emoji.keywords = emoji.keywords.slice 0, -1
          emoji.forSearch = [emoji.name].concat(emoji.keywords).join(',')
          emoji
        original = Immutable.List emojis
        @$set 'original', original
        @$set 'emojis', original
      .go()
  methods:
    search: (event)->
      r = new RegExp event.target.value.replace /[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, '\\$&'
      @$set 'emojis', @.$data.original.filter (emoji)-> emoji.forSearch.search(r) isnt -1
    tagSearch: (event)->
      document.getElementById('in').value = event.target.innerText
      @search
        target:
          value: event.target.innerText
    show: (event)->
      @$set 'current', JSON.parse(event.target.getAttribute('data-emoji'))
</script>
