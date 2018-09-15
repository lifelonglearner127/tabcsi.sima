import {
  faArrowLeft, faArrowRight, faCheck, faChevronDown, faEnvelope, faFileUpload, faIdCard, faIndustry, faInfoCircle,
  faKey, faMapMarkerAlt, faPhone, faPlus, faSignOutAlt, faUser, faUserEdit, faUserPlus, faUsers, faUserTie, faUserTimes
} from '@fortawesome/free-solid-svg-icons'

import forEach from 'lodash/forEach'
import map from 'lodash/map'

const icons = [
  faArrowLeft,
  faArrowRight,
  faCheck,
  faChevronDown,
  faEnvelope,
  faFileUpload,
  faIdCard,
  faIndustry,
  faInfoCircle,
  faKey,
  faMapMarkerAlt,
  faPhone,
  faPlus,
  faSignOutAlt,
  faUser,
  faUserEdit,
  faUserPlus,
  faUsers,
  faUserTie,
  faUserTimes
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
