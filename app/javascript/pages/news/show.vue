<script>
import logo from '~/assets/images/logo-white.png'
import PageMixin from '~/mixins/page'

export default {
  name: 'ShowNews',

  mixins: [PageMixin],

  data () {
    return { news: this.pageOptions.news }
  },

  computed: {
    logoSrc () {
      return logo
    },
    editNewsURL () {
      return `/news/${this.news.id}/edit`
    }
  }
}
</script>

<template>
  <b-container class="h-100">
    <b-row
      align-h="center"
      align-v="center"
      class="row-fluid"
    >
      <b-col
        :cols="12"
        :sm="6"
      >
        <b-card
          header-class="py-4"
        >
          <a
            slot="header"
            href="/"
          >
            <b-card-img
              :src="logoSrc"
              alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
              top
            />
          </a>
          <h5>{{ news.subject }}</h5>
          <div v-html="news.content" />
          <b-button
            href="/"
            class="my-4"
            variant="secondary"
          >
            Back
          </b-button>
          <b-button
            :href="editNewsURL"
            class="my-4"
            variant="tabc-primary"
          >
            Edit
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
  @import '~@/assets/stylesheets/variables';

  .row-fluid {
    min-height: 100%;
  }

  .card {
    box-shadow: 3px 3px 20px rgba(0, 0, 0, 0.5);
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
</style>
