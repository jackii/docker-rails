/* eslint no-console:0 */
console.log('Hello World from Webpacker');

import Vue from 'vue';
import TurbolinksAdapter from 'vue-turbolinks';
import VueTimeago from 'vue-timeago';
import VueSilentbox from 'vue-silentbox';

Vue.use(TurbolinksAdapter);
Vue.use(VueTimeago, {
  name: 'timeago',
  locale: 'en-US',
  locales: {
    'en-US': require('vue-timeago/locales/en-US.json')
  }
});
Vue.use(VueSilentbox);

Vue.config.ignoredElements = ['trix-editor'];

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#main',
  });
});
