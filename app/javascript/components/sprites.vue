<script>
import { iconMap } from '~/plugins/font-awesome'

export default {
  name: 'Sprites',

  data () {
    return { icons: iconMap }
  }
}
</script>

<template>
  <div class="d-none">
    <fa-icon
      v-for="(icon, name) in icons"
      :icon="icon"
      :key="name"
      :symbol="name"
    >
    </fa-icon>
  </div>
</template>

<style lang="scss" scoped>
</style>
