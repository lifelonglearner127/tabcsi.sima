import forEach from 'lodash/forEach'
import map from 'lodash/map'

const iconMap = {}

export const buildIconMap = (icons) => {
  forEach(map(icons, (icon) => [icon.prefix, icon.iconName]), (icon) => {
    const [prefix, iconName] = icon
    const name = `${prefix}-fa-${iconName}`

    iconMap[name] = icon
  })
}

export default iconMap
