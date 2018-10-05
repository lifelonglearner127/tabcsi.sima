module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [
    {
      loader: 'vue-loader',
      options: {
        transformAssetUrls: {
          'b-card-img': 'src',
          image: 'xlink:href',
          img: 'src',
          source: 'src',
          video: ['src', 'poster']
        }
      }
    }
  ]
}
