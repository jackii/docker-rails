<template lang="html">
  <div>
    <table class="table table-hover">
      <thead class="thead-inverse">
        <th>Content</th>
        <th class="text-right text-nowrap d-none d-md-table-cell">Last Update</th>
      </thead>

      <tbody>
        <tr v-for="post in posts">
          <td @click="clickRow(post)">
            <i v-if="post.clips_count > 0" class="fas fa-image"/>
            <strong v-html="post.title"></strong>
            <span v-html="post.content"></span>
          </td>

          <td class="text-right d-none d-md-table-cell text-nowrap" @click="clickRow(post)">
            <timeago class="badge badge-secondary" :since="post.updated_at" />
          </td>
        </tr>
      </tbody>
    </table>

    <infinite-loading @infinite="infiniteHandler"></infinite-loading>
  </div>
</template>

<script>
import InfiniteLoading from 'vue-infinite-loading';
import axios from 'axios';

export default {
  props: ['firstPosts'],

  components: {
    InfiniteLoading,
  },

  data() {
    return {
      posts: this.firstPosts,
      currentPage: 1
    };
  },

  methods: {
    clickRow(post) {
      Turbolinks.visit('/posts/' + post.slug)
    },

    loadNextPage () {
      let uri = window.location.search.substring(1);
      let params = new URLSearchParams(uri);

      this.currentPage++
      return axios.get('/posts.json', {
        params: {
          page: this.currentPage,
          q: params.get('q')
        }
      })
    },

    infiniteHandler ($state) {
      if (this.posts.length < 25) {
        // There is no next page
        $state.loaded()
        $state.complete()
        return;
      }

      this.loadNextPage().then(response => {
        if (response.data.length > 0) {
          this.posts.push(...response.data)
          $state.loaded()
        } else {
          $state.complete()
        };
      })
    }
  }
}
</script>

<style lang="sass">
  td
    cursor: pointer

    em
      font-weight: bold
      font-style: normal
</style>
