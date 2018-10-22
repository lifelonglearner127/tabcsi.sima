<script>
import PageMixin from '~/mixins/page'

export default {
  name: 'ShowNews',

  mixins: [PageMixin],

  data () {
    return { news: this.pageOptions.news }
  }
}
</script>

<template>
  <b-container class="h-100">
    <b-row
      align-h="center"
      class="h-100"
    >
      <b-col
        :md="6"
        :sm="9"
        :xs="12"
      >
        <b-card
          class="my-3"
          header-class="py-4"
          :title="news.subject"
        >
          <a
            slot="header"
            href="/"
          >
            <b-card-img
              alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
              src="@/assets/images/logo-white.png"
              top
            />
          </a>
          <div
            class="news-content"
            v-html="news.content"
          />
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.card {
  box-shadow: 3px 3px 20px rgba(0, 0, 0, 0.5);
  min-width: 342px;
}

.card-header {
  background-color: $tabc-dark-blue;
  border-bottom-width: 0;
  color: $white;
  text-align: center;
}

.card-img-top {
  width: 300px;
}

.card-title {
  text-align: center;
}

/deep/ .news-content {
  img {
    max-width: 100%;
    height: auto
  }
}
</style>
