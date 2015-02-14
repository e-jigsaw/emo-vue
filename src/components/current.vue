<template lang='jade'>
#info.emojis(v-if='emoji')
  p.current-container(v-on='click: copy')
    span(class='emo emoji v-align s_{{emojiClass(emoji.name)}}')
    input#currentInput.v-align(value=':{{emoji.name}}:')
  p
    span.tag.tag-blue {{emoji.unicode}}
    span.tag.tag-green(v-repeat='key: emoji.keywords', v-on='click: tagSearch') {{key}}
    a(href='https://github.com/jgsme/emo/edit/master/src/data/emojis.custom.ja.json'): span.tag.tag-red Add new one?
</template>

<script lang='coffee'>
module.exports =
  methods:
    emojiClass: (name)-> name.replace(/\+/g, '')
    copy: -> document.getElementById('currentInput').select()
</script>
