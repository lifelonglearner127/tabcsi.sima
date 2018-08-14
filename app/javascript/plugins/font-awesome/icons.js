import {
  faArrowRight, faEnvelope, faIdCard, faIndustry, faInfoCircle, faPhone, faUser, faUserTie
} from '@fortawesome/free-solid-svg-icons'
import forEach from 'lodash/forEach'
import map from 'lodash/map'

const icons = [
  faArrowRight,
  faEnvelope,
  faIdCard,
  faIndustry,
  faInfoCircle,
  faPhone,
  faUser,
  faUserTie
]

const iconMap = {}

forEach(
  map(icons, (icon) => [icon.prefix, icon.iconName]),
  (icon) => {
    const [prefix, iconName] = icon
    const name = `${prefix}-fa-${iconName}`

    iconMap[name] = icon
  }
)

export { iconMap }

export default icons
