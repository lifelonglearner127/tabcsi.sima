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
    sortBy: {
      type: String,
      default: null
    },
    sortCompare: {
      type: Function,
      default: null
    },
    tableClass: {
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
        class: this.tableClass,
        props: {
          currentPage: this.currentPage,
          emptyText: 'There are no records to show.',
          fields: this.fields,
          hover: true,
          items: this.items,
          perPage: this.perPage,
          responsive: true,
          showEmpty: true,
          sortBy: this.sortBy,
          sortCompare: this.sortCompare,
          striped: true,
          totalRows: this.totalRows
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
