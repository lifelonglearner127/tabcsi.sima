import bPagination from 'bootstrap-vue/es/components/pagination/pagination'
import bTable from 'bootstrap-vue/es/components/table/table'
import map from 'lodash/map'

// @vue/component
export default {
  name: 'DashboardTable',

  props: {
    fields: {
      type: [Object, Array],
      required: true
    },
    items: {
      type: Array,
      required: true
    },
    class: {
      type: String,
      default: null
    }
  },

  data () {
    return {
      currentPage: 1,
      perPage: 10
    }
  },

  computed: {
    totalRows () {
      return this.items.length
    }
  },

  render (h) {
    let defaultSlot
    let paginationContainer

    defaultSlot = []
    if (this.$slots.default) {
      defaultSlot = this.$slots.default

      delete this.$slots.default
    }

    const slots = map(this.$slots, (slot, key) => h('template', { slot: key }, slot))
    const table = h(
      bTable,
      {
        props: {
          currentPage: this.currentPage,
          fields: this.fields,
          hover: true,
          items: this.items,
          perPage: this.perPage,
          responsive: true,
          striped: true,
          totalRows: this.totalRows,
          class: this.class
        },
        scopedSlots: this.$scopedSlots
      },
      slots
    )

    paginationContainer = h(false)
    if (this.totalRows > 0) {
      const pagination = h(bPagination, {
        on: {
          input: (value) => {
            this.currentPage = value
          }
        },
        props: {
          perPage: this.perPage,
          totalRows: this.totalRows,
          value: this.currentPage
        }
      })

      const paginationBlock = h('div', { class: 'd-inline-block' }, [pagination])

      paginationContainer = h('div', { class: 'my-3 text-center' }, [paginationBlock])
    }

    return h('div', [table, paginationContainer, ...defaultSlot])
  }
}
