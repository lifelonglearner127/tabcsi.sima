<script>
import iconMap from './icon-map'

export default {
  name: 'FaSprites',

  data () {
    return { icons: iconMap }
  }
}
</script>

<template>
  <div class="d-none">
    <fa-icon
      v-for="(icon, name) in icons"
      :key="name"
      :icon="icon"
      :symbol="name"
    />
  </div>
</template>

<style lang="scss" scoped>
</style>
