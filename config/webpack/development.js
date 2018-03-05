const environment = require('./environment')

const config = environment.toWebpackConfig()

config.resolve.alias = {
  vue: "vue/dist/vue.js"
}

// export the updated config
module.exports = config
