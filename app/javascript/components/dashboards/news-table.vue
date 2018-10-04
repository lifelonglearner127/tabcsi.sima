<script>
export default {
  name: 'NewsTable',

  props: {
    items: {
      type: Array,
      required: true
    }
  },

  data () {
    return {
      fields: [
        'newsType',
        'subject',
        'content'
      ]
    }
  },

  methods: {}
}
</script>

<template>
  <b-table
    :fields="fields"
    :items="items"
    hover
    responsive
    striped
  >
    <template
      slot="newsType"
      slot-scope="data"
    >
      <b-form-checkbox
        :id="`news_${data.index}_selected`"
        v-model="data.item.selected"
      >
        {{ data.value }}
      </b-form-checkbox>
    </template>
  </b-table>
</template>

<style lang="scss" scoped>
</style>
