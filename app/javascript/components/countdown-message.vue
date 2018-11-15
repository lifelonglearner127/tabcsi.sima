<script>
const SECONDS_IN_MINUTE = 60
const INTERVAL_DURATION = 1000 // milliseconds

export default {
  name: 'CountdownMessage',

  props: {
    messageFormatter: {
      type: Function,
      required: true
    },
    startingSeconds: {
      type: Number,
      required: true
    }
  },

  data () {
    return {
      interval: null,
      remainingSeconds: 0
    }
  },

  computed: {
    message () {
      return this.messageFormatter(this.formatSeconds(this.remainingSeconds))
    }
  },

  mounted () {
    // if (this.interval != null) {
    //   return
    // }

    this.remainingSeconds = this.startingSeconds
    this.interval = setInterval(
      () => {
        if (--this.remainingSeconds < 0) {
          clearInterval(this.interval)

          this.remainingSeconds = 0
        }
      },
      INTERVAL_DURATION
    )
  },

  methods: {
    formatSeconds (seconds) {
      let minutes

      minutes = Math.floor(seconds / SECONDS_IN_MINUTE)
      seconds %= SECONDS_IN_MINUTE

      const word = minutes === 1 && seconds === 0 ? 'minute' : 'minutes'

      /* eslint-disable no-magic-numbers */
      if (minutes < 10) {
        minutes = `0${minutes}`
      }

      if (seconds < 10) {
        seconds = `0${seconds}`
      }
      /* eslint-enable no-magic-numbers */

      return `${minutes}:${seconds} ${word}`
    }
  }
}
</script>

<template>
  <span>{{ message }}</span>
</template>

<style lang="scss" scoped>
</style>
