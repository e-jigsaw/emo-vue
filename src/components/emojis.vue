<template lang='jade'>
.emojis
  span(v-repeat='emoji: emojis', class='emo emo-margin emoji s_{{emojiClass(emoji.name)}}', data-emoji='{{emojiData(emoji)}}', v-on='click: show')
</template>

<script lang='coffee'>
module.exports =
  methods:
    emojiClass: (name)-> name.replace(/\+/g, '')
    emojiData: (emoji)-> JSON.stringify emoji
</script>
