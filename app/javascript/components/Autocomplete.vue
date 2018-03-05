<template>
  <vue-instant :suggestion-attribute="suggestionAttribute"
               :show-autocomplete="true"
               :autofocus="true"
               :suggestions="suggestions"
               :disabled="false"
               v-model="value"
               placeholder="Search ..."
               type="google"
               @input="changed"
               @enter="enter">
  </vue-instant>
</template>

<script>
import Vue from 'vue';

import VueInstant from 'vue-instant';
import 'vue-instant/dist/vue-instant.css';
Vue.use(VueInstant);

import axios from 'axios';

export default {
  props: ['init-value'],

  data: function() {
    return {
      value: this.initValue || '',
      suggestionAttribute: 'value',
      suggestions: []
    }
  },

  methods: {
    enter: function() {
      Turbolinks.visit("/posts?q=" + this.value)
    },

    changed: function() {
      axios.get('/posts/autocomplete?q=' + this.value,  { headers: { Accept: 'application/json' } })
        .then(response => {
          this.suggestions = response.data;
        })
    }
  },
}
</script>
