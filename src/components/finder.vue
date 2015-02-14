<template lang='jade'>
form.pure-form(v-on='submit: submit')
  input#in(v-on='keyup: search', autofocus)
</template>

<script lang='coffee'>
module.exports =
  methods:
    submit: -> false
</script>
