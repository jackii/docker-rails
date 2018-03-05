<template lang="html">
  <div>
    <table class="table table-hover">
      <thead class="thead-inverse">
        <th>Content</th>
        <th class="text-right text-nowrap d-none d-md-table-cell">Last Update</th>
      </thead>

      <tbody>
        <tr v-for="post in posts" :data-href="'/posts/' + post.slug">
          <td class="js-row-link">
            <i v-if="post.clips_count > 0" class="fas fa-image"/>
            <strong v-html="post.title"></strong>
            <span v-html="post.content"></span>
          </td>

          <td class="js-row-link text-right d-none d-md-table-cell text-nowrap">
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
    saveForm() {
      axios.post('/posts')
    },

    loadNextPage () {
      this.currentPage++
      return axios.get('/posts.json?page=' + this.currentPage)
    },

    infiniteHandler ($state) {
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
