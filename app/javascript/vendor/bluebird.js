import Bluebird from 'bluebird'

Bluebird._isBluebird = true
window.Promise = Bluebird
