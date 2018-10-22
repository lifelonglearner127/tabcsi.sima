<script>
export default {
  name: 'TabcCard',

  props: {
    cols: {
      type: [String, Number],
      default: '12'
    },
    lg: {
      type: [Boolean, String, Number],
      default: false
    },
    md: {
      type: [Boolean, String, Number],
      default: false
    },
    sm: {
      type: [Boolean, String, Number],
      default: false
    },
    title: {
      type: String,
      required: true
    },
    xl: {
      type: [Boolean, String, Number],
      default: false
    }
  }
}
</script>

<template>
  <b-container class="h-100">
    <b-row
      align-h="center"
      class="container-row"
    >
      <b-col
        :cols="cols"
        :lg="lg"
        :md="md"
        :sm="sm"
        :xl="xl"
      >
        <b-card
          class="my-3"
          header-class="py-4"
          :title="title"
          title-tag="h5"
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

          <slot />
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';
@import '~bootstrap/scss/mixins';

.container-row {
  height: 100% !important;
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

@include media-breakpoint-down(xs) {
  .card-img-top {
    width: 245px;
  }
}

.card-title {
  text-align: center;
}
</style>
