const environment = require('./environment')

const config = environment.toWebpackConfig()

config.resolve.alias = {
  vue: "vue/dist/vue.js",
  'trix-vue2': 'trix-vue2/src/index.js'
}

// export the updated config
module.exports = config
